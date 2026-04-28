import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';

class InputText extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool disable;
  final VoidCallback? onTap;
  final String? initialValue;

  const InputText({
    super.key,
    this.controller,
    required this.labelText,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.disable = false,
    this.onTap,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      initialValue: initialValue,
      readOnly: readOnly,
      enabled: !disable,
      onTap: onTap,
      style: TextStyle(
        color: disable ? AppColors.grey : AppColors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        fillColor: AppColors.white,
        filled: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        alignLabelWithHint: maxLines != 1,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
