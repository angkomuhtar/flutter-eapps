import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TodayAttendanceWidget extends ConsumerWidget {
  const TodayAttendanceWidget({super.key});

  String _formatLateStatus(int hours, int minutes) {
    if (hours > 0) {
      return 'Telat $hours jam $minutes menit';
    }
    return 'Telat $minutes menit';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAsync = ref.watch(todayAttendanceProvider);

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hari Ini',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                DateFormat('EEE, dd MMM yyyy', 'id').format(DateTime.now()),
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        todayAsync.when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      ClockCard(
                        title: 'Check In',
                        time: (data.check_in?.isNotEmpty ?? false)
                            ? DateFormat('hh:mm a')
                                  .format(DateTime.parse(data.check_in!))
                                  .toUpperCase()
                            : '--:--',
                        status: data.late != null
                            ? _formatLateStatus(
                                data.late!.hours,
                                data.late!.minutes,
                              )
                            : null,
                        icon: Icons.pin_end_outlined,
                      ),
                      ClockCard(
                        title: 'Check Out',
                        time: (data.check_out?.isNotEmpty ?? false)
                            ? DateFormat('hh:mm a')
                                  .format(DateTime.parse(data.check_out!))
                                  .toUpperCase()
                            : '--:--',
                        status: data.early != null
                            ? 'Cepat ${data.early!.hours > 0 ? '${data.early!.hours} jam' : ''} ${data.early!.minutes} menit'
                            : null,
                        icon: Icons.pin_invoke_outlined,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      ClockCard(
                        title: 'Shift',
                        time: data.shift?.name ?? '-',
                        status: data.shift != null
                            ? '${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(data.shift!.start))} - ${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(data.shift!.end))}'
                            : null,
                        icon: Icons.schedule,
                      ),
                      ClockCard(
                        title: 'Durasi Tidur',
                        status: "Minimal 6 Jam",
                        time: data.sleep != null
                            ? '${getSleepDuration(DateTime.parse(data.sleep!.start), DateTime.parse(data.sleep!.end))}'
                            : '--:--',
                        icon: Icons.bedtime,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          loading: () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              spacing: 12,
              children: [
                Row(spacing: 12, children: [ClockCardLoad(), ClockCardLoad()]),
                Row(spacing: 12, children: [ClockCardLoad(), ClockCardLoad()]),
              ],
            ),
          ),
          error: (error, stack) {
            print(error);
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Gagal memuat data',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const Gap(8),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(todayAttendanceProvider),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class ClockCard extends StatelessWidget {
  final String title;
  final String time;
  final String? status;
  final IconData icon;

  const ClockCard({
    super.key,
    this.title = 'Check Out',
    this.time = '--:--',
    this.status,
    this.icon = Icons.pin_end_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.10),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(icon, color: AppColors.white, size: 18),
                ),
                Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (status != null && status!.isNotEmpty) ...[
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            status ?? '',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            Text(
              time,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockCardLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.10),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(6),
                ),
                Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 14,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const Gap(6),
                      SizedBox(
                        width: 100,
                        height: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            SizedBox(
              width: 100,
              height: 20,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
