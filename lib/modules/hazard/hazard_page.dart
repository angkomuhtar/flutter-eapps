import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard/add_hazard_screen.dart';
import 'package:flutter_eapps/modules/hazard/hazard_history_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HazardPage extends ConsumerStatefulWidget {
  const HazardPage({super.key});

  @override
  ConsumerState<HazardPage> createState() => _HazardPage();
}

class _HazardPage extends ConsumerState<HazardPage> {
  int _selectedIndex = 0;
  // final double _tabWidth = 180;

  final List<Widget> _tabs = const [AddHazardScreen(), HazardHistoryScreen()];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Pelaporan Bahaya'),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Center(
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.20),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: _selectedIndex * (screenWidth / 2),
                            top: 0,
                            bottom: 0,
                            width: screenWidth / 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              _buildTab(
                                0,
                                Icons.bedtime_rounded,
                                'Input',
                                screenWidth / 2,
                              ),
                              _buildTab(
                                1,
                                Icons.history,
                                'History',
                                screenWidth / 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: IndexedStack(index: _selectedIndex, children: _tabs),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String text, double tabwidth) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: SizedBox(
        width: tabwidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? AppColors.white : AppColors.primary,
              ),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
