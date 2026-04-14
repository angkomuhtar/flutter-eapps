import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/auth/auth_notifier.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_eapps/modules/dashboard/widget/profile_widget.dart';
import 'package:flutter_eapps/modules/dashboard/widget/rekap_widget.dart';
import 'package:flutter_eapps/modules/dashboard/widget/today_attendance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(currentUserProvider);
            ref.invalidate(todayAttendanceProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Gap(40),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: ProfileWidget()),
                          Gap(4),
                          IconButton(
                            iconSize: 24,
                            color: AppColors.white,
                            onPressed: () {
                              context.push('/notification');
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.notifications_active_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TodayAttendanceWidget(),
                    Gap(20),
                    RekapWidget(),
                    AllFeatureWidget(),
                    Gap(120),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AllFeatureWidget extends StatelessWidget {
  const AllFeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(24),
          Text(
            'Semua Fitur',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Gap(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                FeatureButton(
                  title: "Jam Tidur",
                  icon: "assets/features/sleep-duration.png",
                  onTap: () => context.push('/sleep-duration'),
                ),
                FeatureButton(
                  title: "Laporan Bahaya",
                  icon: "assets/features/hazard-report.png",
                  onTap: () => context.push('/hazard'),
                ),
                FeatureButton(
                  title: "Penangan Bahaya",
                  icon: "assets/features/hazard-action.png",
                  onTap: () => {print("Penangan Bahaya")},
                ),
                FeatureButton(
                  title: "Pengajuan Cuti",
                  icon: "assets/features/leave.png",
                  onTap: () => {print("Pengajuan Cuti")},
                ),
                FeatureButton(
                  title: "Kartu Inspeksi",
                  icon: "assets/features/inspection.png",
                  onTap: () => {print("Kartu Inspeksi")},
                ),
                FeatureButton(
                  title: "Kontrak Kerja",
                  onTap: () => {print("Kontrak Kerja")},
                  icon: "assets/features/pkwt.png",
                ),
                FeatureButton(
                  title: "P2H",
                  icon: "assets/features/p2h.png",
                  onTap: () => {print("P2H")},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const FeatureButton({
    super.key,
    this.title = "",
    this.icon = "",
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(5),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.shade300,
      //       spreadRadius: 2,
      //       blurRadius: 5,
      //       offset: const Offset(0, 3),
      //     ),
      //   ],
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(icon, width: 45, height: 45),
            ),
          ),
          Gap(8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
