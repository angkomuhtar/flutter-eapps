import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String Function(T)? itemLabel;
  final double? menuMaxHeight;

  const DropdownWidget({
    super.key,
    this.value,
    required this.items,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.itemLabel,
    this.menuMaxHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: items.contains(value) ? value : null,
      menuMaxHeight: menuMaxHeight,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(itemLabel != null ? itemLabel!(item) : item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
