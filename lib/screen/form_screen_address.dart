import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/custom_toolbar.dart';
import 'package:research_component/component/formField/input_field_dropdown_widget.dart';
import 'package:research_component/constant/constants_form_field.dart';
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
    idTag: 'FirstName',
    label: 'First Name',
    hint: 'Enter your name',
    isRequired: true,
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configLastName = FormFieldConfig(
    idTag: 'LastName',
    label: 'Last Name',
    hint: 'Enter your name',
    isRequired: true,
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configEmail = FormFieldConfig(
    idTag: 'Email',
    label: 'Email',
    hint: 'Enter your email',
    icon: Icons.email,
    keyboardType: TextInputType.emailAddress,
    isRequired: true,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configPassword = FormFieldConfig(
    idTag: 'Password',
    label: 'Password',
    hint: 'Enter your password',
    icon: Icons.lock,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configStatus = FormFieldConfig(
    idTag: 'Status',
    label: 'Status',
    hint: 'Select your Status',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    isRequired: true,
    icon: Icons.filter_alt,
    dropdownOptions: ['Active', 'Inactive', 'Pending'],
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
        dropdownValues[field.idTag] = null;
      } else {
        controllers[field.idTag] = TextEditingController();
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
                ? formHelper.getDropdownValue(field.idTag)
                : formHelper.getText(field.idTag);
        print('${field.label}: $value');
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
                      controller: formHelper.controllers[configFirstName.idTag]!,
                      errorText: formHelper.errors[configFirstName.idTag],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configLastName,
                      controller: formHelper.controllers[configLastName.idTag]!,
                      errorText: formHelper.errors[configLastName.idTag],
                    ),
                  ),
                ],
              ),

              InputFieldTextWidget(
                fieldConfig: configEmail,
                controller: formHelper.controllers[configEmail.idTag]!,
                errorText: formHelper.errors[configEmail.idTag],
              ),
              InputFieldTextWidget(
                fieldConfig: configPassword,
                controller: formHelper.controllers[configPassword.idTag]!,
                errorText: formHelper.errors[configPassword.idTag],
              ),
              InputFieldDropdownWidget(
                fieldConfig: configStatus,
                selectedValue: formHelper.dropdownValues[configStatus.idTag],
                errorText: formHelper.errors[configStatus.idTag],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(configStatus.idTag, value);
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
