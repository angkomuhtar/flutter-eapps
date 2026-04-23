import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard/add_hazard_screen.dart';
import 'package:flutter_eapps/modules/hazard/hazard_history_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hazardTabControllerProvider = StateProvider<TabController?>(
  (ref) => null,
);

class InspectionPage extends ConsumerStatefulWidget {
  const InspectionPage({super.key});

  @override
  ConsumerState<InspectionPage> createState() => _InspectionPage();
}

class _InspectionPage extends ConsumerState<InspectionPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tabController;

  final List<Widget> _tabs = const [AddHazardScreen(), HazardHistoryScreen()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hazardTabControllerProvider.notifier).state = _tabController;
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
            CustAppBar(title: 'Pelaporan Bahaya'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Buat Laporan',
                  icon: Icons.difference_rounded,
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                ),
                Tabs(
                  text: 'History',
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
