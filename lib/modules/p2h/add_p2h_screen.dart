import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/clock_today_model.dart';
import 'package:flutter_eapps/core/models/units_model.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:flutter_eapps/modules/attendance/attendance_provider.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_eapps/modules/p2h/p2h_page.dart';
import 'package:flutter_eapps/modules/p2h/p2h_provider.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as Picker;

class AddP2hScreen extends ConsumerStatefulWidget {
  const AddP2hScreen({super.key});

  @override
  ConsumerState<AddP2hScreen> createState() => _AddP2hScreenState();
}

class Options {
  final String value;
  final String label;
  const Options({required this.value, required this.label});
}

const _bodyCondition = [
  Options(value: 'fit', label: 'Fit'),
  Options(value: 'nonfit', label: 'Non Fit'),
];

class ChecklistFormData {
  final String checklist_id;
  final String status;
  final String? note;

  ChecklistFormData({
    required this.checklist_id,
    required this.status,
    this.note,
  });

  Map<String, dynamic> toJson() => {
    'checklist_id': int.tryParse(checklist_id) ?? checklist_id,
    'status': status,
    'note': note,
  };
}

class _AddP2hScreenState extends ConsumerState<AddP2hScreen> {
  final _formKey = GlobalKey<FormState>();
  final categoryKey = GlobalKey<FormFieldState<UnitCategoryModel>>();
  final _formData = <String, dynamic>{};
  final _checklistData = <ChecklistFormData>[];
  final _searchController = TextEditingController();
  final _unitController = TextEditingController();
  final _dateTimeController = TextEditingController();

  String durasi = '';
  Options? _selectedBodyCondition;
  UnitCategoryModel? _selectedCategory;
  UnitsModel? selectedUnit;
  DateTime? dateTime;
  Shift? _selectedShift;

  int getDurationInMinutes(DateTime start, DateTime end) {
    return end.difference(start).inMinutes;
  }

  String formatDurationHumanReadable(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours jam $minutes menit';
    }
    return '$minutes menit';
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setChecklistAnswer(String checklistId, String status) {
    setState(() {
      final index = _checklistData.indexWhere(
        (c) => c.checklist_id == checklistId,
      );
      final existingNote = index != -1 ? _checklistData[index].note : null;
      final newItem = ChecklistFormData(
        checklist_id: checklistId,
        status: status,
        note: status == 'no' ? existingNote : null,
      );
      if (index != -1) {
        _checklistData[index] = newItem;
      } else {
        _checklistData.add(newItem);
      }
      _formData['$checklistId'] = status;
    });
  }

  void _setChecklistNote(String checklistId, String? note) {
    setState(() {
      final index = _checklistData.indexWhere(
        (c) => c.checklist_id == checklistId,
      );
      if (index != -1) {
        final old = _checklistData[index];
        _checklistData[index] = ChecklistFormData(
          checklist_id: old.checklist_id,
          status: old.status,
          note: note,
        );
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    _formData['inspections'] = _checklistData.map((e) => e.toJson()).toList();

    LoadingWidget.show(context, message: 'Menyimpan Laporan P2H');

    final (success, errorMessage) = await ref
        .read(submitP2hProvider.notifier)
        .upload(_formData);

    if (!mounted) return;

    LoadingWidget.hide(context);

    if (success) {
      _formKey.currentState!.reset();
      setState(() {
        _selectedCategory = null;
        _selectedBodyCondition = null;
        selectedUnit = null;
        _unitController.clear();
        _dateTimeController.clear();
        dateTime = null;
        _formData.clear();
        _checklistData.clear();
      });

      await AlertWidget.show(
        context: context,
        title: 'Berhasil',
        description: 'Berhasil memperbarui penanganan laporan bahaya',
        type: 'success',
      ).then((_) {
        final tabController = ref.read(p2hTabControllerProvider);
        if (tabController != null) {
          tabController.animateTo(1);
        }
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

  @override
  Widget build(BuildContext context) {
    final unitCategory = ref.watch(getUnitCategoryProvider).valueOrNull ?? [];
    final inspection = ref.watch(
      getP2hInspectionProvider((selectedUnit?.id).toString()),
    );
    final today = ref.watch(todayAttendanceProvider).valueOrNull;
    final myForm = ref.watch(myP2hFormProvider);
    final shiftList = ref.watch(listShiftProvider).valueOrNull ?? [];

    return Column(
      children: [
        Expanded(
          child: myForm.when(
            data: (data) {
              if (data != '0') {
                return SafeArea(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/lottie/plane.json',
                            width: 200,
                            height: 200,
                            repeat: true,
                          ),
                          Text(
                            'Form P2H sebelumnya belum closed. Silakan menunggu persetujuan dari atasan dan Close form tersebut.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (today?.shift == null)
                          //   Container(
                          //     width: double.infinity,
                          //     decoration: BoxDecoration(
                          //       color: AppColors.primary,
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 16,
                          //       vertical: 12,
                          //     ),
                          //     child: Text(
                          //       'Anda tidak memiliki shift kerja hari ini. Silakan melakukan absen masuk terlebih dahulu sebelum mengisi laporan P2H.',
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w700,
                          //         color: AppColors.white,
                          //       ),
                          //     ),
                          //   ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: InputText(
                                    key: const ValueKey('start_meter'),
                                    labelText: 'Start HM/KM',
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Start HM/KM harus diisi',
                                      ),
                                    ]),
                                    onSaved: (value) {
                                      _formData['start_meter'] = value;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InputText(
                                    key: const ValueKey('end_meter'),
                                    labelText: 'End HM/KM',
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    onSaved: (value) {
                                      _formData['end_meter'] = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: InputText(
                                    key: const ValueKey(
                                      'sleep_duration_minutes',
                                    ),
                                    labelText: 'Lama Tidur (jam)',
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Lama Tidur harus diisi',
                                      ),
                                    ]),
                                    onSaved: (value) {
                                      _formData['sleep_duration_minutes'] =
                                          value;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: DropdownWidget<Options>(
                                    labelText: 'Kondisi Tubuh',
                                    value: _selectedBodyCondition,
                                    items: _bodyCondition,
                                    itemLabel: (category) =>
                                        '${category.label}',
                                    validator: FormBuilderValidators.required(
                                      errorText: 'Pilih salah satu',
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedBodyCondition = value;
                                      });
                                      _formData['body_condition'] =
                                          value?.value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownWidget<Shift>(
                            labelText: 'Shift Kerja',
                            value: _selectedShift,
                            items: shiftList,
                            itemLabel: (shift) =>
                                '${shift.name} (${shift.start} - ${shift.end})',
                            validator: FormBuilderValidators.required(
                              errorText: 'Pilih salah satu',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedShift = value;
                              });
                              _formData['work_shift_id'] = value?.id;
                            },
                          ),

                          GestureDetector(
                            onTap: () {
                              Picker.DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  dateTime = date;
                                  _dateTimeController.text = DateFormat(
                                    'dd-MMM-yy HH:mm',
                                  ).format(date);
                                },
                                currentTime: dateTime != null
                                    ? dateTime
                                    : DateTime.now(),
                                locale: Picker.LocaleType.id,
                              );
                            },
                            child: InputText(
                              labelText: 'Waktu Pengecekan',
                              readOnly: true,
                              disable: true,
                              controller: _dateTimeController,
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.required(
                                errorText: 'Harus diisi',
                              ),
                              onSaved: (v) {
                                if (dateTime != null) {
                                  _formData['date'] = DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(dateTime!);
                                  _formData['activity_start_time'] = DateFormat(
                                    'HH:mm',
                                  ).format(dateTime!);
                                }
                              },
                            ),
                          ),
                          DropdownWidget<UnitCategoryModel>(
                            labelText: 'Kategori',
                            value: _selectedCategory,
                            key: categoryKey,
                            items: unitCategory,
                            itemLabel: (category) =>
                                '${category.name} (${category.code})',
                            validator: FormBuilderValidators.required(
                              errorText: 'Pilih salah satu',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                              _formData['unit_category'] = value?.id;
                            },
                          ),

                          GestureDetector(
                            onTap: () {
                              _selectedCategory == null
                                  ? categoryKey.currentState?.validate()
                                  : showModalBottomSheet<Map<String, dynamic>>(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext modalContext) {
                                        String localSearchQuery = "";
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return Consumer(
                                              builder: (context, ref, child) {
                                                final searchUnitAsync = ref
                                                    .watch(
                                                      getUnitListProvider(
                                                        searchQuery:
                                                            localSearchQuery,
                                                        category:
                                                            _selectedCategory!
                                                                .id,
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
                                                              'Cari Unit',
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          controller:
                                                              _searchController,
                                                          autofocus: true,
                                                          onChanged: (value) {
                                                            setModalState(() {
                                                              localSearchQuery =
                                                                  value ?? "";
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                          height: 200,
                                                          child: searchUnitAsync.when(
                                                            data: (units) {
                                                              if (units
                                                                  .isEmpty) {
                                                                return Center(
                                                                  child: Text(
                                                                    'Tidak ada hasil',
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              return ListView.builder(
                                                                itemCount: units
                                                                    .length,
                                                                itemBuilder: (context, index) {
                                                                  final data =
                                                                      units[index];
                                                                  return ListTile(
                                                                    title: Text(
                                                                      '${data.unit_code} - ${data.unit_type}',
                                                                    ),
                                                                    subtitle: Text(
                                                                      '${data.brand} - ${data.model} (${data.plate_number})',
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                        context,
                                                                        {
                                                                          'data':
                                                                              data,
                                                                        },
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            loading: () =>
                                                                Center(
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
                                                                      color: Colors
                                                                          .grey,
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
                                      if (value != null) {
                                        setState(() {
                                          selectedUnit = value['data'];
                                        });
                                        _formData['unit_id'] = value['data'].id;
                                        _unitController.text =
                                            '${value['data'].unit_code} - ${value['data'].brand} ${value['data'].model}';
                                      }
                                      _searchController.clear();
                                    });
                            },
                            child: InputText(
                              labelText: 'Code Unit',
                              readOnly: true,
                              disable: true,
                              controller: _unitController,
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.required(
                                errorText: 'Unit harus dipilih',
                              ),
                            ),
                          ),

                          if (selectedUnit != null) ...[
                            inspection.when(
                              data: (headers) {
                                if (headers.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Tidak ada hasil',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  );
                                }
                                return Column(
                                  spacing: 4,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: headers.asMap().entries.map((
                                        entry,
                                      ) {
                                        final index = entry.key;
                                        final header = entry.value;
                                        return _buildAccordionItem(
                                          title: '${index + 1}. ${header.name}',
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: header.form_checklist.map((
                                              checklist,
                                            ) {
                                              return FormField(
                                                validator: (value) =>
                                                    _formData['${checklist.id}'] ==
                                                        null
                                                    ? 'Pilih salah satu'
                                                    : null,
                                                builder: (state) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 6,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              AppColors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .secondaryLight
                                                                .withAlpha(50),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          spacing: 6,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              spacing: 8,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  checklist.form_category.symbol ==
                                                                          "square"
                                                                      ? Icons
                                                                            .square_rounded
                                                                      : checklist.form_category.symbol ==
                                                                            "triangle"
                                                                      ? Icons
                                                                            .change_history_rounded
                                                                      : checklist.form_category.symbol ==
                                                                            "circle"
                                                                      ? Icons
                                                                            .circle_rounded
                                                                      : Icons
                                                                            .help_outline_rounded,
                                                                  color:
                                                                      checklist
                                                                              .form_category
                                                                              .color ==
                                                                          "red"
                                                                      ? Colors
                                                                            .red
                                                                      : checklist.form_category.color ==
                                                                            "yellow"
                                                                      ? Colors
                                                                            .yellow
                                                                      : checklist.form_category.color ==
                                                                            "green"
                                                                      ? Colors
                                                                            .green
                                                                      : Colors
                                                                            .grey,
                                                                  size: 22,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    checklist
                                                                        .question,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: AppColors
                                                                          .secondaryDark,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              spacing: 12,
                                                              children: [
                                                                _buildRadioOption(
                                                                  'good',
                                                                  'Baik',
                                                                  checklist.id
                                                                      .toString(),
                                                                ),
                                                                _buildRadioOption(
                                                                  'bad',
                                                                  'Tidak',
                                                                  checklist.id
                                                                      .toString(),
                                                                ),
                                                                _buildRadioOption(
                                                                  'n/a',
                                                                  'Tidak Tersedia',
                                                                  checklist.id
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                            if (_formData['${checklist.id}'] ==
                                                                'bad') ...[
                                                              InputText(
                                                                labelText:
                                                                    'Deskripsi Masalah',
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                minLines: 2,
                                                                maxLines: 4,
                                                                onSaved: (value) =>
                                                                    _setChecklistNote(
                                                                      checklist
                                                                          .id
                                                                          .toString(),
                                                                      value,
                                                                    ),
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
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 12,
                                                                top: 8,
                                                              ),
                                                          child: Text(
                                                            state.errorText!,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .red
                                                                  .shade700,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),

                                                      Gap(12),
                                                    ],
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    InputText(
                                      key: const ValueKey('notes'),
                                      labelText: 'Catatan Umum',
                                      keyboardType: TextInputType.text,
                                      maxLines: 3,
                                      minLines: 3,
                                      onSaved: (value) {
                                        _formData['notes'] = value;
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
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Kirim Laporan',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              error: (error, stack) => Center(
                                child: Text(
                                  'Terjadi Kesalahan',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              loading: () => SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Lottie.asset(
                                        'assets/lottie/loading.json',
                                        width: 150,
                                        height: 150,
                                        repeat: true,
                                      ),
                                      Text(
                                        'Mengambil Pertanyaan Inspeksi',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
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
    );
  }

  Widget _buildAccordionItem({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(12),
          child,
        ],
      ),
      // child: Theme(
      //   data: ThemeData().copyWith(dividerColor: Colors.transparent),
      //   child: ExpansionTile(
      //     tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      //     childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      //     title: Text(
      //       title,
      //       style: const TextStyle(
      //         fontSize: 14,
      //         fontWeight: FontWeight.w600,
      //         color: AppColors.textPrimary,
      //       ),
      //     ),
      //     iconColor: AppColors.primary,
      //     collapsedIconColor: AppColors.textSecondary,
      //     children: [child],
      //   ),
      // ),
    );
  }

  Widget _buildRadioOption(String value, String label, String questionSlug) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _setChecklistAnswer(questionSlug, value),
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
