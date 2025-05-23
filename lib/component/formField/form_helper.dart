import 'package:flutter/cupertino.dart';

import '../../constant/constants_form_field.dart';
import 'form_field_config.dart';

class FormHelper {
  final List<FormFieldConfig> fields;
  final Map<String, TextEditingController> controllers = {};
  final Map<String, String?> dropdownValues = {};
  final Map<String, String?> errors = {};

  FormHelper(this.fields) {
    for (var field in fields) {
      if (field.fieldType == ConstantsFormField.TYPE_INPUT_DROPDOWN) {
        dropdownValues[field.idTag] = null;
      } else if (field.fieldType == ConstantsFormField.TYPE_INPUT_SEARCH_DROPDOWN) {
        dropdownValues[field.idTag] = null;
        controllers[field.idTag] = TextEditingController();
      } else {
        controllers[field.idTag] = TextEditingController();
      }
    }
  }

  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
  }

  void validate() {
    errors.clear();
    for (var field in fields) {
      if (field.fieldType == ConstantsFormField.TYPE_INPUT_DROPDOWN) {
        final value = dropdownValues[field.idTag];
        if (field.isRequired && (value == null || value.isEmpty)) {
          errors[field.idTag] = '${field.label} is required';
        }
      } else {
        final value = controllers[field.idTag]?.text ?? '';
        if (field.isRequired && value.isEmpty) {
          errors[field.idTag] = '${field.label} is required';
        }
      }
    }
  }

  bool get isValid => errors.isEmpty;

  String? getText(String label) => controllers[label]?.text;

  String? getDropdownValue(String label) => dropdownValues[label];

  void setDropdownValue(String label, String? value) {
    print('setDropdownValue $label $value');

    dropdownValues[label] = value;
  }
}
