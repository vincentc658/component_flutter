import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/formField/input_field_date_picker.dart';
import 'package:research_component/component/formField/input_field_dropdown_widget.dart';
import 'package:research_component/component/formField/input_field_radio_group.dart';
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
    hint: 'Enter your name',
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configLastName = FormFieldConfig(
    labelField: 'Last Name',
    hint: 'Enter your name',
    keyboardType: TextInputType.name,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configMotherName = FormFieldConfig(
    labelField: 'Mothers Maiden Name',
    hint: 'Enter your Mothers Maiden Name',
    keyboardType: TextInputType.emailAddress,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );

  FormFieldConfig configStatus = FormFieldConfig(
    labelField: 'Status',
    hint: 'Pilih Status',
    fieldType: ConstantsFormField.TYPE_INPUT_RADIO_GROUP,
    dropdownOptions: [
      DropdownOption(id: '1', name: 'Single'),
      DropdownOption(id: '3', name: 'Menikah'),
      DropdownOption(id: '3', name: 'Duda/Janda'),
    ],
  );
  FormFieldConfig configSex = FormFieldConfig(
    labelField: 'Jenis Kelamin',
    hint: 'Pilih Jenis Kelamin',
    fieldType: ConstantsFormField.TYPE_INPUT_RADIO_GROUP,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Laki-Laki'),
      DropdownOption(id: '3', name: 'Perempuan'),
    ],
  );
  FormFieldConfig configReligion = FormFieldConfig(
    labelField: 'Agama',
    hint: 'Pilih Agama',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    dropdownOptions: [
      DropdownOption(id: '1', name: 'Islam'),
      DropdownOption(id: '2', name: 'Buddha '),
      DropdownOption(id: '2', name: 'Kristen '),
      DropdownOption(id: '2', name: 'Hindu'),
      DropdownOption(id: '2', name: 'Katolik '),
      DropdownOption(id: '2', name: 'Kong Hu Cu'),
    ],
  );
  FormFieldConfig configBirthPlace = FormFieldConfig(
    labelField: 'Tempat Lahir',
    hint: 'Input Tempat Lahir',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configDOB = FormFieldConfig(
    labelField: 'Tanggal Lahir',
    hint: 'Pilih Tanggal',

    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );

  FormFieldConfig configAccountType = FormFieldConfig(
    labelField: 'Jenis Rekening',
    hint: 'Pilih Jenis Rekening',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Rekening Terbuka'),
      DropdownOption(id: '3', name: 'Rekening Test'),
    ],
  );
  FormFieldConfig configNationality = FormFieldConfig(
    labelField: 'Kewarganegaraan',
    hint: 'Pilih Kewarganegaraan',
    fieldType: ConstantsFormField.TYPE_INPUT_RADIO_GROUP,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'Warga Negara Indonesia'),
      DropdownOption(id: '2', name: 'Warga Negara Asing'),
    ],
  );
  FormFieldConfig configIdType = FormFieldConfig(
    labelField: 'Tanda Pengenal',
    hint: 'Pilih ',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,

    dropdownOptions: [
      DropdownOption(id: '1', name: 'KTP'),
      DropdownOption(id: '2', name: 'SIM'),
      DropdownOption(id: '3', name: 'Paspor'),
      DropdownOption(id: '4', name: 'KITAS'),
    ],
  );
  FormFieldConfig configIdNumber = FormFieldConfig(
    labelField: 'Id Number',
    hint: 'Input Id Number',
    keyboardType: TextInputType.number,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
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
    fieldsToValidate.add(configBirthPlace);
    fieldsToValidate.add(configAccountType);
    fieldsToValidate.add(configNationality);
    fieldsToValidate.add(configMotherName);
    fieldsToValidate.add(configIdNumber);
    fieldsToValidate.add(configIdType);

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
              SizedBox(height: 16),
              InputFieldTextWidget(
                fieldConfig: configFirstName,
                controller: formHelper.controllers[configFirstName.labelField]!,
                errorText: formHelper.errors[configFirstName.labelField],
              ),
              InputFieldTextWidget(
                fieldConfig: configLastName,
                controller: formHelper.controllers[configLastName.labelField]!,
                errorText: formHelper.errors[configLastName.labelField],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputFieldTextWidget(
                      fieldConfig: configBirthPlace,
                      controller:
                          formHelper.controllers[configBirthPlace.labelField]!,
                      errorText: formHelper.errors[configBirthPlace.labelField],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldDatePicker(
                      fieldConfig: configDOB,
                      controller: formHelper.controllers[configDOB.labelField]!,
                      errorText: formHelper.errors[configDOB.labelField],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputFieldRadioGroup(
                      fieldConfig: configStatus,
                      errorText: formHelper.errors[configStatus.labelField],
                      onChanged: (value) {
                        setState(() {
                          formHelper.setDropdownValue(
                            configStatus.labelField,
                            value?.name,
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldRadioGroup(
                      fieldConfig: configSex,
                      errorText: formHelper.errors[configSex.labelField],
                      onChanged: (value) {
                        setState(() {
                          formHelper.setDropdownValue(
                            configSex.labelField,
                            value?.name,
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: InputFieldDropdownWidget(
                      fieldConfig: configIdType,
                      errorText: formHelper.errors[configIdType.labelField],
                      onChanged: (value) {
                        setState(() {
                          formHelper.setDropdownValue(
                            configIdType.labelField,
                            value,
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 2,
                    child: InputFieldTextWidget(
                      fieldConfig: configIdNumber,
                      controller:
                          formHelper.controllers[configIdNumber.labelField]!,
                      errorText: formHelper.errors[configIdNumber.labelField],
                    ),
                  ),
                ],
              ),

              InputFieldTextWidget(
                fieldConfig: configMotherName,
                controller:
                    formHelper.controllers[configMotherName.labelField]!,
                errorText: formHelper.errors[configMotherName.labelField],
              ),

              InputFieldDropdownWidget(
                fieldConfig: configReligion,
                errorText: formHelper.errors[configReligion.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(
                      configReligion.labelField,
                      value,
                    );
                  });
                },
              ),
              InputFieldRadioGroup(
                fieldConfig: configNationality,
                errorText: formHelper.errors[configNationality.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(
                      configNationality.labelField,
                      value?.name,
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
