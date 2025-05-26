import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/custom_toolbar.dart';
import 'package:research_component/component/formField/input_field_dropdown_widget.dart';
import 'package:research_component/constant/constants_form_field.dart';
import '../component/formField/dropdown_option.dart';
import '../component/formField/form_field_config.dart';
import '../component/formField/form_helper.dart';
import '../component/formField/input_field_text_widget.dart';
import '../constant/constants_color.dart';

class FormScreenAddress extends StatefulWidget {
  const FormScreenAddress({Key? key}) : super(key: key);
  @override
  State<FormScreenAddress> createState() => FormScreenAddressState();
}

class FormScreenAddressState extends State<FormScreenAddress> {
  late FormHelper formHelper;
  Map<String, String?> errors = {};
  FormFieldConfig configFirstName = FormFieldConfig(
    labelField: 'Alamat (sesuai tanda pengenal)',
    hint: 'Input Alamat',
    isRequired: true,
    isShowLabel: true,
    keyboardType: TextInputType.streetAddress,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configLastName = FormFieldConfig(
    labelField: 'LastName',
    hint: 'Enter your name',
    isRequired: true,
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configEmail = FormFieldConfig(
    labelField: 'Email',
    hint: 'Enter your email',
    icon: Icons.email,
    keyboardType: TextInputType.emailAddress,
    isRequired: true,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configPassword = FormFieldConfig(
    labelField: 'Password',
    hint: 'Enter your password',
    icon: Icons.lock,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configStatus = FormFieldConfig(
    labelField: 'Status',
    hint: 'Select your Status',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    isRequired: true,
    icon: Icons.filter_alt,
    dropdownOptions: [
      DropdownOption(id: '1', name: 'Testing'),
      DropdownOption(id: '3', name: 'Testingting'),
      DropdownOption(id: '2', name: 'Testing 2'),
    ],
  );

  List<FormFieldConfig> fieldsToValidate = [];
  final Map<String, TextEditingController> controllers = {};
  final Map<String, String?> dropdownValues = {};

  bool validateCurrentStep() {
    setState(() {
      formHelper.validate();
    });
    return formHelper.isValid;
  }

  @override
  void initState() {
    super.initState();
    fieldsToValidate.add(configFirstName);
    fieldsToValidate.add(configLastName);
    fieldsToValidate.add(configEmail);
    fieldsToValidate.add(configPassword);
    fieldsToValidate.add(configStatus);

    formHelper = FormHelper(fieldsToValidate);
    for (var field in fieldsToValidate) {
      if (field.fieldType == ConstantsFormField.TYPE_INPUT_DROPDOWN) {
        dropdownValues[field.labelField] = null;
      } else {
        controllers[field.labelField] = TextEditingController();
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
      formHelper.validate();
    });

    if (formHelper.isValid) {
      for (var field in fieldsToValidate) {
        final value =
            field.fieldType == ConstantsFormField.TYPE_INPUT_DROPDOWN
                ? formHelper.getDropdownValue(field.labelField)
                : formHelper.getText(field.labelField);
        print('${field.labelField}: $value');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,title: Text("Alamat", style: TextStyle(fontWeight:FontWeight.w700, fontSize: 24,color: ConstantsColor.PRIMARY ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configFirstName,
                      controller: formHelper.controllers[configFirstName.labelField]!,
                      errorText: formHelper.errors[configFirstName.labelField],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configLastName,
                      controller: formHelper.controllers[configLastName.labelField]!,
                      errorText: formHelper.errors[configLastName.labelField],
                    ),
                  ),
                ],
              ),

              InputFieldTextWidget(
                fieldConfig: configEmail,
                controller: formHelper.controllers[configEmail.labelField]!,
                errorText: formHelper.errors[configEmail.labelField],
              ),
              InputFieldTextWidget(
                fieldConfig: configPassword,
                controller: formHelper.controllers[configPassword.labelField]!,
                errorText: formHelper.errors[configPassword.labelField],
              ),
              InputFieldDropdownWidget(
                fieldConfig: configStatus,
                selectedValue: formHelper.dropdownValues[configStatus.labelField],
                errorText: formHelper.errors[configStatus.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(configStatus.labelField, value);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
