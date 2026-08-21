import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/options_model.dart';
import 'package:flutter_eapps/core/models/units_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:flutter_eapps/modules/daily_activity/daily_activity_page.dart';
import 'package:flutter_eapps/modules/daily_activity/daily_activity_provider.dart';
// import 'package:flutter_eapps/modules/hazard/hazard_page.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as Picker;

class AddDailyActivityScreen extends ConsumerStatefulWidget {
  const AddDailyActivityScreen({super.key});

  @override
  ConsumerState<AddDailyActivityScreen> createState() =>
      _AddDailyActivityScreenState();
}

class Options {
  final String value;
  final String label;
  const Options({required this.value, required this.label});
}

const _categoryOptions = [
  Options(value: 'UNIT', label: 'UNIT'),
  Options(value: 'NON UNIT', label: 'NON UNIT'),
];

const _statusunitOptions = [
  Options(value: 'BD', label: 'Breakdown'),
  Options(value: 'STB', label: 'Standby'),
  Options(value: 'RFU', label: 'Ready'),
];

class _AddDailyActivityScreenState
    extends ConsumerState<AddDailyActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final _searchController = TextEditingController();
  final _startTime = TextEditingController();
  final _endTime = TextEditingController();
  final _duration = TextEditingController();
  final _unitController = TextEditingController();

  String durasi = '';
  HazardLocationModel? _selectedHazardLocation;
  File? selectedImage;
  DateTime? selectedDate;
  Options? _selectedCategory;
  Options? _selectedStatusUnit;
  DateTime? startTime = null;
  DateTime? endTime = null;
  UnitsModel? selectedUnit = null;

  int getDurationInMinutes(DateTime start, DateTime end) {
    return end.difference(start).inMinutes;
  }

  String formatDurationHumanReadable(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours jam $minutes menit';
    }
    return '$minutes menit';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    LoadingWidget.show(context, message: 'Menyimpan aktivitas harian...');

    final (success, errorMessage) = await ref
        .read(saveActivityProvider.notifier)
        .save(_formData);

    print(_formData);

    if (!mounted) return;

    LoadingWidget.hide(context);

    if (success) {
      _formKey.currentState!.reset();
      setState(() {
        _selectedHazardLocation = null;
        _selectedCategory = null;
        _selectedStatusUnit = null;
        selectedImage = null;
        selectedDate = null;
        _formData.clear();
      });

      await AlertWidget.show(
        context: context,
        title: 'Berhasil',
        description: 'Berhasil memperbarui penanganan laporan bahaya',
        type: 'success',
      ).then((_) {
        final tabController = ref.read(dailyActivityTabControllerProvider);
        if (tabController != null) {
          tabController.animateTo(1);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'Gagal menyimpan laporan bahaya'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> chooseImage(String type) async {
    final picker = ImagePicker();
    XFile? image;
    if (type == 'camera') {
      image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // compress 50%
        maxWidth: 1024,
        maxHeight: 1024,
      );
    } else {
      image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // compress 50%
        maxWidth: 1024,
        maxHeight: 1024,
      );
    }

    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hazardLocation =
        ref.watch(listHazardLocationProvider).valueOrNull ?? [];
    final user = ref.watch(userLoginDataProvider).valueOrNull;

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputText(
                  labelText: 'Nama',
                  initialValue: user?.name ?? '',
                  disable: true,
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Nama harus diisi',
                    ),
                  ]),
                ),
                InputText(
                  labelText: 'NIK',
                  initialValue: user?.employee?.nip ?? '',
                  disable: true,
                  keyboardType: TextInputType.text,
                ),
                InputText(
                  labelText: 'Jabatan',
                  initialValue: user?.employee?.jabatan ?? '',
                  disable: true,
                  keyboardType: TextInputType.text,
                ),

                DropdownWidget<HazardLocationModel>(
                  labelText: 'Lokasi Pengerjaan',
                  value: _selectedHazardLocation,
                  items: hazardLocation,
                  itemLabel: (location) => location.name,
                  validator: FormBuilderValidators.required(
                    errorText: 'Pilih salah satu',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedHazardLocation = value;
                      _formData['id_location'] = value?.id;
                    });
                  },
                ),
                if (_selectedHazardLocation != null &&
                    _selectedHazardLocation!.id == 999)
                  InputText(
                    key: const ValueKey('lokasi_lainnya'),
                    labelText: 'Lokasi Lainnya',
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Lokasi Lainnya harus diisi',
                      ),
                    ]),
                    onSaved: (value) {
                      _formData['other_location'] = value;
                    },
                  ),
                DropdownWidget<Options>(
                  labelText: 'Kategori',
                  value: _selectedCategory,
                  items: _categoryOptions,
                  itemLabel: (category) => category.label,
                  validator: FormBuilderValidators.required(
                    errorText: 'Pilih salah satu',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                    _formData['job_type'] = value?.value;
                  },
                ),

                if (_selectedCategory != null &&
                    _selectedCategory!.value == 'UNIT')
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<Map<String, dynamic>>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext modalContext) {
                              String localSearchQuery = "";
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return Consumer(
                                    builder: (context, ref, child) {
                                      final searchUnitAsync = ref.watch(
                                        getUnitListProvider(
                                          searchQuery: localSearchQuery,
                                        ),
                                      );
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: 16,
                                            children: <Widget>[
                                              Container(
                                                width: 100,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.secondaryLight,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              InputText(
                                                labelText: 'Cari Unit',
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _searchController,
                                                autofocus: true,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    localSearchQuery =
                                                        value ?? "";
                                                  });
                                                },
                                              ),
                                              Container(
                                                height: 200,
                                                child: localSearchQuery == ""
                                                    ? Center(
                                                        child: Text(
                                                          'Cari berdasarkan nomor lambung / plat nomer',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      )
                                                    : searchUnitAsync.when(
                                                        data: (units) {
                                                          if (units.isEmpty) {
                                                            return Center(
                                                              child: Text(
                                                                'Tidak ada hasil',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          return ListView.builder(
                                                            itemCount:
                                                                units.length,
                                                            itemBuilder: (context, index) {
                                                              final data =
                                                                  units[index];
                                                              return ListTile(
                                                                title: Text(
                                                                  '${data.unit_code} - ${data.unit_type} ${data.model}',
                                                                ),
                                                                subtitle: Text(
                                                                  '${data.brand} - ${data.plate_number}',
                                                                ),
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                    {
                                                                      'data':
                                                                          data,
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                        loading: () => Center(
                                                          child: Text(
                                                            'Mencari...',
                                                          ),
                                                        ),
                                                        error: (error, stack) =>
                                                            Center(
                                                              child: Text(
                                                                'Tidak ada hasil',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                      ),
                                              ),
                                              Gap(24),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                selectedUnit = value['data'];
                                _formData['id_unit'] = value['data'].id;
                                _formData['unit_code'] =
                                    value['data'].unit_code;
                                _formData['plate_number'] =
                                    value['data'].plate_number;
                                _formData['unit_type_id'] =
                                    value['data'].unit_type_id;
                                _formData['unit_type'] =
                                    value['data'].unit_type;
                                _formData['unit_category'] =
                                    value['data'].unit_category;
                                _formData['unit_cat_code'] =
                                    value['data'].unit_cat_code;
                                _formData['unit_model_id'] =
                                    value['data'].unit_model_id;
                                _formData['brand'] = value['data'].brand;
                                _formData['model'] = value['data'].model;
                                _unitController.text = value['data'].unit_code;
                              });
                            }
                            _searchController.clear();
                          });
                        },
                        child: InputText(
                          labelText: 'Code Unit',
                          readOnly: true,
                          disable: true,
                          controller: _unitController,
                          keyboardType: TextInputType.text,
                          validator: FormBuilderValidators.required(
                            errorText: 'Unit harus dipilih',
                          ),
                        ),
                      ),
                      Gap(16),
                      DropdownWidget<Options>(
                        labelText: 'Status Unit',
                        value: _selectedStatusUnit,
                        items: _statusunitOptions,
                        itemLabel: (status) => status.label,
                        validator: FormBuilderValidators.required(
                          errorText: 'Pilih salah satu',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedStatusUnit = value;
                            _formData['sts_unit'] = value?.value;
                          });
                        },
                      ),
                    ],
                  ),

                GestureDetector(
                  onTap: () {
                    Picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        startTime = date;
                        _startTime.text = DateFormat(
                          'dd-MMM-yy HH:mm',
                        ).format(date);
                        _formData['start_time'] = DateFormat(
                          'yyyy-MM-dd HH:mm:ss',
                        ).format(date);
                      },
                      currentTime: startTime != null
                          ? startTime
                          : DateTime.now(),
                      locale: Picker.LocaleType.id,
                    );
                  },
                  child: InputText(
                    labelText: 'Mulai Pekerjaan',
                    readOnly: true,
                    disable: true,
                    controller: _startTime,
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.required(
                      errorText: 'Harus diisi',
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        print('confirm $date');
                        endTime = date;
                        int dur = getDurationInMinutes(startTime!, endTime!);
                        durasi = dur.toString();
                        _endTime.text = DateFormat(
                          'dd-MMM-yy HH:mm',
                        ).format(date);
                        _formData['end_time'] = DateFormat(
                          'yyyy-MM-dd HH:mm:ss',
                        ).format(date);
                        _formData['duration'] = durasi;
                        _duration.text = getTimeDuration(startTime!, endTime!);
                      },
                      currentTime: endTime != null ? endTime : DateTime.now(),
                      locale: Picker.LocaleType.id,
                    );
                  },
                  child: InputText(
                    labelText: 'Selesai Pekerjaan',
                    readOnly: true,
                    disable: true,
                    controller: _endTime,
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.required(
                      errorText: 'Harus diisi',
                    ),
                  ),
                ),

                InputText(
                  labelText: 'Durasi Aktivitas',
                  disable: true,
                  keyboardType: TextInputType.text,
                  controller: _duration,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Harus diisi'),
                  ]),
                ),
                InputText(
                  labelText: 'Judul Aktivitas',
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.required(
                    errorText: 'Harus dipilih',
                  ),
                  onSaved: (value) {
                    _formData['activity'] = value;
                  },
                ),
                InputText(
                  key: const ValueKey('desc_activity'),
                  labelText: 'Deskripsi Aktivitas',
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 3,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Deskripsikan Aktivitas anda',
                    ),
                  ]),
                  onSaved: (value) {
                    _formData['desc'] = value;
                  },
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Laporkan Bahaya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
