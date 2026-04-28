import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard_action/hazard_action_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/image-pick-dialog.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';

class HazardActionDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const HazardActionDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<HazardActionDetailsScreen> createState() =>
      _HazardActionDetailsScreenState();
}

class _HazardActionDetailsScreenState
    extends ConsumerState<HazardActionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String>? _selectedCategory;
  Map<String, dynamic> _formData = {};
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(detailHazardActionProvider(id: widget.id));
    const _categoryOptions = [
      {'value': 'DONE', 'label': 'Selesai'},
      {'value': 'PENDING', 'label': 'Pending'},
    ];

    Future<void> chooseImage(String type) async {
      final picker = ImagePicker();
      XFile? image;
      if (type == 'camera') {
        image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50, // compress 50%
          maxWidth: 1024,
          maxHeight: 1024,
        );
      } else {
        image = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50, // compress 50%
          maxWidth: 1024,
          maxHeight: 1024,
        );
      }

      if (image != null) {
        setState(() {
          selectedImage = File(image!.path);
        });
      }
    }

    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();

      LoadingWidget.show(context, message: 'Menyimpan laporan bahaya...');
      debugPrint('Form data to submit: $_formData');
      // return;

      final (success, errorMessage) = await ref
          .read(updateActionProvider.notifier)
          .upload(_formData);

      if (!mounted) return;

      LoadingWidget.hide(context);

      if (success) {
        _formKey.currentState!.reset();
        setState(() {
          _selectedCategory = null;
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
                      ref.invalidate(detailHazardActionProvider(id: widget.id));
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
                                  title: "Penanggung Jawab",
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
                              'Penanganan Laporan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (data.status == "ONPROGRESS")
                              Form(
                                key: _formKey,
                                child: ContBox(
                                  children: [
                                    DropdownWidget<Map<String, String>>(
                                      labelText: 'Status Perbaikan',
                                      value: _selectedCategory,
                                      items: _categoryOptions,
                                      itemLabel: (category) =>
                                          category['label'] ?? '',
                                      validator: FormBuilderValidators.required(
                                        errorText: 'Pilih salah satu',
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value.toString());
                                        setState(() {
                                          _selectedCategory = value;
                                        });
                                      },
                                      onSaved: (val) {
                                        _formData['action_status'] =
                                            val?['value'];
                                        _formData['id_action'] =
                                            data.action?.id;
                                      },
                                    ),

                                    FormField<File>(
                                      validator: (value) {
                                        if (selectedImage == null) {
                                          return 'Foto harus diisi';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _formData['action_attachment'] =
                                            selectedImage;
                                      },
                                      builder: (state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              constraints: BoxConstraints(
                                                minHeight: 200,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: state.hasError
                                                      ? Colors.red
                                                      : AppColors
                                                            .secondaryLight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: selectedImage != null
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  8.0,
                                                                ),
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  3 / 2,
                                                              child: Image.file(
                                                                selectedImage!,
                                                                height: 150,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                          Gap(12),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ElevatedButton(
                                                                style: ButtonStyle(
                                                                  padding: WidgetStatePropertyAll(
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          8,
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  ImagePickDialog(
                                                                    onCamera: () =>
                                                                        chooseImage(
                                                                          'camera',
                                                                        ),
                                                                    onGallery: () =>
                                                                        chooseImage(
                                                                          'gallery',
                                                                        ),
                                                                  ).show(
                                                                    context,
                                                                  );
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .camera_alt_rounded,
                                                                      color: AppColors
                                                                          .secondaryLight,
                                                                    ),
                                                                    Gap(8),
                                                                    Text(
                                                                      'Ubah Foto',
                                                                      style: TextStyle(
                                                                        color: AppColors
                                                                            .secondaryLight,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Column(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              ImagePickDialog(
                                                                onCamera: () =>
                                                                    chooseImage(
                                                                      'camera',
                                                                    ),
                                                                onGallery: () =>
                                                                    chooseImage(
                                                                      'gallery',
                                                                    ),
                                                              ).show(context);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .camera_alt_rounded,
                                                              color: AppColors
                                                                  .secondaryLight,
                                                              size: 40,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Foto Penanganan',
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                            if (state.hasError)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12,
                                                  top: 8,
                                                ),
                                                child: Text(
                                                  state.errorText!,
                                                  style: TextStyle(
                                                    color: Colors.red.shade700,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                    InputText(
                                      labelText: 'Catatan Penanganan',
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      minLines: 3,
                                      onSaved: (val) {
                                        _formData['action_note'] = val;
                                      },
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
                                          'Update Penanganan',
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
                              )
                            else
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
