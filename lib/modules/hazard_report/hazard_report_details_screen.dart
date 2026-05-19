import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard_report/hazard_report_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';

class HazardReportDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const HazardReportDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<HazardReportDetailsScreen> createState() =>
      _HazardReportDetailsScreenState();
}

class _HazardReportDetailsScreenState
    extends ConsumerState<HazardReportDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  File? selectedImage;
  final _searchController = TextEditingController();
  final _picController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(DetailHazardReportProvider(id: widget.id));

    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();

      LoadingWidget.show(context, message: 'Menyimpan laporan bahaya...');
      debugPrint('Form data to submit: $_formData');
      // return;

      final (success, errorMessage) = await ref
          .read(updateActionProvider.notifier)
          .setpic(_formData);

      if (!mounted) return;

      LoadingWidget.hide(context);

      if (success) {
        _formKey.currentState!.reset();
        setState(() {
          selectedImage = null;
          _formData.clear();
        });

        AlertWidget.show(
          context: context,
          title: 'Berhasil',
          description: 'Berhasil memperbarui penanganan laporan bahaya',
          type: 'success',
        ).then((_) {
          Navigator.of(context).pop();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? 'Gagal menyimpan laporan bahaya'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Detail Laporan'),
            Expanded(
              child: detailAsync.when(
                data: (data) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(detailHazardReportProvider(id: widget.id));
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
                                  title: "Nomor Laporan",
                                  value: data.hazard_number,
                                ),
                                itemValue(
                                  title: "Status Laporan",
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: data.status == "OPEN"
                                          ? AppColors.red
                                          : data.status == "ONPROGRESS"
                                          ? AppColors.yellow
                                          : AppColors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      data.status == "OPEN"
                                          ? "Open"
                                          : data.status == "ONPROGRESS"
                                          ? "On Progress"
                                          : "Closed",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                itemValue(
                                  title: "Tanggal Laporan",
                                  value:
                                      DateFormat(
                                        'EEEE, dd MMM yyyy - hh:mm a',
                                        'id_ID',
                                      ).format(
                                        DateFormat(
                                          "yyyy-MM-dd HH:mm:ss",
                                        ).parse(data.date),
                                      ),
                                ),
                                itemValue(
                                  title: "Kategori Bahaya",
                                  value: data.category == 'TTA'
                                      ? "Tindakan Tidak Aman"
                                      : "Kondisi Tidak Aman",
                                ),
                                itemValue(
                                  title: "Lokasi Temuan",
                                  value: data.location?.id == 999
                                      ? data.other_location ?? '-'
                                      : data.location?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Detail Lokasi temuan",
                                  value: data.detail_location ?? '',
                                ),
                              ],
                            ),
                            Text(
                              'Departement Terkait',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Perusahaan",
                                  value: data.company?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Project",
                                  value: data.project?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Departement",
                                  value: data.division?.name ?? '-',
                                ),
                              ],
                            ),
                            Text(
                              'Detail Temuan Bahaya',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Kondisi Temuan",
                                  value: data.condition,
                                ),
                                itemValue(
                                  title: "Rekomendasi Tindakan",
                                  value: data.recomended_action,
                                ),
                                itemValue(
                                  title: "Tindakan yang diambil",
                                  value: data.action_taken,
                                ),
                                itemValue(
                                  title: "Lampiran Laporan",
                                  child: ImageViewer(
                                    imageUrl: data.report_attachment,
                                  ),
                                ),
                                itemValue(
                                  title: "Batas Waktu Penanganan",
                                  value:
                                      DateFormat(
                                        'EEEE, dd MMM yyyy',
                                        'id_ID',
                                      ).format(
                                        DateFormat(
                                          'yyyy-MM-dd',
                                        ).parse(data.due_date),
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              'Detail Pelapor',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Dilaporkan oleh",
                                  value: data.reporter?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Jabatan Pelapor",
                                  value:
                                      '${data.reporter?.dept ?? '-'} - ${data.reporter?.position}',
                                ),
                              ],
                            ),
                            if (data.action != null) ...[
                              Text(
                                'Pengawas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ContBox(
                                children: [
                                  itemValue(
                                    title: "Nama",
                                    value: data.action?.supervisor?.name ?? '-',
                                  ),
                                  itemValue(
                                    title: "Jabatan",
                                    value:
                                        '${data.action?.supervisor?.dept ?? '-'} - ${data.action?.supervisor?.position ?? '-'}',
                                  ),
                                ],
                              ),
                              Text(
                                'Penanggung Jawab',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ContBox(
                                children: [
                                  itemValue(
                                    title: "Nama",
                                    value: data.action?.pic?.name ?? '-',
                                  ),
                                  itemValue(
                                    title: "Jabatan",
                                    value:
                                        '${data.action?.pic?.dept ?? '-'} - ${data.action?.pic?.position ?? '-'}',
                                  ),
                                ],
                              ),
                            ],

                            if (data.status == "OPEN") ...[
                              Text(
                                'Pilih PIC',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: ContBox(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<Map<String, dynamic>>(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext modalContext) {
                                            String localSearchQuery = "";
                                            return StatefulBuilder(
                                              builder: (context, setModalState) {
                                                return Consumer(
                                                  builder: (context, ref, child) {
                                                    final searchPicAsync = ref
                                                        .watch(
                                                          getPICListProvider(
                                                            searchName:
                                                                localSearchQuery,
                                                          ),
                                                        );
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                          context,
                                                        ).viewInsets.bottom,
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 16,
                                                            ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          spacing: 16,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 100,
                                                              height: 6,
                                                              decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .secondaryLight,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      5,
                                                                    ),
                                                              ),
                                                            ),
                                                            InputText(
                                                              labelText:
                                                                  'Cari PIC',
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              controller:
                                                                  _searchController,
                                                              autofocus: true,
                                                              onChanged: (value) {
                                                                setModalState(() {
                                                                  localSearchQuery =
                                                                      value ??
                                                                      "";
                                                                });
                                                              },
                                                            ),
                                                            Container(
                                                              height: 200,
                                                              child:
                                                                  localSearchQuery ==
                                                                      ""
                                                                  ? Center(
                                                                      child: Text(
                                                                        'Ketik untuk mencari PIC',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : searchPicAsync.when(
                                                                      data: (pics) {
                                                                        if (pics
                                                                            .isEmpty) {
                                                                          return Center(
                                                                            child: Text(
                                                                              'Tidak ada hasil',
                                                                              style: TextStyle(
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        return ListView.builder(
                                                                          itemCount:
                                                                              pics.length,
                                                                          itemBuilder:
                                                                              (
                                                                                context,
                                                                                index,
                                                                              ) {
                                                                                final pic = pics[index];
                                                                                return ListTile(
                                                                                  title: Text(
                                                                                    pic.name,
                                                                                  ),
                                                                                  subtitle: Text(
                                                                                    '${pic.jabatan} - ${pic.divisi}',
                                                                                  ),
                                                                                  onTap: () {
                                                                                    Navigator.pop(
                                                                                      context,
                                                                                      {
                                                                                        'id': pic.id,
                                                                                        'name': pic.name,
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                        );
                                                                      },
                                                                      loading: () => Center(
                                                                        child: Text(
                                                                          'Mencari...',
                                                                        ),
                                                                      ),
                                                                      error:
                                                                          (
                                                                            error,
                                                                            stack,
                                                                          ) => Center(
                                                                            child: Text(
                                                                              'Tidak ada hasil',
                                                                              style: TextStyle(
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                    ),
                                                            ),
                                                            Gap(24),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ).then((value) {
                                          print(value);
                                          if (value != null) {
                                            setState(() {
                                              _formData['pic'] = value['id'];
                                              _formData['hazard_report_id'] =
                                                  data.id;
                                              _picController.text =
                                                  value['name'];
                                            });
                                          }
                                          _searchController.clear();
                                        });
                                      },
                                      child: InputText(
                                        labelText: 'PIC Penanganan',
                                        readOnly: true,
                                        disable: true,
                                        controller: _picController,
                                        keyboardType: TextInputType.text,
                                        validator:
                                            FormBuilderValidators.required(
                                              errorText: 'PIC harus dipilih',
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _submit();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Simpan Perubahan',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(14),
                            ],

                            if (data.status == "CLOSED") ...[
                              Text(
                                'Penanganan Laporan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ContBox(
                                children: [
                                  itemValue(
                                    title: "Status Perbaikan",
                                    value: data.action?.status == 'DONE'
                                        ? 'Selesai'
                                        : 'Pending',
                                  ),
                                  itemValue(
                                    title: "Tanggal Update Penanganan",
                                    value:
                                        DateFormat(
                                          'EEEE, dd MMM yyyy',
                                          'id_ID',
                                        ).format(
                                          DateTime.parse(
                                            data.action?.updated_at ?? '',
                                          ),
                                        ),
                                  ),
                                  itemValue(
                                    title: "Catatan Penanganan",
                                    value: data.action?.notes ?? '-',
                                  ),
                                  itemValue(
                                    title: "Foto Penanganan",
                                    child: ImageViewer(
                                      imageUrl: data.action?.image ?? '',
                                    ),
                                  ),
                                ],
                              ),
                              Gap(14),
                            ],
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
