import 'package:flutter/material.dart';
import 'package:research_component/constant/constants_color.dart';

import '../component/custom_toolbar.dart';
import 'form_information_screen.dart';
import 'form_screen_address.dart';

class ProgressFormPage extends StatefulWidget {
  @override
  _ProgressFormPageState createState() => _ProgressFormPageState();
}

class _ProgressFormPageState extends State<ProgressFormPage> {
  int currentStep = 0;
  final int totalSteps = 3;

  final formKeys = [
    GlobalKey<FormInformationScreenState>(),
    GlobalKey<FormScreenAddressState>(),
    GlobalKey<FormInformationScreenState>(),
  ];

  void nextStep() {
    final currentFormKey = formKeys[currentStep];
    bool isValid = false;
    if (currentFormKey is GlobalKey<FormInformationScreenState>) {
      isValid =
          (currentFormKey.currentState as FormInformationScreenState)
              .validateCurrentStep();
    } else if (currentFormKey is GlobalKey<FormScreenAddressState>) {
      isValid =
          (currentFormKey.currentState as FormScreenAddressState)
              .validateCurrentStep();
    }

    if (currentStep < totalSteps - 1 && isValid) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void submitForm() {
    // Add your submit logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolbar(
        title: 'Registrasi Pembukaan Rekening',
        isShowBackButton: false,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress Indicator
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (currentStep + 1) / totalSteps,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  ConstantsColor.PRIMARY,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Card
            Expanded(
              child: IndexedStack(
                index: currentStep,
                children: [
                  FormInformationScreen(key: formKeys[0] as GlobalKey<FormInformationScreenState>),
                  FormScreenAddress(
                    key: formKeys[1] as GlobalKey<FormScreenAddressState>,
                  ),
                  FormInformationScreen(key: formKeys[2] as GlobalKey<FormInformationScreenState>),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Button Controls
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
                        currentStep == totalSteps - 1 ? submitForm : nextStep,
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
    );
  }
}
