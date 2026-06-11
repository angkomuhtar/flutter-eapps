import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/options_model.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:flutter_eapps/modules/hazard/hazard_page.dart';
import 'package:flutter_eapps/modules/hazard/hazard_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/dropdown-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDailyActivityScreen extends ConsumerStatefulWidget {
  const AddDailyActivityScreen({super.key});

  @override
  ConsumerState<AddDailyActivityScreen> createState() =>
      _AddDailyActivityScreenState();
}

class _AddDailyActivityScreenState
    extends ConsumerState<AddDailyActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final _dueDateController = TextEditingController();
  HazardLocationModel? _selectedHazardLocation;
  CompanyModel? _selectedCompany;
  ProjectModel? _selectedProject;
  DepartementModel? _selectedDepartement;
  File? selectedImage;
  DateTime? selectedDate;

  @override
  void dispose() {
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    LoadingWidget.show(context, message: 'Menyimpan aktivitas harian...');

    final (success, errorMessage) = await ref
        .read(uploadHazardProvider.notifier)
        .upload(_formData);

    if (!mounted) return;

    LoadingWidget.hide(context);

    if (success) {
      _formKey.currentState!.reset();
      setState(() {
        _selectedHazardLocation = null;
        _selectedCompany = null;
        _selectedProject = null;
        _selectedDepartement = null;
        selectedImage = null;
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
        final tabController = ref.read(hazardTabControllerProvider);
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

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
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
    final company = ref.watch(listCompanyProvider).valueOrNull ?? [];
    final project =
        ref
            .watch(listProjectProvider((_selectedCompany?.id).toString()))
            .valueOrNull ??
        [];
    final departement =
        ref
            .watch(listDepartementProvider((_selectedCompany?.id).toString()))
            .valueOrNull ??
        [];

    final user = ref.watch(userLoginDataProvider).valueOrNull;

    debugPrint(user.toString());

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
                InputText(
                  labelText: 'Nama',
                  initialValue: user?.name ?? '',
                  disable: true,
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Nama harus diisi',
                    ),
                  ]),
                ),
                InputText(
                  labelText: 'NIK',
                  initialValue: user?.employee?.nip ?? '',
                  disable: true,
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'NIK harus diisi',
                    ),
                  ]),
                ),
                InputText(
                  labelText: 'Jabatan',
                  initialValue: user?.employee?.jabatan ?? '',
                  disable: true,
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Jabatan harus diisi',
                    ),
                  ]),
                ),

                DropdownWidget<HazardLocationModel>(
                  labelText: 'Lokasi temuan bahaya',
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
                Text(
                  "Departement Terkait",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryDark,
                  ),
                  textAlign: TextAlign.start,
                ),
                DropdownWidget<CompanyModel>(
                  labelText: 'Perusahaan',
                  value: _selectedCompany,
                  items: company,
                  itemLabel: (company) => company.name,
                  validator: FormBuilderValidators.required(
                    errorText: 'Pilih salah satu',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedCompany = value;
                      _formData['company_id'] = value?.id;
                      _selectedProject = null;
                      _selectedDepartement = null;
                      _formData.remove('project');
                      _formData.remove('departement');
                    });
                  },
                ),
                DropdownWidget<ProjectModel>(
                  labelText: 'Project',
                  value: _selectedProject,
                  items: project,
                  itemLabel: (project) => project.name,
                  validator: FormBuilderValidators.required(
                    errorText: 'Pilih salah satu',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedProject = value;
                      _formData['project_id'] = value?.id;
                    });
                  },
                ),
                DropdownWidget<DepartementModel>(
                  labelText: 'Departement',
                  value: _selectedDepartement,
                  items: departement,
                  itemLabel: (departement) => departement.name,
                  validator: FormBuilderValidators.required(
                    errorText: 'Pilih salah satu',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedDepartement = value;
                      _formData['dept_id'] = value?.id;
                    });
                  },
                ),

                InputText(
                  key: const ValueKey('due_date'),
                  controller: _dueDateController,
                  labelText: 'Batas Waktu Penanganan',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onTap: _selectDate,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'harus diisi'),
                  ]),
                  onSaved: (value) {
                    if (selectedDate != null)
                      _formData['due_date'] = DateFormat(
                        'yyyy-MM-dd',
                      ).format(selectedDate!);
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
