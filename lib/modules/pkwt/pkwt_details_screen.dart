import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/contract_model.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:flutter_eapps/modules/pkwt/pkwt_page.dart';
import 'package:flutter_eapps/modules/pkwt/pkwt_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';

class PkwtDetailsScreen extends ConsumerStatefulWidget {
  final ContractModel items;

  const PkwtDetailsScreen({super.key, required this.items});

  @override
  ConsumerState<PkwtDetailsScreen> createState() => _PkwtDetailsScreenState();
}

class _PkwtDetailsScreenState extends ConsumerState<PkwtDetailsScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1.5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );
  bool _isChecked = false;
  bool _isSigned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit(bool haveSigned, int userId) async {
    // Simpan tanda tangan atau lakukan aksi lainnya
    LoadingWidget.show(context, message: 'Menyimpan tanda tangan...');
    try {
      var _formData = Map<String, dynamic>();
      if (haveSigned) {
        _formData = {
          "already_have_sign": haveSigned,
          "user_id": userId,
          "contract_id": widget.items.id,
        };
      } else {
        final signatureData = await _controller.toPngBytes();
        if (signatureData != null) {
          _formData = {
            "already_have_sign": haveSigned,
            "user_id": userId,
            "contract_id": widget.items.id,
            "sign": base64Encode(signatureData),
          };
        }
      }
      final (success, errorMessage) = await ref
          .read(signedContractProvider.notifier)
          .sign(_formData);

      LoadingWidget.hide(context);
      if (success) {
        await AlertWidget.show(
          context: context,
          title: 'Berhasil',
          description:
              'Berhasil Menyimpan tanda tangan dan menyetujui kontrak kerja.',
          type: 'success',
        ).then((_) {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? 'Gagal menyimpan tanda tangan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      LoadingWidget.hide(context);
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan Kontrak Kerja'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
    print(url);
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

        await Dio().download(url, filePath);

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
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isSigned = _controller.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.items;
    final user = ref.watch(userLoginDataProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Detail Kontrak Kerja'),
            Expanded(
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
                            title: "Jenis Kontrak",
                            value: item.contractType.name,
                          ),
                          itemValue(title: "Nomor Kontrak", value: item.code),
                          itemValue(
                            title: "Status Kontrak",
                            child: Statusbadge(status: item.status),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: itemValue(
                                  title: "Tanggal Mulai",
                                  value: DateFormat('dd MMMM yyyy', 'id-ID')
                                      .format(
                                        DateFormat(
                                          'dd/MM/yyyy',
                                        ).parse(item.startDate),
                                      ),
                                ),
                              ),
                              Expanded(
                                child: itemValue(
                                  title: "Tanggal Berakhir",
                                  value: DateFormat('dd MMMM yyyy', 'id-ID')
                                      .format(
                                        DateFormat(
                                          'dd/MM/yyyy',
                                        ).parse(item.endDate),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          itemValue(
                            title: "Durasi Kontrak",
                            value: "${item.contractType.duration} bulan",
                          ),
                          itemValue(
                            title: "Template Dokumen",
                            value: item.docTemplate.name,
                          ),
                          itemValue(
                            title: "Dokumen Kontrak",
                            child: GestureDetector(
                              onTap: () {
                                downloadFile(
                                  'https://e-pkwt.mitraabadimahakam.id/storage/${item.contractDocument.file}',
                                  item.contractDocument.file,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Lihat Dokumen",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.items.status == 'send') ...[
                        if (user?.signature != null) ...[
                          Gap(16),
                          Text(
                            "Tanda Tangan Anda:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.network(
                              'https://e-pkwt.mitraabadimahakam.id/storage/signatures/${user!.signature}',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                    child: Text(
                                      'Gagal memuat tanda tangan',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                            ),
                          ),
                        ] else ...[
                          Gap(16),
                          Text(
                            "Anda belum memiliki tanda tangan. Silakan buat tanda tangan Anda di bawah ini:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Signature(
                                    controller: _controller,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 2,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (_controller.isNotEmpty) {
                                          _controller.undo();
                                        }
                                      },
                                      icon: Icon(Icons.undo),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _controller.redo();
                                      },
                                      icon: Icon(Icons.redo),
                                    ),
                                    IconButton(
                                      onPressed: () => _controller.clear(),
                                      icon: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                "Anda telah membaca dan menyatakan setuju dengan semua isi kontrak kerja ini.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                _isChecked &&
                                    ((_isSigned && user?.signature == null) ||
                                        (user?.signature != null))
                                ? () => _submit(
                                    user?.signature != null ? true : false,
                                    user?.id ?? 0,
                                  )
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Tanda Tangan & Setuju',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                      Gap(14),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
