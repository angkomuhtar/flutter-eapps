import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard_report/hazard_report_close_screen.dart';
import 'package:flutter_eapps/modules/hazard_report/hazard_report_open_screen.dart';
import 'package:flutter_eapps/modules/hazard_report/hazard_report_progress_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';

class HazardReportPage extends ConsumerStatefulWidget {
  const HazardReportPage({super.key});

  @override
  ConsumerState<HazardReportPage> createState() => _HazardReportPageState();
}

class _HazardReportPageState extends ConsumerState<HazardReportPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HazardReportOpenScreen(),
    HazardReportProgressScreen(),
    HazardReportCloseScreen(),
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
            CustAppBar(title: 'Hazard Report'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Open',
                  icon: Icons.report,
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                ),
                Tabs(
                  text: 'Progress',
                  icon: Icons.history,
                  onTap: () {
                    _tabController.animateTo(1);
                  },
                ),
                Tabs(
                  text: 'Selesai',
                  icon: Icons.check_circle,
                  onTap: () {
                    _tabController.animateTo(2);
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
