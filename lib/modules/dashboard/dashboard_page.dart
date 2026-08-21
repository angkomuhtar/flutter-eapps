import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_eapps/modules/dashboard/widget/profile_widget.dart';
import 'package:flutter_eapps/modules/dashboard/widget/rekap_widget.dart';
import 'package:flutter_eapps/modules/dashboard/widget/today_attendance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String _currVersion = '';
  String _currBuild = '';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _currVersion = packageInfo.version;
      _currBuild = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userLoginDataProvider).valueOrNull;
    final version = ref.watch(getVersionDataProvider);

    double reportWidth = MediaQuery.of(context).size.width - (16 * 7);
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(userLoginDataProvider);
            ref.invalidate(todayAttendanceProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

                    version.when(
                      data: (ver) {
                        if (checkVersion(
                          _currVersion,
                          ver.version,
                          _currBuild,
                          ver.build_number,
                        )) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(
                                    alpha: 0.10,
                                  ),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Softwre Update',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'Applikasi terbaru v${ver.version}(${ver.build_number}) tersedia, silahkan perbaharui applikasi anda',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white.withValues(
                                        alpha: 0.30,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      'Update',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                      loading: () => const Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/images/avatar-default.png',
                            ),
                            backgroundColor: AppColors.white,
                          ),
                          Gap(12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 16,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(6),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 12,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(8),
                                  SizedBox(
                                    width: 80,
                                    height: 12,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      error: (e, __) {
                        print(e);
                        return Text('Error loading user data');
                      },
                    ),
                    TodayAttendanceWidget(),
                    Gap(20),
                    RekapWidget(),
                    AllFeatureWidget(),
                    Gap(20),
                    if (user != null &&
                        (user.roles == 'superadmin' ||
                            (user.employee?.class_jabatan != null &&
                                user.employee!.class_jabatan >= 4)))
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Laporan & Pengajuan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Laporan dan Pengajuan yang di tujukan kepada anda untuk di tindak lanjuti',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Gap(24),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 16,
                                children: [
                                  FeatureButton(
                                    title: "Hazard Report",
                                    icon: "assets/features/hazard-report.png",
                                    onTap: () => context.push('/hazard-report'),
                                    width: reportWidth * 0.25,
                                  ),
                                  FeatureButton(
                                    title: "Laporan Inspeksi",
                                    icon: "assets/features/inspection.png",
                                    onTap: () => {
                                      context.push('/inspection-report'),
                                    },
                                    width: reportWidth * 0.25,
                                  ),
                                  FeatureButton(
                                    title: "Laporan P2H",
                                    icon: "assets/features/p2h.png",
                                    onTap: () => {
                                      context.push('/approval-p2h'),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              spacing: 16,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FeatureButton(
                      title: "Penangan Bahaya",
                      icon: "assets/features/hazard-action.png",
                      onTap: () => context.push('/hazard-action'),
                    ),
                    FeatureButton(
                      title: "Kartu Inspeksi",
                      icon: "assets/features/inspection.png",
                      onTap: () => {context.push('/inspection')},
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FeatureButton(
                      title: "Pengajuan Cuti",
                      icon: "assets/features/leave.png",
                      onTap: () => {context.push('/leave')},
                    ),
                    FeatureButton(
                      title: "Kontrak Kerja",
                      onTap: () => {context.push('/contract')},
                      icon: "assets/features/pkwt.png",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FeatureButton(
                      title: "Plant Daily Activity",
                      icon: "assets/features/daily-activity.png",
                      onTap: () => {context.push('/daily-activity')},
                    ),
                    FeatureButton(
                      title: "P2H",
                      icon: "assets/features/p2h.png",
                      onTap: () => {context.push('/p2h')},
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FeatureButton(
                      title: "S.O.P",
                      icon: "assets/features/sop.png",
                      onTap: () => {context.push('/sop')},
                    ),
                    FeatureButton(
                      title: "Surat Lembur",
                      icon: "assets/features/overtime.png",
                      onTap: () => {print("Surat Perintah Lembur")},
                    ),
                  ],
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
  final double width;

  const FeatureButton({
    super.key,
    this.title = "",
    this.icon = "",
    this.width = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - (16 * 5);
    return Container(
      width: width == 0 ? defaultWidth * 0.25 : width,
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
