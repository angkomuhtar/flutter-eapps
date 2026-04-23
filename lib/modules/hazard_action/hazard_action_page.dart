import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard_action/hazard_action_history_screen.dart';
import 'package:flutter_eapps/modules/hazard_action/hazard_action_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';

class HazardActionPage extends ConsumerStatefulWidget {
  const HazardActionPage({super.key});

  @override
  ConsumerState<HazardActionPage> createState() => _HazardActionPageState();
}

class _HazardActionPageState extends ConsumerState<HazardActionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HazardActionScreen(),
    HazardActionHistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
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
            CustAppBar(title: 'Penanganan Bahaya'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Laporan Baru',
                  icon: Icons.report,
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                ),
                Tabs(
                  text: 'Selesai',
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
