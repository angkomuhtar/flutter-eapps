import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/clock_today_model.dart';
import 'package:flutter_eapps/core/models/radius_model.dart';
import 'package:flutter_eapps/modules/attendance/attendance_provider.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendancePageState();
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied');
  }

  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
  );
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  Position? _lastPosition;
  bool _isLoading = true;
  bool _isWithinRadius = false;
  int _locationId = 0;
  Shift? _selectedShift = null;
  int _selectedShiftId = 0;
  bool _absenceLoading = false;

  bool _checkIfWithinRadius(LatLng currentPos, List<RadiusModel> radiusList) {
    for (final radius in radiusList) {
      final distance = Geolocator.distanceBetween(
        currentPos.latitude,
        currentPos.longitude,
        radius.latitude,
        radius.longitude,
      );
      if (distance <= radius.radius) {
        setState(() {
          _locationId = radius.id;
        });
        return true;
      }
    }
    return false;
  }

  bool _isLocationSuspicious(Position position) {
    // Android: langsung cek isMocked
    print(
      'accuracy=${position.accuracy}, speed=${position.speed}, altitude=${position.altitude}, altitudeAccuracy=${position.altitudeAccuracy}',
    );
    if (position.isMocked) {
      print('Mock location detected (isMocked=true)');
      return true;
    }

    // Accuracy terlalu sempurna (0) biasanya fake
    if (position.accuracy == 0) {
      print('Suspicious location detected (accuracy=0)');
      return true;
    }

    // Speed tidak masuk akal (> 500 km/h = 138 m/s)
    if (position.speed > 138) {
      print('Suspicious location detected (speed>${position.speed})');
      return true;
    }

    // Altitude dan altitudeAccuracy keduanya 0 (suspicious)
    if (position.altitude == 0 && position.altitudeAccuracy == 0) {
      print('Suspicious location detected (altitude=0 && altitudeAccuracy=0)');
      return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await determinePosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _lastPosition = position;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleClockAction(String type) async {
    await _getCurrentLocation();

    if (_currentPosition == null) {
      AlertWidget.show(
        context: context,
        type: 'error',
        title: 'Kesalahan',
        description: 'Gagal mendapatkan lokasi saat ini.',
        okText: 'Oke',
      );
      return;
    }

    if (_selectedShift == null && type == 'in') {
      AlertWidget.show(
        context: context,
        type: 'error',
        title: 'Shift Belum Dipilih',
        description: 'Silakan pilih shift terlebih dahulu.',
        okText: 'Oke',
      );
      return;
    }

    if (!_isWithinRadius) {
      AlertWidget.show(
        context: context,
        type: 'error',
        title: 'Diluar Area',
        description:
            'Anda berada diluar area yang diizinkan untuk melakukan clock.',
        okText: 'Oke',
      );
      return;
    }

    if (_isLocationSuspicious(_lastPosition!)) {
      if (kReleaseMode) {
        AlertWidget.show(
          context: context,
          type: 'fatal',
          title: 'Lokasi Tidak Valid',
          description:
              'Mock location terdeteksi. Pastikan GPS Anda asli atau hubungi administrator.',
          okText: 'Oke',
        );
        return;
      }
    }

    try {
      if (type == 'in') {
        await ref
            .read(clockInOutProvider.notifier)
            .clock_in_out(
              date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              type: type,
              shift: _selectedShift!.id,
              location: _locationId,
            );
        AlertWidget.show(
          context: context,
          type: 'success',
          title: 'Sukses',
          description: 'Berhasil melakukan clock $type.',
          okText: 'Oke',
        );
      } else {
        AlertWidget.show(
          context: context,
          type: 'warning',
          title: 'Konfirmasi',
          description: 'Apakah Anda yakin ingin melakukan clock out Sekarang?',
          okText: 'Ya',
          cancelText: 'Tidak',
        ).then((confirmed) async {
          if (confirmed == true) {
            await ref
                .read(clockInOutProvider.notifier)
                .clock_in_out(
                  date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  type: type,
                  shift: _selectedShiftId,
                  location: _locationId,
                );
          }
          ref.invalidate(todayAttendanceProvider);
        });
      }
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data ?? e.message;
        AlertWidget.show(
          context: context,
          type: 'error',
          title: 'Kesalahan',
          description:
              'Gagal melakukan clock $type: ${errorData['message'] ?? 'Terjadi kesalahan. Silakan coba lagi.'}',
          okText: 'Oke',
        );
      } else {
        print('Clock $type error: $e');
      }
      print(e);
    } finally {
      ref.invalidate(todayAttendanceProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayAsync = ref.watch(todayAttendanceProvider);
    final radiusAsync = ref.watch(allowedRadiusProvider);
    final shiftAsync = ref.watch(listShiftProvider);

    final radiusList = radiusAsync.value ?? [];
    if (_currentPosition != null && radiusList.isNotEmpty) {
      _isWithinRadius = _checkIfWithinRadius(_currentPosition!, radiusList);
    }

    ref.listen(todayAttendanceProvider, (previous, next) {
      if (next.hasValue && next.value?.shift != null) {
        setState(() {
          _selectedShift = next.value?.shift as Shift;
          _selectedShiftId = next.value?.shift?.id ?? 0;
        });
      }
    });

    final today = todayAsync.value;
    final shiftList = shiftAsync.value ?? [];

    final hasClockIn = today?.check_in != null;
    final hasClockOut = today?.check_out != null;

    debugPrint(
      'Today attendance: ${today?.shift?.name}, check_in: ${today?.check_in}, check_out: ${today?.check_out}',
    );

    return Scaffold(
      body: _isLoading || radiusAsync.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingWidget(),
                  Text(
                    'Getting current location...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            initialCameraPosition: CameraPosition(
                              target: _currentPosition ?? const LatLng(0, 0),
                              zoom: 20,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                            circles: radiusList.map((r) {
                              return Circle(
                                circleId: CircleId(r.id.toString()),
                                center: LatLng(r.latitude, r.longitude),
                                radius: r.radius.toDouble(),
                                fillColor: AppColors.primary.withValues(
                                  alpha: 0.5,
                                ),
                                strokeColor: AppColors.primary,
                                strokeWidth: 1,
                              );
                            }).toSet(),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 8,
                              ),
                              child: SafeArea(
                                top: true,
                                bottom: false,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FloatingActionButton(
                                      mini: true,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.my_location,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () {
                                        // move camera ke current location
                                        mapController.animateCamera(
                                          CameraUpdate.newLatLng(
                                            _currentPosition ??
                                                const LatLng(0, 0),
                                          ),
                                        );
                                      },
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.push('/absence-history');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.white,
                                        shadowColor: AppColors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.receipt_long,
                                            size: 20,
                                            color: AppColors.primary,
                                          ),
                                          Gap(6),
                                          Text(
                                            'History',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        bottom: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            today?.check_in != null
                                ? Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Shift',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              '${today!.shift?.name} (${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(today.shift!.start))} - ${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(today!.shift!.end))})',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gap(12),
                                      Row(
                                        spacing: 22,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                border: BoxBorder.all(
                                                  color: AppColors.success,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Masuk',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${DateFormat('HH:mm a').format(DateTime.parse(today.check_in!))}',
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                border: BoxBorder.all(
                                                  color: AppColors.success,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Pulang',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    today.check_out != null
                                                        ? '${DateFormat('HH:mm a').format(DateTime.parse(today.check_out!))}'
                                                        : '--:-- --',
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : DropdownWidget<Shift>(
                                    labelText: 'Pilih Shift',
                                    value: _selectedShift,
                                    items: shiftList,
                                    itemLabel: (shift) =>
                                        '${shift.name} (${shift.start} - ${shift.end})',
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedShift = value;
                                      });
                                    },
                                  ),
                            const Gap(12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: hasClockIn
                                        ? null
                                        : () async {
                                            try {
                                              setState(() {
                                                _absenceLoading = true;
                                              });
                                              await _handleClockAction('in');
                                            } finally {
                                              setState(() {
                                                _absenceLoading = false;
                                              });
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.success,
                                      disabledBackgroundColor: AppColors.grey,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'MASUK',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: hasClockIn && !hasClockOut
                                        ? () {
                                            try {
                                              setState(() {
                                                _absenceLoading = true;
                                              });
                                              _handleClockAction('out');
                                            } finally {
                                              setState(() {
                                                _absenceLoading = false;
                                              });
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      disabledBackgroundColor: AppColors.grey,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'PULANG',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                _absenceLoading
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.5),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                  'assets/lottie/loading.json',
                                  width: 200,
                                  height: 150,
                                  repeat: true,
                                ),
                                Text(
                                  'Mohon Tunggu...',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
    );
  }
}
