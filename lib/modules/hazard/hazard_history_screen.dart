import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/hazard_model.dart';
import 'package:flutter_eapps/modules/hazard/hazard_provider.dart';
import 'package:flutter_eapps/modules/sleep_duration/sleep_provider.dart';
import 'package:flutter_eapps/modules/sleep_duration/widget/sleep_item_widget.dart';
import 'package:flutter_eapps/widget/hazard/hazard-card-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class HazardHistoryScreen extends ConsumerStatefulWidget {
  const HazardHistoryScreen({super.key});

  @override
  ConsumerState<HazardHistoryScreen> createState() =>
      _HazardHistoryScreenState();
}

class _HazardHistoryScreenState extends ConsumerState<HazardHistoryScreen> {
  File? selectedImage;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(listHazardProvider);

    return Expanded(
      child: historyAsync.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/empty.json', width: 200),
                  Gap(16),
                  Text(
                    'Durasi Tidur Hari Ini Telah Tercatat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(listHazardProvider.notifier).refresh(),
            child: Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Gap(12),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return hazardCard(item: item);
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
