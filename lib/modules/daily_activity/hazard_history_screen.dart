import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard/hazard_provider.dart';
import 'package:flutter_eapps/widget/hazard/hazard-card-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HazardHistoryScreen extends ConsumerStatefulWidget {
  const HazardHistoryScreen({super.key});

  @override
  ConsumerState<HazardHistoryScreen> createState() =>
      _HazardHistoryScreenState();
}

class _HazardHistoryScreenState extends ConsumerState<HazardHistoryScreen> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _hasMore = ref.read(listHazardProvider.notifier).hasMore;
      if (!_hasMore) return;
      _isLoadingMore = true;
      ref.read(listHazardProvider.notifier).loadMore().then((_) {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(listHazardProvider);
    final hasMore = ref.read(listHazardProvider.notifier).hasMore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                filterPills(
                  onTap: () {
                    ref.read(listHazardProvider.notifier).setFilter('');
                  },
                  title: 'Semua',
                  ref: ref,
                  value: '',
                ),
                filterPills(
                  onTap: () {
                    ref.read(listHazardProvider.notifier).setFilter('open');
                  },
                  title: 'Belum Ditangani',
                  ref: ref,
                  value: 'open',
                ),
                filterPills(
                  onTap: () {
                    ref
                        .read(listHazardProvider.notifier)
                        .setFilter('onprogress');
                  },
                  title: 'Sedang Ditangani',
                  ref: ref,
                  value: 'onprogress',
                ),
                filterPills(
                  onTap: () {
                    ref.read(listHazardProvider.notifier).setFilter('close');
                  },
                  title: 'Sudah Ditangani',
                  ref: ref,
                  value: 'close',
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: historyAsync.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(child: EmptyList(message: 'Belum ada laporan'));
              }

              return RefreshIndicator(
                onRefresh: () =>
                    ref.read(listHazardProvider.notifier).refresh(),
                child: Stack(
                  children: [
                    ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                      itemCount: data.length + 1,
                      separatorBuilder: (context, index) => Gap(12),
                      itemBuilder: (context, index) {
                        if (index == data.length) {
                          if (!hasMore) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: Text(
                                  'Semua data sudah ditampilkan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.secondaryLight,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final item = data[index];
                        return hazardCard(
                          item: item,
                          onTap: () {
                            debugPrint(
                              "Hazard card tapped: ${item.hazard_number}",
                            );
                            context.push('/hazard/details/${item.id}');
                          },
                        );
                      },
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.white,
                              AppColors.white.withValues(alpha: 0.8),
                              AppColors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(child: LoadingList()),
            error: (e, st) => Center(child: ErrorList()),
          ),
        ),
      ],
    );
  }
}

class filterPills extends StatelessWidget {
  const filterPills({
    super.key,
    required this.onTap,
    required this.title,
    required this.ref,
    required this.value,
  });

  final VoidCallback onTap;
  final String title;
  final WidgetRef ref;
  final String value;

  @override
  Widget build(BuildContext context) {
    final _selected = ref.read(listHazardProvider.notifier).filter;
    return GestureDetector(
      onTap: _selected != value ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _selected == value ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.primary),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selected == value ? AppColors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
