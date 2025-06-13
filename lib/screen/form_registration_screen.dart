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
  final int totalSteps = 3;
  late final List<Widget> _allForms;

  final formKeys = [
    GlobalKey<FormInformationScreenState>(),
    GlobalKey<FormScreenAddressState>(),
    GlobalKey<FormInformationScreenState>(),
  ];

  void nextStep() {
    final currentFormKey = formKeys[currentStep];
    bool isValid = false;
    if (currentFormKey is GlobalKey<FormInformationScreenState>) {
      FormInformationScreenState stateInformation= (currentFormKey.currentState as FormInformationScreenState);
      isValid = stateInformation.validateCurrentStep();
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
  void initState() {
    super.initState();
    _allForms = [
      FormInformationScreen(key: formKeys[0] as GlobalKey<FormInformationScreenState>),
      FormScreenAddress(key: formKeys[1] as GlobalKey<FormScreenAddressState>),
      FormInformationScreen(key: formKeys[2] as GlobalKey<FormInformationScreenState>),
    ];
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
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: (currentStep + 1) / totalSteps,
                ),
                duration: Duration(milliseconds: 400),
                builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ConstantsColor.PRIMARY,
                      ),
                    ),
                  );
                },
              ),

            ),
            const SizedBox(height: 8),

            // Form Card
            Expanded(
              child: Stack(
                children: List.generate(totalSteps, (index) {
                  final isActive = index == currentStep;
                  return AnimatedSlide(
                    duration: Duration(milliseconds: 400),
                    offset: isActive ? Offset.zero : Offset(index < currentStep ? -1 : 1, 0),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 400),
                      opacity: isActive ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !isActive,
                        child: _allForms[index],
                      ),
                    ),
                  );
                }),
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
