import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard/hazard_provider.dart';
import 'package:flutter_eapps/modules/hazard_action/hazard_action_provider.dart';
import 'package:flutter_eapps/widget/hazard/hazard-card-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HazardActionHistoryScreen extends ConsumerStatefulWidget {
  const HazardActionHistoryScreen({super.key});

  @override
  ConsumerState<HazardActionHistoryScreen> createState() =>
      _HazardActionHistoryScreenState();
}

class _HazardActionHistoryScreenState
    extends ConsumerState<HazardActionHistoryScreen> {
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
      _hasMore = ref
          .read(listHazardActionProvider(filter: 'closed').notifier)
          .hasMore;
      if (!_hasMore) return;
      _isLoadingMore = true;
      ref
          .read(listHazardActionProvider(filter: 'closed').notifier)
          .loadMore()
          .then((_) {
            _isLoadingMore = false;
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(listHazardActionProvider(filter: 'closed'));
    final hasMore = ref
        .read(listHazardActionProvider(filter: 'closed').notifier)
        .hasMore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: historyAsync.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(child: EmptyList(message: 'Belum ada laporan'));
              }
              return RefreshIndicator(
                onRefresh: () => ref
                    .read(listHazardActionProvider(filter: 'closed').notifier)
                    .refresh(),
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
                            context.push('/hazard-action/details/${item.id}');
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
