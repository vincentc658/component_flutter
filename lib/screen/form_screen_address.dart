import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_component/component/custom_toolbar.dart';
import 'package:research_component/component/formField/input_field_dropdown_widget.dart';
import 'package:research_component/constant/constants_form_field.dart';
import '../component/formField/dropdown_option.dart';
import '../component/formField/form_field_config.dart';
import '../component/formField/form_helper.dart';
import '../component/formField/input_field_search_dropdown.dart';
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
  FormFieldConfig configAddress = FormFieldConfig(
    labelField: 'Alamat Lengkap',
    hint: 'Input Alamat Lengkap',

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

    isShowLabel: false,
    hint: 'Input Kecamatan',
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
  );
  FormFieldConfig configProvince = FormFieldConfig(
    labelField: 'Provinsi',
    helper: 'Provinsi',
    isShowLabel: false,
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
  FormFieldConfig configStatusResidence = FormFieldConfig(
    labelField: 'Status Tempat Tinggal',
    hint: 'Pilih Status Tempat Tinggal',
    fieldType: ConstantsFormField.TYPE_INPUT_RADIO_GROUP,
    dropdownOptions: [
      DropdownOption(id: '1', name: 'Milik Sendiri'),
      DropdownOption(id: '2', name: 'Milik Keluarga'),
      DropdownOption(id: '3', name: 'Rumah Dinas'),
      DropdownOption(id: '4', name: 'Milik Sendiri Dijaminkan '),
      DropdownOption(id: '5', name: 'Sewa/Kontrak'),
    ],
  );
  FormFieldConfig configCountryCode = FormFieldConfig(
    labelField: 'Kode Negara',
    hint: 'Pilih ',
    fieldType: ConstantsFormField.TYPE_INPUT_DROPDOWN,
    dropdownOptions: [
      DropdownOption(id: '1', name: ' +62 - Indonesia'),
      DropdownOption(id: '1', name: ' +65 - India'),
      DropdownOption(id: '1', name: ' +62 - Indonesia'),
      DropdownOption(id: '1', name: ' +1 - America'),
    ],
  );
  FormFieldConfig configPhoneNumber = FormFieldConfig(
    labelField: 'Nomor Telfon',
    hint: 'Input Nomor Telfon',
    keyboardType : TextInputType.number,
    fieldType: ConstantsFormField.TYPE_INPUT_TEXT,
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
    fieldsToValidate.add(configAddress);
    fieldsToValidate.add(configSubdistrict);
    fieldsToValidate.add(configPostalCode);
    fieldsToValidate.add(configProvince);
    fieldsToValidate.add(configCountryCode);
    fieldsToValidate.add(configPhoneNumber);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                "Alamat",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: ConstantsColor.PRIMARY,
                ),
              ),
              SizedBox(height: 16),
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
                fieldConfig: configStatusResidence,
                errorText: formHelper.errors[configStatusResidence.labelField],
                onChanged: (value) {
                  setState(() {
                    formHelper.setDropdownValue(
                      configStatusResidence.labelField,
                      value?.name,
                    );
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InputFieldDropdownWidget(
                      fieldConfig: configCountryCode,
                      errorText: formHelper.errors[configCountryCode.labelField],
                      onChanged: (value) {
                        setState(() {
                          formHelper.setDropdownValue(
                            configCountryCode.labelField,
                            value?.name,
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: InputFieldTextWidget(
                      fieldConfig: configPhoneNumber,
                      controller: formHelper.controllers[configPhoneNumber.labelField]!,
                      errorText: formHelper.errors[configPhoneNumber.labelField],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
