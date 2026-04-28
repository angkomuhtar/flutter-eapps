import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/inspection/inspection_provider.dart';
import 'package:flutter_eapps/widget/hazard/hazard-card-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class InspectionHistoryScreen extends ConsumerStatefulWidget {
  const InspectionHistoryScreen({super.key});

  @override
  ConsumerState<InspectionHistoryScreen> createState() =>
      _InspectionHistoryScreenState();
}

class _InspectionHistoryScreenState
    extends ConsumerState<InspectionHistoryScreen> {
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
      _hasMore = ref.read(inspectionHistoryProvider.notifier).hasMore;
      if (!_hasMore) return;
      _isLoadingMore = true;
      ref.read(inspectionHistoryProvider.notifier).loadMore().then((_) {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(inspectionHistoryProvider);
    final hasMore = ref.read(inspectionHistoryProvider.notifier).hasMore;

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
                    ref.read(inspectionHistoryProvider.notifier).setFilter('');
                  },
                  title: 'Semua',
                  ref: ref,
                  value: '',
                ),
                filterPills(
                  onTap: () {
                    ref
                        .read(inspectionHistoryProvider.notifier)
                        .setFilter('created');
                  },
                  title: 'Belum diperiksa',
                  ref: ref,
                  value: 'created',
                ),
                filterPills(
                  onTap: () {
                    ref
                        .read(inspectionHistoryProvider.notifier)
                        .setFilter('verified');
                  },
                  title: 'Terferivikasi',
                  ref: ref,
                  value: 'verified',
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
                    ref.read(inspectionHistoryProvider.notifier).refresh(),
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
                                context.push('/inspection/${item.id}/details'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Inspeksi ${item.inspection.name}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            item.inspection_number,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: item.status == "created"
                                              ? AppColors.yellow
                                              : item.status == "verified"
                                              ? AppColors.green
                                              : AppColors.red,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          item.status == "created"
                                              ? "Baru"
                                              : item.status == "verified"
                                              ? "Terverifikasi"
                                              : "Closed",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
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
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 10,
                                      children: [
                                        itemValue(
                                          title: "Lokasi",
                                          value: item.location.id == 999
                                              ? item.other_location ?? '-'
                                              : item.location.name,
                                        ),
                                        itemValue(
                                          title: "Tanggal Inspeksi",
                                          value:
                                              DateFormat(
                                                'EEEE, dd MMM yy',
                                                'id_ID',
                                              ).format(
                                                DateFormat(
                                                  'yyyy-MM-dd',
                                                ).parse(item.date),
                                              ),
                                        ),
                                        itemValue(
                                          title: "Shift",
                                          value:
                                              (item.shift == 'day'
                                                      ? 'Shift Pagi'
                                                      : 'Shift Malam')
                                                  .toUpperCase(),
                                        ),
                                        // itemValue(
                                        //   title: "Due Date",
                                        //   value: DateFormat(
                                        //     'EEEE, dd MMM yy',
                                        //     'id_ID',
                                        //   ).format(DateTime.parse(item.due_date)),
                                        // ),
                                        // itemValue(
                                        //   title: "Dept Terkait",
                                        //   value: item.division?.name ?? '-',
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(
                                //   padding: const EdgeInsets.all(12),
                                //   width: double.infinity,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       Text(
                                //         timeago.format(
                                //           DateTime.parse(item.date),
                                //           locale: 'id',
                                //         ),
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //           color: Colors.grey.shade700,
                                //         ),
                                //         maxLines: 3,
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                        // return hazardCard(
                        //   item: item,
                        //   onTap: () {
                        //     debugPrint(
                        //       "Hazard card tapped: ${item.hazard_number}",
                        //     );
                        //     context.push('/hazard/details/${item.id}');
                        //   },
                        // );
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
    final _selected = ref.read(inspectionHistoryProvider.notifier).filter;
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
