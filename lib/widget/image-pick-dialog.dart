import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class ImagePickDialog extends StatelessWidget {
  final void Function()? onCamera;
  final void Function()? onGallery;
  const ImagePickDialog({super.key, this.onCamera, this.onGallery});

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pilih Sumber Gambar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onCamera != null) {
                        onCamera!();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.primary,
                            size: 40,
                          ),
                          Text(
                            'Kamera',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(24),
                  GestureDetector(
                    onTap: () {
                      if (onGallery != null) {
                        onGallery!();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library_rounded,
                            color: AppColors.primary,
                            size: 40,
                          ),
                          Text(
                            'Galeri',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
