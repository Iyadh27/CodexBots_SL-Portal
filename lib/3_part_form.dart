import 'package:flutter/material.dart';
import 'package:sl_portal/finance_visa.dart';
import 'package:sl_portal/personal_visa.dart';
import 'package:sl_portal/supporting_docs.dart';
import 'package:sl_portal/travel_visa.dart';

class MultiPartForm extends StatefulWidget {
  final VoidCallback onComplete; 

  const MultiPartForm({super.key, required this.onComplete});

  @override
  _MultiPartFormState createState() => _MultiPartFormState();
}

class _MultiPartFormState extends State<MultiPartForm> {
  int _currentStep = 0;
  bool _uploadComplete = false;
  bool _personalComplete = false;
  bool _travelComplete = false;
  bool _financeComplete = false;
  bool isMultiPartFormComplete = false; // Track if the MultiPartForm is complete

  // Callback to mark the MultiPartForm as complete
  void _onMultiPartFormComplete() {
    setState(() {
      isMultiPartFormComplete = true;
    });
    widget.onComplete();  // Notify parent that the form is complete
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          // Returning an empty container to remove default Continue/Cancel buttons
          return Container();
        },
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });

          if (_currentStep == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonalVisa(
                        onComplete: () {
                          setState(() {
                            _personalComplete = true;
                          });
                          Navigator.pop(context);
                        },
                      )),
            );
          } else if (_currentStep == 1 && _personalComplete) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TravelVisa(
                        onComplete: () {
                          setState(() {
                            _travelComplete = true;
                          });
                          Navigator.pop(context);
                        },
                      )),
            );
          } else if (_currentStep == 2 && _travelComplete) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SupportingDocs(
                        onComplete: () {
                          setState(() {
                            _uploadComplete = true;
                          });
                          Navigator.pop(context);
                        },
                      )),
            );
          } else if (_currentStep == 3 && _uploadComplete) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FinanceVisa(
                        onComplete: () {
                          setState(() {
                            _financeComplete = true;
                            // Check if all steps are complete
                            if (_personalComplete &&
                                _travelComplete &&
                                _uploadComplete &&
                                _financeComplete) {
                              _onMultiPartFormComplete(); // Mark the MultiPartForm as complete
                            }
                          });
                          Navigator.pop(context);
                        },
                      )),
            );
          }
        },
        steps: [
          Step(
            title: const Text('Personal Information'),
            isActive: _currentStep >= 0,
            state: _personalComplete ? StepState.complete : StepState.indexed,
            content: Container(),
          ),
          Step(
            title: const Text('Travel Information'),
            isActive: _currentStep >= 1,
            state: _travelComplete ? StepState.complete : StepState.indexed,
            content: Container(),
          ),
          Step(
            title: const Text('Supporting Documents'),
            isActive: _currentStep >= 2,
            state: _uploadComplete ? StepState.complete : StepState.indexed,
            content: Container(),
          ),
          Step(
            title: const Text('Finance Information'),
            isActive: _currentStep >= 3,
            state: _financeComplete ? StepState.complete : StepState.indexed,
            content: Container(),
          ),
        ],
      ),
    );
  }
}
