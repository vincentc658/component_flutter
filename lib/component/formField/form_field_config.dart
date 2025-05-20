import 'dart:ffi';

import 'package:flutter/material.dart';

class FormFieldConfig {
  //tag is using to defined the field unique name
  final String idTag;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isRequired;

  // New: Dropdown support
  final int fieldType;
  final List<String>? dropdownOptions;

  FormFieldConfig({
    required this.idTag,
    this.hint,
    this.label,
    required this.fieldType,
    this.helper,
    this.error,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.isRequired = false,
    this.dropdownOptions,
  });
}
