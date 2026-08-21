import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/p2h/add_p2h_screen.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final p2hTabControllerProvider = StateProvider<TabController?>((ref) => null);

class P2hPage extends ConsumerStatefulWidget {
  const P2hPage({super.key});

  @override
  ConsumerState<P2hPage> createState() => _P2hPageState();
}

class _P2hPageState extends ConsumerState<P2hPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tabController;

  final List<Widget> _tabs = const [AddP2hScreen()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(p2hTabControllerProvider.notifier).state = _tabController;
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
            CustAppBar(title: 'Laporan Pemeriksaan '),
            // CustTabBar(
            //   selectedIndex: _selectedIndex,
            //   tabs: [
            //     Tabs(
            //       text: 'Buat Baru',
            //       icon: Icons.difference_rounded,
            //       onTap: () {
            //         _tabController.animateTo(0);
            //       },
            //     ),
            //     Tabs(
            //       text: 'Riwayat',
            //       icon: Icons.history,
            //       onTap: () {
            //         _tabController.animateTo(1);
            //       },
            //     ),
            //   ],
            // ),
            Expanded(
              child: TabBarView(controller: _tabController, children: _tabs),
            ),
          ],
        ),
      ),
    );
  }
}
