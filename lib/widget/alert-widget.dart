import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/constants/app_colors.dart';

class AlertWidget {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String description,
    String? lottiePath,
    String? type = 'info',
    double lottieSize = 120,
    bool lottieRepeat = true,
    String okText = 'OK',
    String? cancelText,
    Color? okColor,
    Color? cancelColor,
    bool barrierDismissible = true,
  }) {
    switch (type) {
      case 'success':
        lottiePath ??= 'assets/lottie/success.json';
        break;
      case 'error':
        lottiePath ??= 'assets/lottie/error.json';
        break;
      case 'warning':
        lottiePath ??= 'assets/lottie/warning.json';
        break;
      case 'fatal':
        lottiePath ??= 'assets/lottie/robot.json';
        break;
      default:
        lottiePath ??= 'assets/lottie/warning.json';
    }

    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lottiePath != null) ...[
                Lottie.asset(
                  lottiePath,
                  width: lottieSize,
                  height: lottieSize,
                  repeat: lottieRepeat,
                ),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (cancelText != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              cancelColor ?? AppColors.textSecondary,
                          side: BorderSide(
                            color: cancelColor ?? AppColors.divider,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(cancelText),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: okColor ?? AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(okText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
