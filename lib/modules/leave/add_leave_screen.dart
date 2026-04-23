import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/leave_model.dart';
import 'package:flutter_eapps/modules/leave/leave_page.dart';
import 'package:flutter_eapps/modules/leave/leave_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class AddLeaveScreen extends ConsumerStatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  ConsumerState<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends ConsumerState<AddLeaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _totalDaysController = TextEditingController();
  AbsenceTypeModel? _selectedType = null;
  final String startDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  File? selectedImage;
  Map<String, dynamic> startOptions = {
    'disable': true,
    'start': DateTime.now(),
    'end': DateTime.now().add(Duration(days: 2)),
    'initial': null,
  };
  Map<String, dynamic> endOptions = {
    'disable': true,
    'start': DateTime.now(),
    'end': DateTime.now().add(Duration(days: 2)),
    'initial': null,
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    debugPrint('Submitting leave request with data: $_formData');
    LoadingWidget.show(context, message: 'Menyimpan laporan cuti...');

    try {
      final (success, errorMessage) = await ref
          .read(uploadLeaveProvider.notifier)
          .upload(_formData);

      if (!mounted) return;

      LoadingWidget.hide(context);

      if (success) {
        _formKey.currentState!.reset();
        setState(() {
          _selectedType = null;
          _startDateController.clear();
          _endDateController.clear();
          _totalDaysController.clear();
          startOptions['disable'] = true;
          endOptions['disable'] = true;
        });
        await AlertWidget.show(
          context: context,
          title: 'Berhasil',
          description: 'Berhasil memperbarui pengajuan cuti',
          type: 'success',
        ).then((_) {
          final tabController = ref.read(LeaveTabControllerProvider);
          if (tabController != null) {
            tabController.animateTo(1);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? 'Gagal menyimpan pengajuan cuti'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      LoadingWidget.hide(context);
      debugPrint('Error submitting leave request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan pengajuan cuti: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _totalDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leaveData = ref.watch(getLeaveKuotaProvider(startDay)).valueOrNull;

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Kuota Cuti",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryDark,
                  ),
                  textAlign: TextAlign.start,
                ),
                ContBox(
                  children: [
                    itemValue(
                      title:
                          'Kuota Cuti Per Hari ini ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                      value: '${leaveData?.usable ?? 0} Hari',
                    ),
                    itemValue(
                      title: 'Maksimum Pengajuan Cuti',
                      value: '${leaveData?.maxDays ?? 0} Hari',
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.secondaryLight.withValues(
                              alpha: 0.5,
                            ),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        'Catatan: Kuota cuti dapat berubah berdasarkan tanggal mulai cuti yang dipilih.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),

                DropdownWidget<AbsenceTypeModel>(
                  labelText: 'Jenis Cuti',
                  value: _selectedType,
                  items: leaveData?.absenceType ?? [],
                  itemLabel: (type) => type.name,
                  validator: FormBuilderValidators.required(
                    errorText: 'Pilih salah satu',
                  ),
                  onChanged: (value) {
                    final dateSelect = DateTime.now();
                    setState(() {
                      _selectedType = value;
                      _formData['absence_type_id'] = value?.id;
                      _startDateController.clear();
                      _endDateController.clear();
                      endOptions['disable'] = true;
                      startOptions['disable'] = false;
                      if (value?.code == 'CP') {
                        startOptions['start'] = dateSelect.add(
                          Duration(days: 7),
                        );
                        startOptions['initial'] = null;
                      } else {
                        startOptions['start'] = dateSelect;
                        startOptions['initial'] = null;
                      }
                    });
                  },
                ),
                InputText(
                  key: const ValueKey('dateFrom'),
                  controller: _startDateController,
                  disable: startOptions['disable'],
                  labelText: 'Tanggal Mulai Cuti',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          startOptions['initial'] ?? startOptions['start'],
                      firstDate: startOptions['start'],
                      lastDate: DateTime(2030, 12, 31),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        startOptions['initial'] = pickedDate;
                        _startDateController.text = DateFormat(
                          'dd-MM-yyyy',
                        ).format(pickedDate);
                        endOptions['disable'] = false;
                        endOptions['start'] = pickedDate;
                        endOptions['initial'] = null;
                        _endDateController.clear();
                        _totalDaysController.text = '0';
                      });

                      ref
                          .read(
                            getLeaveKuotaProvider(
                              DateFormat('yyyy-MM-dd').format(pickedDate),
                            ).future,
                          )
                          .then((leaveKuota) async {
                            final maxEndDate = pickedDate.add(
                              Duration(days: leaveKuota.maxDays - 1),
                            );
                            debugPrint('Max end date: $maxEndDate');
                            await AlertWidget.show(
                              context: context,
                              title: 'Informasi Kuota Cuti',
                              description:
                                  'Kuota cuti untuk tanggal mulai ${DateFormat('dd-MM-yyyy').format(pickedDate)} adalah ${leaveKuota.maxDays} hari.',
                              type: 'success',
                            );
                            setState(() {
                              endOptions['end'] = maxEndDate;
                            });
                          })
                          .catchError((e) {
                            debugPrint('Error fetching leave kuota: $e');
                          });
                    }
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'harus diisi'),
                  ]),
                  onSaved: (value) {
                    if (startOptions['initial'] != null)
                      _formData['dateFrom'] = DateFormat(
                        'yyyy-MM-dd',
                      ).format(startOptions['initial']);
                  },
                ),
                InputText(
                  key: const ValueKey('dateTo'),
                  controller: _endDateController,
                  disable: endOptions['disable'],
                  labelText: 'Tanggal Selesai Cuti',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: endOptions['initial'] ?? endOptions['start'],
                      firstDate: endOptions['start'],
                      lastDate: endOptions['end'],
                    );
                    if (pickedDate != null) {
                      final totalDays = startOptions['initial'] != null
                          ? pickedDate
                                    .difference(startOptions['initial'])
                                    .inDays +
                                1
                          : 0;
                      _totalDaysController.text = totalDays.toString();
                      setState(() {
                        endOptions['initial'] = pickedDate;
                        _endDateController.text = DateFormat(
                          'dd-MM-yyyy',
                        ).format(pickedDate);
                      });
                    }
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'harus diisi'),
                  ]),
                  onSaved: (value) {
                    if (endOptions['initial'] != null)
                      _formData['dateTo'] = DateFormat(
                        'yyyy-MM-dd',
                      ).format(endOptions['initial']);
                  },
                ),
                InputText(
                  key: const ValueKey('totalDays'),
                  controller: _totalDaysController,
                  labelText: 'Jumlah Hari Cuti',
                  readOnly: true,
                  disable: true,
                  onSaved: (value) {
                    _formData['totalDay'] = value;
                  },
                ),
                InputText(
                  key: const ValueKey('Catatan'),
                  labelText: 'Catatan (Opsional)',
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 2,
                  onSaved: (value) {
                    _formData['notes'] = value;
                  },
                ),

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
                      'Laporkan Bahaya',
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
    );
  }
}
