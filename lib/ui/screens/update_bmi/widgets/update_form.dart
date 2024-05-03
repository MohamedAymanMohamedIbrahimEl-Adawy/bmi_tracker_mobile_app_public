// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/bmi/bmi_model.dart';
import '../../../../providers/bmi/bmi_provider.dart';
import '../../../../services/log/app_log.dart';
import '../../auth/shared_widgets/custom_buttons.dart';
import '../../auth/shared_widgets/custom_text_fields.dart';

class UpdateForm extends StatefulWidget {
  final BmiModel? bmiModel;
  const UpdateForm({
    super.key,
    required this.bmiModel,
  });

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  late final TextEditingController weightController;

  late final TextEditingController ageController;

  late final TextEditingController heightController;

  final FocusNode ageFocus = FocusNode();
  final FocusNode weightFocus = FocusNode();
  final FocusNode heightFocus = FocusNode();

  String bmiStatus = '';
  double bmiValue = 0;

  @override
  void initState() {
    weightController =
        TextEditingController(text: widget.bmiModel?.weight.toString());
    ageController =
        TextEditingController(text: widget.bmiModel?.age.toString());
    heightController =
        TextEditingController(text: widget.bmiModel?.height.toString());
    bmiStatus = widget.bmiModel!.bmiStatus;
    bmiValue = widget.bmiModel!.bmiValue;
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    ageController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void calculate(String value) {
    AppLog.logValue('Calculating BMI');
    if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
      // int age = int.parse(ageController.text);
      bmiValue = (weight / pow(height, 2));

      calculateStatus();
    } else {
      bmiValue = 0;
      bmiStatus = 'Unknown';
    }
    AppLog.logValueAndTitle('Bmi value & status', '$bmiValue - $bmiStatus');
    setState(() {});
  }

  void calculateStatus() {
    if (0 <= bmiValue && bmiValue < 18.5) {
      bmiStatus = 'Under-weight';
    } else if (18.5 <= bmiValue && bmiValue < 25) {
      bmiStatus = 'Normal-weight';
    } else if (25 <= bmiValue && bmiValue < 30) {
      bmiStatus = 'Over-weight';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Edit Form',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Age : ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 90,
                        child: CustomTextField1(
                          controller: ageController,
                          hintText: '0',
                          maxLines: 1,
                          focusNode: ageFocus,
                          nextFocus: weightFocus,
                          fillColor: Theme.of(context).cardColor,
                          textAlign: TextAlign.center,
                          inputType: TextInputType.number,
                          // onChanged: calculate,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9]"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Years',
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                indent: 24,
                endIndent: 24,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Weight : ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 90,
                        child: CustomTextField1(
                          controller: weightController,
                          hintText: '0.00',
                          maxLines: 1,
                          focusNode: weightFocus,
                          nextFocus: heightFocus,
                          fillColor: Theme.of(context).cardColor,
                          textAlign: TextAlign.center,
                          inputType: TextInputType.number,
                          onChanged: calculate,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9.]"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'KG',
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                indent: 24,
                endIndent: 24,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Height : ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 90,
                        child: CustomTextField1(
                          controller: heightController,
                          hintText: '0.00',
                          focusNode: heightFocus,
                          fillColor: Theme.of(context).cardColor,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          inputType: TextInputType.number,
                          onChanged: calculate,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9.]"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'M',
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'BMI Status : ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 48,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            bmiValue.toStringAsFixed(2).toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          bmiStatus,
                          overflow: TextOverflow.fade,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButtonWithLoading(
              title: 'Update',
              function: () async {
                if (heightController.text.isNotEmpty &&
                    weightController.text.isNotEmpty &&
                    ageController.text.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  await Provider.of<BmiProvider>(context, listen: false)
                      .updateRecord(
                    BmiModel(
                      id: widget.bmiModel!.id,
                      weight: double.parse(weightController.text),
                      height: double.parse(heightController.text),
                      age: int.parse(ageController.text),
                      createdDate: widget.bmiModel!.createdDate,
                      bmiStatus: bmiStatus,
                      bmiValue: bmiValue,
                    ),
                  );
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
