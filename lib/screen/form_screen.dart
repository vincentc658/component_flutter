import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/custom_toolbar.dart';
import 'package:research_component/component/formField/input_field_dropdown_widget.dart';
import 'package:research_component/constant/constants_form_field.dart';
import '../component/formField/form_field_config.dart';
import '../component/formField/input_field_text_widget.dart';

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Map<String, String?> errors = {};
  final List<FormFieldConfig> fields = [
    FormFieldConfig(
      label: 'Name',
      hint: 'Enter your name',
      icon: Icons.person,
      keyboardType: TextInputType.name,
      fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    ),
    FormFieldConfig(
      label: 'Email',
      hint: 'Enter your email',
      icon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      isRequired: true,
      fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    ),
    FormFieldConfig(
      label: 'Password',
      hint: 'Enter your password',
      icon: Icons.lock,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    ),
    FormFieldConfig(
      label: 'Status',
      hint: 'Select your Status',
      fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
      isRequired: true,
      icon: Icons.filter_alt,
      dropdownOptions: ['Active', 'Inactive', 'Pending'],
    ),
  ];

  final Map<String, TextEditingController> controllers = {};
  final Map<String, String?> dropdownValues = {};

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      if (field.fieldType==ConstantsFormField.TYPE_INPUT_DROPDOWN) {
        dropdownValues[field.label] = null;
      } else {
        controllers[field.label] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void handleSubmit() {
    setState(() {
      errors.clear();
      for (var field in fields) {
        if (field.fieldType== ConstantsFormField.TYPE_INPUT_DROPDOWN) {
          final value = dropdownValues[field.label];
          if (field.isRequired && (value == null || value.isEmpty)) {
            errors[field.label] = '${field.label} is required';
          }
        } else {
          final value = controllers[field.label]?.text ?? '';
          if (field.isRequired && value.isEmpty) {
            errors[field.label] = '${field.label} is required';
          }
        }
      }
    });

    if (errors.isEmpty) {
      for (var field in fields) {
        final value = field.fieldType== ConstantsFormField.TYPE_INPUT_DROPDOWN
            ? dropdownValues[field.label]
            : controllers[field.label]?.text;
        print('${field.label}: $value');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolbar(
        title: 'Input Form Registration',
        isShowBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...fields.map(
                (field){
                  if(field.fieldType== ConstantsFormField.TYPE_INPUT_TEXT){
                    return InputFieldTextWidget(
                      label: field.label,
                      hintText: field.hint,
                      icon: field.icon,
                      helperText: field.helper,
                      errorText: errors[field.label],
                      keyboardType: field.keyboardType!,
                      obscureText: field.obscureText,
                      controller: controllers[field.label]!,
                      isRequired: field.isRequired,
                    );
                  }else{
                    return InputFieldDropdownWidget(
                      label: field.label,
                      icon: field.icon,
                      hintText: field.hint,
                      selectedValue: dropdownValues[field.label],
                      options: field.dropdownOptions ?? [],
                      errorText: errors[field.label],
                      isRequired: field.isRequired,
                      onChanged: (value) {
                        print('Dropdown value selected: $value'); // Tambahkan log ini
                        if (value != null) {
                          setState(() {
                            dropdownValues[field.label] = value;
                            print('Saved to dropdownValues[${field.label}] = $value');
                          });
                        }
                      },

                    );
                  }
                }
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: handleSubmit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
