import 'package:flutter/material.dart';
import 'package:research_component/constant/constants_color.dart';

import '../component/custom_toolbar.dart';
import 'form_information_screen.dart';
import 'form_screen_address.dart';

class FormRegistrationScreen extends StatefulWidget {
  @override
  _FormRegistrationScreenState createState() => _FormRegistrationScreenState();
}

class _FormRegistrationScreenState extends State<FormRegistrationScreen> {
  int currentStep = 0;
  int totalSteps = 3;
  late final List<Widget> _allForms;
  final formKeys = [
    GlobalKey<FormInformationScreenState>(),
    GlobalKey<FormScreenAddressState>(),
    GlobalKey<FormInformationScreenState>(),
    GlobalKey<FormScreenAddressState>(),
    GlobalKey<FormInformationScreenState>(),
  ];

  final stepTitles = ['Identitas','Kepemilikan','Watchlist','FATCA/CRS','Data Pendukung','BO', 'Customer Risk','Konsen & SK','Konfirmasi'];

  void nextStep() {
    final currentFormKey = formKeys[currentStep];
    bool isValid = false;
    if (currentFormKey is GlobalKey<FormInformationScreenState>) {
      FormInformationScreenState stateInformation =
          currentFormKey.currentState as FormInformationScreenState;
      isValid = stateInformation.validateCurrentStep();
    } else if (currentFormKey is GlobalKey<FormScreenAddressState>) {
      isValid =
          (currentFormKey.currentState as FormScreenAddressState)
              .validateCurrentStep();
    }

    if (currentStep < totalSteps - 1 && isValid) {
      setState(() => currentStep++);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  void goToStep(int step) {
    if(step<= currentStep){
      setState(() => currentStep = step);
    }
    // if (step >= 0 && step < totalSteps) {
    // }
  }

  void submitForm() {
    // Add your submit logic here
  }

  @override
  void initState() {
    super.initState();
    totalSteps= stepTitles.length;
    _allForms = [
      FormInformationScreen(
        key: formKeys[0] as GlobalKey<FormInformationScreenState>,
      ),
      FormScreenAddress(key: formKeys[1] as GlobalKey<FormScreenAddressState>),
      FormInformationScreen(
        key: formKeys[2] as GlobalKey<FormInformationScreenState>,
      ),
      FormScreenAddress(key: formKeys[3] as GlobalKey<FormScreenAddressState>),
      FormInformationScreen(
        key: formKeys[4] as GlobalKey<FormInformationScreenState>,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolbar(
        title: 'Registrasi Pembukaan Rekening',
        isShowBackButton: false,
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              itemCount: totalSteps,
              itemBuilder: (context, index) {
                final isSelected = index == currentStep;
                final isCompleted = index < currentStep;
                final isLast = index == totalSteps - 1;

                return InkWell(
                  onTap: () => goToStep(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon + Line Column
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: isSelected
                                  ? ConstantsColor.PRIMARY
                                  : isCompleted
                                  ? Colors.green
                                  : Colors.grey[300],
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : isCompleted
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (!isLast)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  width: 2,
                                  height: 40,
                                  color:
                                  isCompleted ? Colors.green : Colors.grey[400],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Text(
                              stepTitles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? ConstantsColor.PRIMARY
                                    : Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.black12,
          ),

          // Form Content
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Progress bar (optional)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentStep + 1) / totalSteps,
                      minHeight: 6,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ConstantsColor.PRIMARY,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Form Area
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: _allForms[currentStep],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Buttons
                  Row(
                    children: [
                      if (currentStep > 0)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: previousStep,
                            icon: Icon(
                              Icons.arrow_back,
                              color: ConstantsColor.PRIMARY,
                            ),
                            label: Text("Back"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ConstantsColor.PRIMARY,
                              side: BorderSide(color: ConstantsColor.PRIMARY),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      if (currentStep > 0) const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              currentStep == totalSteps - 1
                                  ? submitForm
                                  : nextStep,
                          icon: Icon(
                            currentStep == totalSteps - 1
                                ? Icons.check
                                : Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          label: Text(
                            currentStep == totalSteps - 1 ? "Submit" : "Next",
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ConstantsColor.PRIMARY,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
