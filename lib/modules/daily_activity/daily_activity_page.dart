import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/daily_activity/add_daily_activity_screen.dart';
import 'package:flutter_eapps/modules/hazard/hazard_history_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyActivityTabControllerProvider = StateProvider<TabController?>(
  (ref) => null,
);

class DailyActivityPage extends ConsumerStatefulWidget {
  const DailyActivityPage({super.key});

  @override
  ConsumerState<DailyActivityPage> createState() => _DailyActivityPageState();
}

class _DailyActivityPageState extends ConsumerState<DailyActivityPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tabController;

  final List<Widget> _tabs = const [
    AddDailyActivityScreen(),
    HazardHistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dailyActivityTabControllerProvider.notifier).state =
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
            CustAppBar(title: 'Aktivitas Harian'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Buat Baru',
                  icon: Icons.difference_rounded,
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                ),
                Tabs(
                  text: 'Riwayat',
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
