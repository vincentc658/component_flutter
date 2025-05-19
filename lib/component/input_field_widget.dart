import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  final bool isRequired;
  final TextInputType keyboardType;

  const InputFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.hintText,
    this.helperText,
    this.icon,
    this.errorText,
    this.obscureText = false,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Icon(icon, color: Colors.teal),
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
              horizontal: 16,
              vertical: 18,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.teal.shade400, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
            ),
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
