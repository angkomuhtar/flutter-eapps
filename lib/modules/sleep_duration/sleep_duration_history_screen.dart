import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/sleep_duration/sleep_provider.dart';
import 'package:flutter_eapps/modules/sleep_duration/widget/sleep_item_widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SleepDurationHistoryScreen extends ConsumerStatefulWidget {
  const SleepDurationHistoryScreen({super.key});

  @override
  ConsumerState<SleepDurationHistoryScreen> createState() =>
      _SleepDurationHistoryScreenState();
}

class _SleepDurationHistoryScreenState
    extends ConsumerState<SleepDurationHistoryScreen> {
  File? selectedImage;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(listSleepProvider);

    return Expanded(
      child: historyAsync.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: EmptyList(message: 'Belum ada data durasi tidur'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(listSleepProvider.notifier).refresh(),
            child: Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 60),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Gap(12),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return SleepItemWidget(
                      attachment: item.attachment,
                      start: item.start,
                      end: item.end,
                      date: item.date,
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
    );
  }
}
