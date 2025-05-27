import 'package:flutter/material.dart';
import '../../constant/constants_color.dart';
import '../../constant/constants_styling.dart';
import 'dropdown_option.dart';
import 'form_field_config.dart';

class InputFieldRadioGroup extends StatefulWidget {
  final DropdownOption? selectedValue;
  final List<DropdownOption> options;
  final ValueChanged<DropdownOption?> onChanged;
  final String? label;
  final String? helperText;
  final String? errorText;
  final bool isRequired;

  InputFieldRadioGroup({
    Key? key,
    required FormFieldConfig fieldConfig,
    this.selectedValue,
    required this.onChanged,
    this.errorText,
  })  : label = fieldConfig.labelField,
        helperText = fieldConfig.helper,
        isRequired = fieldConfig.isRequired,
        options = fieldConfig.dropdownOptions ?? [],
        super(key: key);

  @override
  State<InputFieldRadioGroup> createState() => _InputFieldRadioGroupState();
}

class _InputFieldRadioGroupState extends State<InputFieldRadioGroup> {
  DropdownOption? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  void _handleChange(DropdownOption? value) {
    setState(() {
      _selectedValue = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.label!,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: ConstantsColor.PRIMARY.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (widget.isRequired)
                    const Text(
                      "*",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ...widget.options.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4), // atur jarak antar item di sini
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<DropdownOption>(
                  value: option,
                  groupValue: _selectedValue,
                  onChanged: _handleChange,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: ConstantsColor.PRIMARY,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(option.name)),
              ],
            ),
          );
        }).toList(),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
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
