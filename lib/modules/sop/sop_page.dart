import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/contract_model.dart';
import 'package:flutter_eapps/modules/pkwt/pkwt_provider.dart';
import 'package:flutter_eapps/modules/sop/sop_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SopPage extends ConsumerStatefulWidget {
  const SopPage({super.key});

  @override
  ConsumerState<SopPage> createState() => _SopPage();
}

class _SopPage extends ConsumerState<SopPage> {
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
      _hasMore = ref.read(listSopProvider.notifier).hasMore;
      if (!_hasMore) return;
      _isLoadingMore = true;
      ref.read(listSopProvider.notifier).loadMore().then((_) {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(listSopProvider);
    final hasMore = ref.watch(listSopProvider.notifier).hasMore;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'List SOP'),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: historyAsync.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return Center(
                            child: EmptyList(
                              message: 'Belum ada kontrak kerja yang tersedia',
                            ),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () =>
                              ref.read(listContractProvider.notifier).refresh(),
                          child: Stack(
                            children: [
                              ListView.separated(
                                controller: _scrollController,
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  16,
                                  16,
                                  40,
                                ),
                                itemCount: data.length + 1,
                                separatorBuilder: (context, index) => Gap(12),
                                itemBuilder: (context, index) {
                                  if (index == data.length) {
                                    if (!hasMore) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
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
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final item = data[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.push(
                                        '/sop/${item.id}',
                                        extra: item.title,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Icon(
                                            Icons.folder_open_rounded,
                                            color: AppColors.primary,
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            color: AppColors.secondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  // return Card(item: item);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Statusbadge extends StatelessWidget {
  final String status;

  const Statusbadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case 'success':
        color = AppColors.green;
        text = 'Aktif';
        break;
      case 'expired':
        color = Colors.red;
        text = 'Berakhir';
        break;
      case 'send':
        color = Colors.blue;
        text = 'Ditwarkan';
        break;
      case 'signed':
        color = Colors.blue;
        text = 'Menunggu HRGA';
        break;
      default:
        color = Colors.yellow;
        text = 'Perpanjangan';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key, required this.item});

  final ContractModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/contract/details', extra: item),
      child: Container(
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
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
              Container(
                width: 10,
                decoration: BoxDecoration(
                  color: item.status == 'success'
                      ? AppColors.green
                      : item.status == 'expired'
                      ? Colors.red
                      : Colors.blue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      itemValue(title: 'Nomor Kontrak', value: item.code),
                      Row(
                        children: [
                          Expanded(
                            child: itemValue(
                              title: 'Tipe Kontrak',
                              value: item.contractType.name,
                            ),
                          ),
                          Expanded(
                            child: itemValue(
                              title: 'Status Kontrak',
                              child: Statusbadge(status: item.status),
                            ),
                          ),
                        ],
                      ),
                      itemValue(
                        title: 'Tanggal Kontrak',
                        value:
                            '${DateFormat('dd MMM yyyy', 'id-ID').format(DateFormat('dd/MM/yyyy').parse(item.startDate))} s/d ${DateFormat('dd MMM yyyy', 'id-ID').format(DateFormat('dd/MM/yyyy').parse(item.endDate))}  ',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
