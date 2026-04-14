import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RekapWidget extends ConsumerWidget {
  const RekapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rekapAsync = ref.watch(rekapAttendanceProvider);

    return rekapAsync.when(
      data: (data) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.10),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rekap Absensi',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Gap(4),
              Text(
                '${DateFormat("dd MMM yyyy").format(DateTime.parse(data.start))} - ${DateFormat("dd MMM yyyy").format(DateTime.parse(data.end))}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Gap(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RekapData(title: 'Hadir', value: '${data.hadir}'),
                    Container(width: 1, height: 30, color: Colors.grey),
                    RekapData(title: 'Izin', value: '${data.izin}'),
                    Container(width: 1, height: 30, color: Colors.grey),
                    RekapData(title: 'Alpa', value: '${data.alpa}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        print('error get data $error');
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Gagal memuat data',
                style: TextStyle(color: AppColors.accent),
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: () => ref.invalidate(rekapAttendanceProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
    );
  }
}

class RekapData extends StatelessWidget {
  final String value;
  final String title;

  const RekapData({super.key, this.title = "", this.value = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        ),
        Text(title),
      ],
    );
  }
}
