import 'package:flutter/material.dart';

import '../../constant/constants_color.dart';
import '../../constant/constants_styling.dart';
import 'dropdown_option.dart';
import 'form_field_config.dart';

class InputFieldDropdownWidget extends StatefulWidget {
  final DropdownOption? selectedValue;
  final List<DropdownOption> options;
  final ValueChanged<DropdownOption?> onChanged;
  final String? label;
  final String? helperText;
  final String? hintText;
  final String? errorText;
  final bool isRequired;
  final bool isShowLabel;
  final IconData? icon;

  InputFieldDropdownWidget({
    Key? key,
    required FormFieldConfig fieldConfig,
    this.selectedValue,
    required this.onChanged,
    this.errorText,
  })  : label = fieldConfig.labelField,
        hintText = fieldConfig.hint,
        helperText = fieldConfig.helper,
        isRequired = fieldConfig.isRequired,
        isShowLabel = fieldConfig.isShowLabel,
        icon = fieldConfig.icon,
        options = fieldConfig.dropdownOptions ?? [],
        super(key: key);

  @override
  State<InputFieldDropdownWidget> createState() => _InputFieldDropdownWidgetState();
}

class _InputFieldDropdownWidgetState extends State<InputFieldDropdownWidget> {
  DropdownOption? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedValue;
  }

  void _handleChange(DropdownOption? value) {
    setState(() {
      _currentValue = value;
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
              if (widget.isShowLabel)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.label!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: ConstantsColor.PRIMARY.shade900,
                          fontWeight: FontWeight.w600,
                        ),
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
        DropdownButtonFormField<DropdownOption>(
          value: _currentValue,
          hint: Text(
            widget.hintText ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          // icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            prefixIcon: widget.icon != null
                ? Padding(
              padding: const EdgeInsets.only(left: 10, right: 8),
              child: Icon(widget.icon, color: ConstantsColor.PRIMARY),
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            suffix: Icon(Icons.check_outlined, color: Colors.green,),
            errorText: widget.errorText,
            errorStyle: ConstantsStyling.textStyleError,
            filled: true,
            fillColor: Colors.white,
            border: ConstantsStyling.enabledBorder,
            enabledBorder: ConstantsStyling.enabledBorder,
            focusedBorder: ConstantsStyling.focusedBorder,
            errorBorder: ConstantsStyling.errorBorder,
          ),
          items: widget.options.map((DropdownOption option) {
            return DropdownMenuItem<DropdownOption>(
              value: option,
              child: Text(option.name, style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),),
            );
          }).toList(),
          onChanged: _handleChange,
        ),
        if (widget.helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.helperText!,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
        const SizedBox(height: 18),
      ],
    );
  }
}
