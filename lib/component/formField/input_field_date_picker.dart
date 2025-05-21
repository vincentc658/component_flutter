import 'package:flutter/material.dart';
import '../../constant/constants_color.dart';
import '../../constant/constants_styling.dart';
import 'form_field_config.dart';

class InputFieldDatePicker extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  final bool isRequired;
  final TextInputType keyboardType;

  InputFieldDatePicker({
    Key? key,
    required FormFieldConfig fieldConfig,
    required this.controller,
    this.errorText,
  })  : label = fieldConfig.label,
        hintText = fieldConfig.hint,
        helperText = fieldConfig.helper,
        icon = fieldConfig.icon,
        obscureText = fieldConfig.obscureText,
        isRequired = fieldConfig.isRequired,
        keyboardType = fieldConfig.keyboardType ?? TextInputType.text,
        super(key: key);

  @override
  State<InputFieldDatePicker> createState() => _InputFieldDatePickerState();
}

class _InputFieldDatePickerState extends State<InputFieldDatePicker> {
  DateTime? selectedDate;

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ConstantsColor.PRIMARY.shade800,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.controller.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  widget.label!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: ConstantsColor.PRIMARY.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.isRequired)
                  const Text(
                    " *",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
              ],
            ),
          ),
        TextField(
          controller: widget.controller,
          readOnly: true,
          onTap: _showDatePicker,
          decoration: InputDecoration(
            hintStyle :TextStyle(color: Colors.grey),
            hintText: widget.hintText ?? 'Select date',
            prefixIcon: Icon(
              Icons.calendar_today,
              color: ConstantsColor.PRIMARY,
            ),
            filled: true,
            fillColor: Colors.white,
            border: ConstantsStyling.enabledBorder,
            enabledBorder: ConstantsStyling.enabledBorder,
            focusedBorder: ConstantsStyling.focusedBorder,
            errorBorder: ConstantsStyling.errorBorder,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            errorText: widget.errorText,
          ),
        ),
        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.helperText!,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
        const SizedBox(height: 18),
      ],
    );
  }
}
