import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/modules/inspection/inspection_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InspectionDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const InspectionDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<InspectionDetailsScreen> createState() =>
      _InspectionDetailsScreenState();
}

class _InspectionDetailsScreenState
    extends ConsumerState<InspectionDetailsScreen> {
  Future<void> downloadFile(String url, String fileName) async {
    LoadingWidget.show(context, message: 'Mengunduh file...');
    try {
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

        await ref.read(dioProvider(ApiType.empapps)).download(url, filePath);

        OpenFile.open(filePath);
        print('File downloaded to: $filePath');
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
    final detailAsync = ref.watch(detailInspectionProvider(id: widget.id));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            detailAsync.maybeWhen(
              data: (data) => CustAppBar(
                title: 'Detail Inspeksi',
                trailing: data.status == "verified"
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () {
                            final fileUrl =
                                '/inspection/${data.id}/export_pdf'; // Ganti dengan URL file yang ingin diunduh
                            final fileName =
                                'Inspeksi_${(data.inspection_number).replaceAll('/', '_')}.pdf'; // Ganti dengan nama file yang diinginkan

                            downloadFile(fileUrl, fileName);
                          },
                          icon: Icon(
                            Icons.cloud_download_rounded,
                            color: AppColors.black,
                            size: 20,
                          ),
                        ),
                      )
                    : null,
              ),
              orElse: () => CustAppBar(title: 'Detail Inspeksi'),
            ),
            Expanded(
              child: detailAsync.when(
                data: (data) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(detailInspectionProvider(id: widget.id));
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Nomor Inspeksi",
                                  value: data.inspection_number,
                                ),
                                itemValue(
                                  title: "Status Inspeksi",
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: data.status == "created"
                                          ? AppColors.yellow
                                          : AppColors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      data.status == "created"
                                          ? "Baru"
                                          : "Terverifikasi",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                itemValue(
                                  title: "Jenis Inspeksi",
                                  value: 'Inspeksi ${data.inspection.name}',
                                ),
                                itemValue(
                                  title: "Lokasi Inspeksi",
                                  value: data.location.id != '999'
                                      ? data.location.name
                                      : data.other_location,
                                ),
                                itemValue(
                                  title: "Detail Lokasi Inspeksi",
                                  value: data.detail_location,
                                ),
                                itemValue(
                                  title: "Shift",
                                  value: data.shift == "day"
                                      ? "Shift Pagi"
                                      : "Shift Malam",
                                ),
                                itemValue(
                                  title: "Tanggal Laporan",
                                  value:
                                      DateFormat(
                                        'EEEE, dd MMM yyyy',
                                        'id_ID',
                                      ).format(
                                        DateFormat(
                                          "yyyy-MM-dd",
                                        ).parse(data.inspection_date),
                                      ),
                                ),
                                itemValue(
                                  title: "Rekomendasi Tindakan",
                                  value: data.recomended_action,
                                ),
                              ],
                            ),
                            Text(
                              'Petugas Inspeksi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Nama Petugas",
                                  value: data.creator?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Nomor Registrasi Petugas",
                                  value: data.creator?.nrp ?? '-',
                                ),
                                itemValue(
                                  title: "Jabatan Petugas",
                                  value: data.creator?.position ?? '-',
                                ),
                                itemValue(
                                  title: "Departement",
                                  value: data.creator?.division ?? '-',
                                ),
                              ],
                            ),
                            Text(
                              'Hasil Inspeksi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...data.answers.expand(
                              (e) => [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    Gap(8),
                                    Text(
                                      e.sub_inspection,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ...e.answers.expand(
                                  (ans) => [
                                    ContBox(
                                      children: [
                                        itemValue(
                                          title: ans.question,
                                          value: ans.answer == "yes"
                                              ? "Sesuai"
                                              : ans.answer == "no"
                                              ? "Tidak Sesuai"
                                              : "N/A",
                                        ),
                                        if (ans.answer == "no") ...[
                                          itemValue(
                                            title: "Keterangan",
                                            value: ans.note ?? "-",
                                          ),
                                          itemValue(
                                            title: 'Due Date',
                                            value:
                                                DateFormat(
                                                  'dd MMM yyyy',
                                                  'id-ID',
                                                ).format(
                                                  DateFormat(
                                                    'yyyy-MM-dd',
                                                  ).parse(ans.due_date ?? ""),
                                                ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Gap(14),
                          ],
                        ),
                      ),
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
    );
  }
}
