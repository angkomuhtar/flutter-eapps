import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/p2h/p2h_provider.dart';
import 'package:flutter_eapps/widget/hazard/hazard-card-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HistoryP2hScreen extends ConsumerStatefulWidget {
  const HistoryP2hScreen({super.key});

  @override
  ConsumerState<HistoryP2hScreen> createState() => _HistoryP2hScreenState();
}

class _HistoryP2hScreenState extends ConsumerState<HistoryP2hScreen> {
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
      _hasMore = ref.read(historyP2hProvider().notifier).hasMore;
      if (!_hasMore) return;
      _isLoadingMore = true;
      ref.read(historyP2hProvider().notifier).loadMore().then((_) {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyP2hProvider());
    final hasMore = ref.read(historyP2hProvider().notifier).hasMore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: historyAsync.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(
                  child: EmptyList(message: 'Belum ada Laporan Pemeriksaan'),
                );
              }
              return RefreshIndicator(
                onRefresh: () =>
                    ref.read(historyP2hProvider().notifier).refresh(),
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
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                context.push('/p2h/details', extra: item),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 10,
                                          children: [
                                            itemValue(
                                              title: "Unit",
                                              value:
                                                  "${item.unit.brand} ${item.unit.model} - ${item.unit.code}",
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Status",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          item.status ==
                                                              'approved'
                                                          ? AppColors.success
                                                          : item.status ==
                                                                'closed'
                                                          ? AppColors.grey
                                                          : AppColors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      item.status.toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(8),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 10,
                                          children: [
                                            itemValue(
                                              title: "Tanggal Pemeriksaan",
                                              value:
                                                  DateFormat(
                                                    'dd MMMM yyyy',
                                                    'id_ID',
                                                  ).format(
                                                    DateFormat(
                                                      'yyyy-MM-dd',
                                                    ).parse(item.date),
                                                  ),
                                            ),
                                            itemValue(
                                              title: "HM Awal - HM Akhir",
                                              value:
                                                  "${item.hm_start} - ${item.hm_end}",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

// class filterPills extends StatelessWidget {
//   const filterPills({
//     super.key,
//     required this.onTap,
//     required this.title,
//     required this.ref,
//     required this.value,
//   });

//   final VoidCallback onTap;
//   final String title;
//   final WidgetRef ref;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     final _selected = ref.read(inspectionHistoryProvider.notifier).filter;
//     return GestureDetector(
//       onTap: _selected != value ? onTap : null,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         decoration: BoxDecoration(
//           color: _selected == value ? AppColors.primary : AppColors.white,
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: AppColors.primary),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: _selected == value ? AppColors.white : AppColors.primary,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
