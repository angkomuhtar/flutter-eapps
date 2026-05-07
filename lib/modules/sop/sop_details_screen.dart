import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/sop/sop_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';

class SopDetailsScreen extends ConsumerStatefulWidget {
  final String id;
  final String folder;

  const SopDetailsScreen({super.key, required this.id, required this.folder});

  @override
  ConsumerState<SopDetailsScreen> createState() => _SopDetailsScreenState();
}

class _SopDetailsScreenState extends ConsumerState<SopDetailsScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> downloadFile(String url, String fileName) async {
    print(url);
    LoadingWidget.show(context, message: 'Mengunduh file...');
    try {
      print(url);
      final permission =
          Platform.isAndroid &&
              (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33
          ? Permission.manageExternalStorage
          : Permission.storage;

      if (await permission.request().isGranted) {
        final dir = Platform.isAndroid
            ? Directory('/storage/emulated/0/Download')
            : await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/$fileName';

        await Dio().download(url, filePath);

        OpenFile.open(filePath);
      } else {
        print('Storage permission denied');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Izin penyimpanan diperlukan untuk mengunduh file'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengunduh file'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      LoadingWidget.hide(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    final sopDetailsAsync = ref.watch(sopDetailsProvider(id));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: widget.folder),
            Expanded(
              child: sopDetailsAsync.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: EmptyList(
                        message: 'Belum ada kontrak kerja yang tersedia',
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                        itemCount: data.length,
                        separatorBuilder: (context, index) => Gap(12),
                        itemBuilder: (context, index) {
                          final item = data[index];
                          if (item.type == 'folder')
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          else
                            return GestureDetector(
                              onTap: () =>
                                  downloadFile(item.url!, item.fileName),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Icon(
                                      Icons.insert_drive_file_rounded,
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
                                      Icons.download_rounded,
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
                  );
                },
                loading: () => Center(child: const LoadingList()),
                error: (error, stack) => Center(child: const ErrorList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
