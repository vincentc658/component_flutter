import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/custom_toolbar.dart';
import 'package:research_component/component/input_field_widget.dart';
import 'package:research_component/constant/constants_form_field.dart';

import '../component/form_field_config.dart';

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
  ];

  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      controllers[field.label] = TextEditingController();
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
        final value = controllers[field.label]?.text ?? '';
        if (value.isEmpty) {
          errors[field.label] = '${field.label} is required';
        }
      }
    });

    if (errors.isEmpty) {
      for (var field in fields) {
        final value = controllers[field.label]?.text ?? '';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...fields.map(
              (field) => InputFieldWidget(
                label: field.label,
                hintText: field.hint,
                icon: field.icon,
                helperText: field.helper,
                errorText: errors[field.label],
                // Pass error
                keyboardType: field.keyboardType,
                obscureText: field.obscureText,
                controller: controllers[field.label]!,
                isRequired: field.isRequired,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: handleSubmit,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
