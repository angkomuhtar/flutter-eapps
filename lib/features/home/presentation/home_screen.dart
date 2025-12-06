import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/features/dashboard/presentation/dashboard_page.dart';
import 'package:flutter_eapps/features/attendance/presentation/attendance_page.dart';
import 'package:flutter_eapps/features/profile/presentation/profile_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    AttendancePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        child: IndexedStack(index: _selectedIndex, children: _pages),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 34),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.white,
              AppColors.white.withValues(alpha: 0.8),
              AppColors.white.withValues(alpha: 0),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: GNav(
                  gap: 6,
                  activeColor: AppColors.primary,
                  iconSize: 22,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  tabMargin: EdgeInsetsGeometry.symmetric(horizontal: 6),
                  tabBorderRadius: 10,
                  duration: const Duration(milliseconds: 300),
                  tabBackgroundColor: AppColors.white,
                  color: AppColors.white,
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.fingerprint_sharp, text: 'Absensi'),
                    GButton(icon: Icons.person, text: 'Profil'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
