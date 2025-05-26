import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/formField/input_field_date_picker.dart';
import 'package:research_component/component/formField/input_field_dropdown_widget.dart';
import 'package:research_component/component/formField/input_field_search_dropdown.dart';
import 'package:research_component/constant/constants_color.dart';
import 'package:research_component/constant/constants_form_field.dart';
import '../component/formField/dropdown_option.dart';
import '../component/formField/form_field_config.dart';
import '../component/formField/form_helper.dart';
import '../component/formField/input_field_text_widget.dart';

class FormInformationScreen extends StatefulWidget {
  const FormInformationScreen({Key? key}) : super(key: key);

  @override
  State<FormInformationScreen> createState() => FormInformationScreenState();
}

class FormInformationScreenState extends State<FormInformationScreen> {
  late FormHelper formHelper;
  Map<String, String?> errors = {};
  FormFieldConfig configFirstName = FormFieldConfig(
    labelField: 'First Name',
    isRequired: true,
    hint: 'Enter your name',
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configLastName = FormFieldConfig(
    labelField: 'Last Name',
    isRequired: true,
    hint: 'Enter your name',
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configEmail = FormFieldConfig(
    labelField: 'Email',
    isRequired: true,
    hint: 'Enter your email',
    icon: Icons.email,

    keyboardType: TextInputType.emailAddress,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );

  FormFieldConfig configStatus = FormFieldConfig(
    labelField: 'Status',
    hint: 'Pilih Status',
    isRequired: true,
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Single'),
      DropdownOption(id: '3', name: 'Menikah'),
    ],
  );
  FormFieldConfig configSex = FormFieldConfig(
    labelField: 'Jenis Kelamin',
    hint: 'Pilih Jenis Kelamin',
    isRequired: true,
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Laki-Laki'),
      DropdownOption(id: '3', name: 'Perempuan'),
    ],
  );
  FormFieldConfig configBirthPlace = FormFieldConfig(
    labelField: 'Tempat Lahir',
    hint: 'Input Tempat Lahir',
    isRequired: true,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configDOB = FormFieldConfig(
    labelField: 'Tanggal Lahir',
    hint: 'Pilih Tanggal',
    isRequired: true,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );

  FormFieldConfig configAddress = FormFieldConfig(
    labelField: 'Alamat Lengkap',
    hint: 'Input Alamat Lengkap',
    isRequired: true,
    helper: 'Cth : Jln. KH. Zainul Arifin',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,

    icon: Icons.location_on,
  );
  FormFieldConfig configPostalCode = FormFieldConfig(
    labelField: 'Kode Pos',
    helper: 'Kode Pos (Optional)',
    isShowLabel: false,
    hint: 'Input Kode Pos',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configSubdistrict = FormFieldConfig(
    labelField: 'Kecamatan',
    helper: 'Kecamatan',
    isRequired: true,
    isShowLabel: false,
    hint: 'Input Kecamatan',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configProvince = FormFieldConfig(
    labelField: 'Provinsi',
    helper: 'Provinsi',
    isRequired: true,
    hint: 'Pilih Provinsi',
    fieldType: ConstantsFormField.TYPE_INPUT_SEARCH_DROPDOWN,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Aceh'),
      DropdownOption(id: '2', name: 'Sumatera Utara'),
      DropdownOption(id: '3', name: 'Sumatera Barat'),
      DropdownOption(id: '4', name: 'Sumatera Selatan'),
      DropdownOption(id: '5', name: 'Jambi'),
      DropdownOption(id: '5', name: 'Pekan Baru'),
    ],
  );
  FormFieldConfig configAccountType = FormFieldConfig(
    labelField: 'Jenis Rekening',
    isRequired: true,
    hint: 'Pilih Jenis Rekening',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Rekening Terbuka'),
      DropdownOption(id: '3', name: 'Rekening Test'),
    ],
  );

  List<FormFieldConfig> fieldsToValidate = [];

  bool validateCurrentStep() {
    setState(() {
      formHelper.validate();
    });
    handleSubmit();
    return formHelper.isValid;
  }

  String getInfo() {
    return formHelper.getText(fieldsToValidate[0].labelField) ?? '-';
  }

  @override
  void initState() {
    super.initState();
    fieldsToValidate.add(configFirstName);
    fieldsToValidate.add(configLastName);
    fieldsToValidate.add(configDOB);
    fieldsToValidate.add(configSex);
    fieldsToValidate.add(configStatus);
    fieldsToValidate.add(configAddress);
    fieldsToValidate.add(configSubdistrict);
    fieldsToValidate.add(configBirthPlace);
    fieldsToValidate.add(configPostalCode);
    fieldsToValidate.add(configProvince);
    fieldsToValidate.add(configAccountType);

    formHelper = FormHelper(fieldsToValidate);
  }

  @override
  void dispose() {
    formHelper.dispose();
    super.dispose();
  }

  void handleSubmit() {
    setState(() {
      formHelper.validate();
    });

    if (formHelper.isValid) {
      for (var field in fieldsToValidate) {
        final value =
            (field.fieldType == ConstantsFormField.TYPE_INPUT_DROPDOWN ||
                    field.fieldType ==
                        ConstantsFormField.TYPE_INPUT_SEARCH_DROPDOWN)
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Nasabah",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: ConstantsColor.PRIMARY,
                ),
              ),
              SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configFirstName,
                      controller:
                          formHelper.controllers[configFirstName.labelField]!,
                      errorText: formHelper.errors[configFirstName.labelField],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configLastName,
                      controller:
                          formHelper.controllers[configLastName.labelField]!,
                      errorText: formHelper.errors[configLastName.labelField],
                    ),
                  ),
                ],
              ),
              InputFieldTextWidget(
                fieldConfig: configBirthPlace,
                controller: formHelper.controllers[configBirthPlace.labelField]!,
                errorText: formHelper.errors[configBirthPlace.labelField],
              ),

              InputFieldDatePicker(
                fieldConfig: configDOB,
                controller: formHelper.controllers[configDOB.labelField]!,
                errorText: formHelper.errors[configDOB.labelField],
              ),

              InputFieldDropdownWidget(
                fieldConfig: configStatus,
                selectedValue:
                    formHelper.dropdownValues[configStatus.labelField],
                errorText: formHelper.errors[configStatus.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(configStatus.labelField, value);
                  });
                },
              ),
              InputFieldDropdownWidget(
                fieldConfig: configSex,
                selectedValue: formHelper.dropdownValues[configSex.labelField],
                errorText: formHelper.errors[configSex.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(configSex.labelField, value);
                  });
                },
              ),

              InputFieldTextWidget(
                fieldConfig: configAddress,
                controller: formHelper.controllers[configAddress.labelField]!,
                errorText: formHelper.errors[configAddress.labelField],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configSubdistrict,
                      controller:
                          formHelper.controllers[configSubdistrict.labelField]!,
                      errorText:
                          formHelper.errors[configSubdistrict.labelField],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configPostalCode,
                      controller:
                          formHelper.controllers[configPostalCode.labelField]!,
                      errorText: formHelper.errors[configPostalCode.labelField],
                    ),
                  ),
                ],
              ),

              InputFieldSearchDropdown(
                fieldConfig: configProvince,
                controller: formHelper.controllers[configProvince.labelField]!,
                errorText: formHelper.errors[configProvince.labelField],
                isShowId: false,
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(
                      configProvince.labelField,
                      value.name,
                    );
                  });
                },
              ),
              InputFieldDropdownWidget(
                fieldConfig: configAccountType,
                selectedValue:
                    formHelper.dropdownValues[configAccountType.labelField],
                errorText: formHelper.errors[configAccountType.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(
                      configAccountType.labelField,
                      value,
                    );
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
