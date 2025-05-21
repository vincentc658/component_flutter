import 'package:flutter/material.dart';
import 'package:research_component/constant/constants_color.dart';
import 'package:research_component/constant/constants_styling.dart';

import 'form_field_config.dart';

class InputFieldTextWidget extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  final bool isRequired;
  final TextInputType keyboardType;

  InputFieldTextWidget({
    Key? key,
    required FormFieldConfig fieldConfig,
    required this.controller,
    this.errorText,
  }) : label = fieldConfig.label,
       hintText = fieldConfig.hint,
       helperText = fieldConfig.helper,
       icon = fieldConfig.icon,
       obscureText = fieldConfig.obscureText,
       isRequired = fieldConfig.isRequired,
       keyboardType = fieldConfig.keyboardType ?? TextInputType.text,
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            prefixIcon:
                icon != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: Icon(icon, color: ConstantsColor.PRIMARY),
                    )
                    : null,
            hintText: hintText,
            errorText: errorText,
            errorStyle: TextStyle(
              color: Colors.red.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            border: ConstantsStyling.enabledBorder,
            enabledBorder: ConstantsStyling.enabledBorder,
            focusedBorder: ConstantsStyling.focusedBorder,
            errorBorder: ConstantsStyling.errorBorder,
          ),
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
