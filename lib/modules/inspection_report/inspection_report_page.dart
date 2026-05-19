import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/inspection_report/inspection_report_screen.dart';

import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inspectionReportTabControllerProvider = StateProvider<TabController?>(
  (ref) => null,
);

class InspectionReportPage extends ConsumerStatefulWidget {
  const InspectionReportPage({super.key});

  @override
  ConsumerState<InspectionReportPage> createState() => _InspectionReportPage();
}

class _InspectionReportPage extends ConsumerState<InspectionReportPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(inspectionReportTabControllerProvider.notifier).state =
          _tabController;
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
            CustAppBar(title: 'Laporan Inspeksi'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Baru',
                  icon: Icons.difference_rounded,
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                ),
                Tabs(
                  text: 'Terverifikasi',
                  icon: Icons.history,
                  onTap: () {
                    _tabController.animateTo(1);
                  },
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  InspectionReportScreen(type: 'created'),
                  InspectionReportScreen(type: 'verified'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
