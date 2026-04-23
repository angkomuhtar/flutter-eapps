import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        children: [
          Lottie.asset('assets/lottie/loading.json', width: 200),
          Text(
            'Memuat data...',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.secondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  final String? message;
  const EmptyList({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        children: [
          Lottie.asset('assets/lottie/empty.json', width: 200),
          Gap(16),
          Text(
            message ?? 'Tidak ada data',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondaryLight,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorList extends StatelessWidget {
  const ErrorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        children: [
          Lottie.asset('assets/lottie/error.json', width: 200),
          Text(
            'Terjadi kesalahan',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.secondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
