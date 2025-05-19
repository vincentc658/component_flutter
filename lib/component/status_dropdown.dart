import 'package:flutter/material.dart';

import '../constant/constants_color.dart';

class StatusDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String label;
  final String? helperText;
  final String? errorText;
  final bool isRequired;
  const StatusDropdown({
    Key? key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.helperText,
    this.errorText,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.teal.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            if (isRequired)
              Text("*", style: TextStyle(fontSize: 14, color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.filter_alt,
              color: ConstantsColor.PRIMARY,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            filled: true,
            fillColor: Colors.white70,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ConstantsColor.PRIMARY),
            ),
          ),
          items:
              options.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: TextStyle(fontSize: 12, color: Colors.red.shade600),
          ),
        ],
        const SizedBox(height: 18),
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
