import 'dart:ffi';

import 'package:flutter/material.dart';

import 'dropdown_option.dart';

class FormFieldConfig {
  //tag is using to defined the field unique name
  final String labelField;
  final String? hint;
  final String? helper;
  final String? error;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isRequired;
  final bool isShowLabel;

  // New: Dropdown support
  final int fieldType;
  final List<DropdownOption>? dropdownOptions;

  FormFieldConfig({
    required this.labelField,
    this.hint,
    required this.fieldType,
    this.isShowLabel=true,
    this.helper,
    this.error,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.isRequired = false,
    this.dropdownOptions,
  });
}
