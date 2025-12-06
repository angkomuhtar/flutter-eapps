import 'package:flutter/material.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_eapps/features/auth/data/auth_provider.dart';
import 'package:flutter_eapps/features/profile/data/user_provider.dart';
import 'package:flutter_eapps/core/routes/app_routes.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(userProvider.notifier).loadUser());
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(user),
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

  Widget _buildHeader(UserData user) {
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
                'V.3.0.0',
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
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : const AssetImage('assets/images/avatar-default.png')
                      as ImageProvider,
          ),
          Gap(12),
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
            icon: Icons.help_outline,
            title: 'Bantuan',
            onTap: () {
              AlertWidget.show(
                context: context,
                type: 'success',
                title: 'Peringatan',
                description: 'Apakah Anda yakin?',
                okText: 'Ya',
                cancelText: 'Batal',
              );
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
                  ref.read(authProvider.notifier).logout();
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              }),
            },
          ),
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
