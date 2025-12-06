import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int _selectedIndex = 0;
  final double _tabWidth = 120;

  final List<Widget> _tabs = const [_AbsenceTab(), _HistoryTab()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(
            child: Container(
              width: _tabWidth * 2,
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
                    left: _selectedIndex * _tabWidth,
                    top: 0,
                    bottom: 0,
                    width: _tabWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildTab(0, Icons.fingerprint, 'Absence'),
                      _buildTab(1, Icons.history, 'History'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(index: _selectedIndex, children: _tabs),
        ),
      ],
    );
  }

  Widget _buildTab(int index, IconData icon, String text) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: SizedBox(
        width: _tabWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? AppColors.white : AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AbsenceTab extends StatelessWidget {
  const _AbsenceTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Absence'));
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('History'));
  }
}
