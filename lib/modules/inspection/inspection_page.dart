import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/inspection/inspection_history_screen.dart';
import 'package:flutter_eapps/modules/inspection/inspection_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/cust-tabbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

final inspectionTabControllerProvider = StateProvider<TabController?>(
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(inspectionTabControllerProvider.notifier).state = _tabController;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listInspectionAsync = ref.watch(getInspectionTypeProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Kartu Inspeksi'),
            CustTabBar(
              selectedIndex: _selectedIndex,
              tabs: [
                Tabs(
                  text: 'Buat Inspeksi',
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
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: listInspectionAsync.when(
                            data: (data) {
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      tileColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      leading: Icon(
                                        Icons.difference_rounded,
                                        color: AppColors.secondaryLight,
                                      ),
                                      title: Text(
                                        'Inspeksi ${item.name}',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.chevron_right,
                                        color: AppColors.textHint,
                                      ),
                                      onTap: () {
                                        context.push(
                                          '/inspection/${item.slug}/form',
                                        );
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Gap(2),
                                itemCount: data.length,
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (e, __) => Center(
                              child: Text('Error loading inspection types'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InspectionHistoryScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
