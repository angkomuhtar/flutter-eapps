import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/leave/add_leave_screen.dart';
import 'package:flutter_eapps/modules/leave/leave_history_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final LeaveTabControllerProvider = StateProvider<TabController?>((ref) => null);

class LeavePage extends ConsumerStatefulWidget {
  const LeavePage({super.key});

  @override
  ConsumerState<LeavePage> createState() => _LeavePage();
}

class _LeavePage extends ConsumerState<LeavePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tabController;

  final List<Widget> _tabs = const [AddLeaveScreen(), LeaveHistoryScreen()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(LeaveTabControllerProvider.notifier).state = _tabController;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Pengajuan Cuti'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Buat Pengajuan',
                  icon: Icons.difference_rounded,
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                ),
                Tabs(
                  text: 'Riwayat Pengajuan',
                  icon: Icons.history,
                  onTap: () {
                    _tabController.animateTo(1);
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: _tabs),
            ),
          ],
        ),
      ),
    );
  }
}
