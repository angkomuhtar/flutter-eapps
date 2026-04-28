import 'package:flutter/material.dart';
import 'package:flutter_eapps/modules/auth/auth_notifier.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Gap(24),
            _buildMenuList(context, ref),
            // Container(
            //   height: 100,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final userAsync = ref.watch(currentUserProvider);

    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Profil',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'v$appVersion',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Gap(10),
          CircleAvatar(
            radius: 55,
            backgroundColor: AppColors.white,
            backgroundImage: const AssetImage(
              'assets/images/avatar-default.png',
            ),
          ),
          Gap(12),
          userAsync.when(
            data: (user) => Column(
              children: [
                Text(
                  user?.name ?? 'User Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  user != null
                      ? '${user.employee?.divisi} - ${user.employee?.jabatan}'
                      : 'Department - Position',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.scaffoldBackground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            loading: () => Column(
              children: [
                Text(
                  'Loading...',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Department - Position',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ],
            ),
            error: (_, __) => Column(
              children: [
                Text(
                  'User Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Department - Position',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Notifikasi',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            onTap: () {
              context.push('/about-us');
            },
          ),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'FAQ',
            onTap: () {
              context.push('/faq');
            },
          ),
          _buildMenuItem(
            icon: Icons.description_outlined,
            title: 'Syarat dan Ketentuan',
            onTap: () {
              context.push('/terms-condition');
            },
          ),
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Kebijakan Privasi',
            onTap: () {
              context.push('/privacy-policy');
            },
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: AppColors.primary,
            textColor: AppColors.primary,
            onTap: () => {
              AlertWidget.show(
                context: context,
                type: 'warning',
                title: 'Logout',
                description: 'Apakah Anda yakin ingin logout?',
                okText: 'Logout',
                cancelText: 'Batal',
                lottieSize: 150,
              ).then((confirmed) {
                if (confirmed == true) {
                  ref.read(authNotifierProvider.notifier).logout();
                  // ref.read(authNotifierProvider.notifier).logout();
                  // Navigator.pushReplacementNamed(context, '/login');
                }
              }),
            },
          ),
          Gap(200),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        tileColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(icon, color: iconColor ?? AppColors.secondaryLight),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textHint),
        onTap: onTap,
      ),
    );
  }
}
