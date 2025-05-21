import 'package:flutter/material.dart';

import '../../constant/constants_color.dart';
import '../../constant/constants_styling.dart';
import 'dropdown_option.dart';
import 'form_field_config.dart';

class InputFieldDropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final List<DropdownOption> options;
  final ValueChanged<String?> onChanged;
  final String? label;
  final String? helperText;
  final String? hintText;
  final String? errorText;
  final bool isRequired;
  final IconData? icon;

  InputFieldDropdownWidget({
    Key? key,
    required FormFieldConfig fieldConfig,
    required this.selectedValue,
    required this.onChanged,
    this.errorText,
  }) : label = fieldConfig.label,
       hintText = fieldConfig.hint,
       helperText = fieldConfig.helper,
       isRequired = fieldConfig.isRequired,
       icon = fieldConfig.icon,
       options = fieldConfig.dropdownOptions ?? [],
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        if (label != null)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    label!,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: ConstantsColor.PRIMARY.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (isRequired)
                    const Text(
                      "*",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text(
            hintText ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            prefixIcon:
                icon != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: Icon(icon, color: ConstantsColor.PRIMARY),
                    )
                    : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            errorText: errorText,
            errorStyle: TextStyle(
              color: Colors.red.shade700,
              fontSize: 13,
            ),
            filled: true,
            fillColor: Colors.white,
            border: ConstantsStyling.enabledBorder,
            enabledBorder: ConstantsStyling.enabledBorder,
            focusedBorder: ConstantsStyling.focusedBorder,
            errorBorder: ConstantsStyling.errorBorder,
          ),
          items:
              options.map((status) {
                return DropdownMenuItem<String>(
                  value: status.name,
                  child: Text(
                    status.name,
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
        if (helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            helperText!,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
        const SizedBox(height: 18),
      ],
    );
  }
}
