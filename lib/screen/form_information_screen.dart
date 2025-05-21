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
    idTag: 'FirstName',
    label: 'Nama Depan',
    isRequired: true,
    hint: 'Enter your name',
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configLastName = FormFieldConfig(
    idTag: 'LastName',
    label: 'Nama Belakang',
    hint: 'Enter your name',
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configEmail = FormFieldConfig(
    idTag: 'Email',
    label: 'Email',
    hint: 'Enter your email',
    icon: Icons.email,
    isRequired: true,
    keyboardType: TextInputType.emailAddress,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );

  FormFieldConfig configStatus = FormFieldConfig(
    idTag: 'Status',
    label: 'Status',
    hint: 'Pilih Status',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    isRequired: true,
    dropdownOptions: [
      DropdownOption(id: '1', name: 'Single'),
      DropdownOption(id: '3', name: 'Menikah'),
    ],
  );
  FormFieldConfig configSex = FormFieldConfig(
    idTag: 'Sex',
    label: 'Jenis Kelamin',
    hint: 'Pilih Jenis Kelamin',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    isRequired: true,
    dropdownOptions: [
      DropdownOption(id: '1', name: 'Laki-Laki'),
      DropdownOption(id: '3', name: 'Perempuan'),
    ],
  );
  FormFieldConfig configDOB = FormFieldConfig(
    idTag: 'Tanggal Lahir',
    label: 'Tanggal Lahir',
    hint: 'Pilih Tanggal',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    isRequired: true,
  );

  FormFieldConfig configAddress = FormFieldConfig(
    idTag: 'Full Address',
    label: 'Alamat Lengkap',
    hint: 'Input Alamat Lengkap',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    isRequired: true,
    icon: Icons.location_on,
  );
  FormFieldConfig configPostalCode = FormFieldConfig(
    idTag: 'Kode Pos',
    helper: 'Kode Pos',
    hint: 'Input Kode Pos',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    isRequired: true,
  );
  FormFieldConfig configSubdistrict = FormFieldConfig(
    idTag: 'Kecamatan',
    helper: 'Kecamatan',
    hint: 'Input Kecamatan',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    isRequired: true,
  );
  FormFieldConfig configProvince = FormFieldConfig(
    idTag: 'Provinsi',
    helper: 'Provinsi',
    hint: 'Pilih Provinsi',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
    isRequired: true,
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
    idTag: 'Acc Type',
    label: 'Jenis Rekening',
    hint: 'Pilih Jenis Rekening',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    isRequired: true,
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
    return formHelper.isValid;
  }

  String getInfo() {
    return formHelper.getText(fieldsToValidate[0].idTag) ?? '-';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                "Informasi",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: ConstantsColor.PRIMARY,
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configFirstName,
                      controller:
                          formHelper.controllers[configFirstName.idTag]!,
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

              InputFieldDatePicker(
                fieldConfig: configDOB,
                controller: formHelper.controllers[configDOB.idTag]!,
                errorText: formHelper.errors[configDOB.idTag],
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
              InputFieldDropdownWidget(
                fieldConfig: configSex,
                selectedValue: formHelper.dropdownValues[configSex.idTag],
                errorText: formHelper.errors[configSex.idTag],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(configSex.idTag, value);
                  });
                },
              ),

              InputFieldTextWidget(
                fieldConfig: configAddress,
                controller:
                formHelper.controllers[configAddress.idTag]!,
                errorText: formHelper.errors[configAddress.idTag],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configSubdistrict,
                      controller:
                      formHelper.controllers[configSubdistrict.idTag]!,
                      errorText: formHelper.errors[configSubdistrict.idTag],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configPostalCode,
                      controller: formHelper.controllers[configPostalCode.idTag]!,
                      errorText: formHelper.errors[configPostalCode.idTag],
                    ),
                  ),
                ],
              ),

              InputFieldSearchDropdown(
                fieldConfig: configProvince,
                controller: formHelper.controllers[configProvince.idTag]!,
                errorText: formHelper.errors[configProvince.idTag],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(
                      configProvince.idTag,
                      value.name,
                    );
                  });
                },
              ),
              InputFieldDropdownWidget(
                fieldConfig: configAccountType,
                selectedValue: formHelper.dropdownValues[configAccountType.idTag],
                errorText: formHelper.errors[configAccountType.idTag],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(configAccountType.idTag, value);
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
