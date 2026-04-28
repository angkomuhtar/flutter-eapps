import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/options_model.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:flutter_eapps/modules/inspection/inspection_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class InspectionFormScreen extends ConsumerStatefulWidget {
  final String slug;
  const InspectionFormScreen({super.key, required this.slug});

  @override
  ConsumerState<InspectionFormScreen> createState() =>
      _InspectionFormScreenState();
}

const _shiftOptions = [
  {'value': 'day', 'label': 'Shift Pagi'},
  {'value': 'night', 'label': 'Shift Malam'},
];

class _InspectionFormScreenState extends ConsumerState<InspectionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final _dueDateController = TextEditingController();
  HazardLocationModel? _selectedHazardLocation;
  Map<String, String>? _selectedShift;
  DateTime? selectedDate;

  @override
  void dispose() {
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    LoadingWidget.show(context, message: 'Menyimpan laporan bahaya...');
    final (success, errorMessage) = await ref
        .read(uploadInspectionProvider.notifier)
        .upload(_formData);

    // if (!mounted) return;

    debugPrint('Form Data: $success, $errorMessage');
    debugPrint(_formData.toString());
    LoadingWidget.hide(context);
    if (success) {
      _formKey.currentState!.reset();
      setState(() {
        _selectedHazardLocation = null;

        _selectedShift = null;
        selectedDate = null;
        _dueDateController.clear();
        _formData.clear();
      });

      await AlertWidget.show(
        context: context,
        title: 'Berhasil',
        description: 'Berhasil memperbarui penanganan laporan bahaya',
        type: 'success',
      ).then((_) {
        Navigator.pop(context);
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

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _dueDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hazardLocation =
        ref.watch(listHazardLocationProvider).valueOrNull ?? [];
    final question =
        ref.watch(GetInspectionProvider(slug: widget.slug)).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Kartu Inspeksi'),
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    child: Form(
                      key: _formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputText(
                            key: const ValueKey('inspection_id'),
                            controller: TextEditingController(
                              text: question.isNotEmpty
                                  ? 'Inspeksi ${question[0].inspection.name}'
                                  : '',
                            ),
                            labelText: 'Jenis Inspeksi Inspeksi',
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'harus diisi',
                              ),
                            ]),
                            onSaved: (value) {
                              if (question.isNotEmpty)
                                _formData['inspection_id'] =
                                    question[0].inspection.id;
                            },
                          ),
                          DropdownWidget<Map<String, String>>(
                            labelText: 'Shift',
                            value: _selectedShift,
                            items: _shiftOptions,
                            itemLabel: (shift) => shift['label'] ?? '',
                            validator: FormBuilderValidators.required(
                              errorText: 'Pilih salah satu',
                            ),
                            onChanged: (value) {
                              debugPrint(value.toString());
                              setState(() {
                                _selectedShift = value;
                                _formData['shift'] = value?['value'];
                              });
                            },
                          ),
                          InputText(
                            key: const ValueKey('inspection_date'),
                            controller: _dueDateController,
                            labelText: 'Tanggal Inspeksi',
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: _selectDate,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'harus diisi',
                              ),
                            ]),
                            onSaved: (value) {
                              if (selectedDate != null)
                                _formData['date'] = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(selectedDate!);
                            },
                          ),
                          DropdownWidget<HazardLocationModel>(
                            labelText: 'Lokasi Inspeksi',
                            value: _selectedHazardLocation,
                            items: hazardLocation,
                            itemLabel: (location) => location.name,
                            validator: FormBuilderValidators.required(
                              errorText: 'Pilih salah satu',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedHazardLocation = value;
                                _formData['id_location'] = value?.id;
                              });
                            },
                          ),
                          if (_selectedHazardLocation != null &&
                              _selectedHazardLocation!.id == 999)
                            InputText(
                              key: const ValueKey('lokasi_lainnya'),
                              labelText: 'Lokasi Lainnya',
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Lokasi Lainnya harus diisi',
                                ),
                              ]),
                              onSaved: (value) {
                                _formData['other_location'] = value;
                              },
                            ),
                          InputText(
                            key: const ValueKey('detail_lokasi'),
                            labelText: 'Detail lokasi',
                            keyboardType: TextInputType.multiline,
                            minLines: 2,
                            maxLines: 2,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Detail lokasi harus diisi',
                              ),
                            ]),
                            onSaved: (value) {
                              _formData['detail_location'] = value;
                            },
                          ),

                          ...question.map((q) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 12,
                              children: [
                                Text(
                                  q.sub_inspenction,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryDark,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                ...q.questions.map((quest) {
                                  return FormField(
                                    validator: (value) =>
                                        _formData['${quest.slug}'] == null
                                        ? 'Pilih salah satu'
                                        : null,
                                    builder: (state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AppColors.secondaryLight,
                                              ),
                                            ),
                                            child: Column(
                                              spacing: 6,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  quest.question,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        AppColors.secondaryDark,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: 12,
                                                  children: [
                                                    _buildRadioOption(
                                                      'yes',
                                                      'Sesuai',
                                                      quest.slug,
                                                    ),
                                                    _buildRadioOption(
                                                      'no',
                                                      'Tidak Sesuai',
                                                      quest.slug,
                                                    ),
                                                    _buildRadioOption(
                                                      'na',
                                                      'N/A',
                                                      quest.slug,
                                                    ),
                                                  ],
                                                ),
                                                if (_formData['${quest.slug}'] ==
                                                    'no') ...[
                                                  InputText(
                                                    labelText:
                                                        'Deskripsi ketidaksesuaian',
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    minLines: 2,
                                                    maxLines: 4,
                                                    onSaved: (value) {
                                                      _formData['note_${quest.slug}'] =
                                                          value;
                                                    },
                                                    validator:
                                                        FormBuilderValidators.required(
                                                          errorText:
                                                              'Harus diisi',
                                                        ),
                                                  ),
                                                  Gap(1),
                                                  InputText(
                                                    labelText: 'dueDate',
                                                    controller:
                                                        TextEditingController(
                                                          text:
                                                              _formData['date_${quest.slug}'] ??
                                                              '',
                                                        ),
                                                    readOnly: true,
                                                    onTap: () =>
                                                        showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate: DateTime(
                                                            2030,
                                                          ),
                                                        ).then((pickedDate) {
                                                          if (pickedDate !=
                                                              null) {
                                                            setState(() {
                                                              _formData['date_${quest.slug}'] =
                                                                  DateFormat(
                                                                    'yyyy-MM-dd',
                                                                  ).format(
                                                                    pickedDate,
                                                                  );
                                                            });
                                                          }
                                                        }),
                                                    validator:
                                                        FormBuilderValidators.required(
                                                          errorText:
                                                              'Harus diisi',
                                                        ),
                                                  ),
                                                ],
                                              ],
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
                                  );
                                }).toList(),
                              ],
                            );
                          }).toList(),
                          InputText(
                            key: const ValueKey('recommendation'),
                            labelText: 'Rekomendasi Dari Hasil Inspeksi',
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 3,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Rekomendasi harus diisi',
                              ),
                            ]),
                            onSaved: (value) {
                              _formData['recommendation'] = value;
                            },
                          ),
                          Gap(16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submit,
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
                                'Kirim Inspeksi',
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value, String label, String questionSlug) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _formData['$questionSlug'] = value;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _formData['$questionSlug'],
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
