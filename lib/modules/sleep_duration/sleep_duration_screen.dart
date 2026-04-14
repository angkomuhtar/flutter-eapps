import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:flutter_eapps/modules/sleep_duration/sleep_provider.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SleepDurationScreen extends ConsumerStatefulWidget {
  const SleepDurationScreen({super.key});

  @override
  ConsumerState<SleepDurationScreen> createState() =>
      _SleepDurationScreenState();
}

class _SleepDurationScreenState extends ConsumerState<SleepDurationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  File? selectedImage;

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  Future<void> chooseImage() async {
    final picker = ImagePicker();
    XFile? image;
    image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50, // compress 50%
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Foto wajib diunggah')));
      return;
    }

    LoadingWidget.show(context, message: 'Menyimpan durasi tidur...');

    final (success, errorMessage) = await ref
        .read(uploadSleepProvider.notifier)
        .upload(
          hour: int.parse(_hourController.text),
          minute: int.parse(_minuteController.text),
          image: selectedImage!,
        );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil menyimpan durasi tidur')),
      );
      _hourController.clear();
      _minuteController.clear();
      setState(() => selectedImage = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage ?? 'Gagal menyimpan durasi tidur')),
      );
    }
    LoadingWidget.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadSleepProvider);
    final todayState = ref.watch(todayAttendanceProvider);
    final isLoading = uploadState.isLoading;
    final todaySleep = todayState.valueOrNull?.sleep;

    if (todaySleep != null) {
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
                  'assets/lottie/success.json',
                  width: 200,
                  height: 200,
                  repeat: true,
                ),
                Gap(24),
                Text(
                  'Durasi Tidur Hari Ini Telah Tercatat',
                  style: TextStyle(
                    fontSize: 18,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: InputText(
                            controller: _hourController,
                            labelText: 'Jam',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.more_time_rounded,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Jam tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: InputText(
                            controller: _minuteController,
                            labelText: 'Menit',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.more_time_rounded,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Menit tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.secondaryLight),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: selectedImage != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: Image.file(
                                      selectedImage!,
                                      height: 180,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Gap(12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                          ),
                                        ),
                                        onPressed: isLoading
                                            ? null
                                            : chooseImage,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_rounded,
                                              color: AppColors.secondaryLight,
                                            ),
                                            Gap(8),
                                            Text(
                                              'Ubah Foto',
                                              style: TextStyle(
                                                color: AppColors.secondaryLight,
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
                                    onPressed: isLoading ? null : chooseImage,
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      color: AppColors.secondaryLight,
                                      size: 40,
                                    ),
                                  ),
                                  Text('Unggah Foto'),
                                ],
                              ),
                      ),
                    ),
                    Gap(20),
                    ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Simpan',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
