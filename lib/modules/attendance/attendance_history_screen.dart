import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/attendance/attendance_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_eapps/widget/month_year_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AttendanceHistoryScreen extends ConsumerStatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  ConsumerState<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState
    extends ConsumerState<AttendanceHistoryScreen> {
  String _selectedMonth = DateFormat('yyyy-MM-01').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(
      AttHistoryProvider(
        DateFormat(
          'yyyy-MM-26',
        ).format(DateTime.parse(_selectedMonth).subtract(Duration(days: 5))),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(
              title: 'History Absensi',
              trailing: Container(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                  onPressed: () async {
                    final DateTime? pickedDate =
                        await showMonthYearPickerDialog(
                          context,
                          DateFormat('yyyy-MM-dd').parse(_selectedMonth),
                        );

                    if (pickedDate != null) {
                      setState(() {
                        _selectedMonth = DateFormat(
                          'yyyy-MM-dd',
                        ).format(pickedDate);
                      });
                    }

                    debugPrint('Selected Month: $_selectedMonth');
                  },
                  child: Row(
                    children: [
                      Text(
                        DateFormat('MMM yyyy').format(
                          DateFormat('yyyy-MM-dd').parse(_selectedMonth),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: historyAsync.when(
                data: (data) {
                  if (data.isEmpty) {
                    return EmptyList();
                  }
                  return RefreshIndicator(
                    onRefresh: () => ref
                        .read(
                          attHistoryProvider(
                            DateFormat('yyyy-MM-26').format(
                              DateTime.parse(
                                _selectedMonth,
                              ).subtract(Duration(days: 5)),
                            ),
                          ).notifier,
                        )
                        .refresh(),
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 60),
                      itemCount: data.length,
                      separatorBuilder: (context, index) => Gap(12),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        final dateTime = item.date != null
                            ? DateTime.parse(item.date!)
                            : DateTime.now();

                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.secondaryLight,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.all(4),
                                width: 80,
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat('EEEE', 'id').format(dateTime),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryLight,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd').format(dateTime),
                                      style: TextStyle(
                                        fontSize: 28,
                                        height: 1.1,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('MMM', 'id').format(dateTime),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(12),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Shift',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.secondaryLight,
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              item.shift?.name ?? '--',
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1.7,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Masuk',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.secondaryLight,
                                            ),
                                          ),
                                          Text(
                                            item.check_in != null
                                                ? DateFormat('HH:mm').format(
                                                    DateTime.parse(
                                                      item.check_in!,
                                                    ),
                                                  )
                                                : '--:--',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Pulang',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.secondaryLight,
                                            ),
                                          ),
                                          Text(
                                            item.check_out != null
                                                ? DateFormat('HH:mm').format(
                                                    DateTime.parse(
                                                      item.check_out!,
                                                    ),
                                                  )
                                                : '--:--',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => LoadingList(),
                error: (e, st) => ErrorList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
