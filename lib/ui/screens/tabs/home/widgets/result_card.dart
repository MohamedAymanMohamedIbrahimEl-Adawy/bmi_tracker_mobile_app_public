import 'package:flutter/material.dart';

import '../../../../../data/models/bmi/bmi_model.dart';
import '../../../update_bmi/screen/update_bmi_screen.dart';

class ResultCard extends StatelessWidget {
  final BmiModel bmiModel;
  final int index;
  const ResultCard({super.key, required this.bmiModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpdateBmiScreen(
            bmiModel: bmiModel,
          ),
        ));
      },
      child: Card(
        elevation: 5,
        surfaceTintColor: const Color(0xFF1f1f2c),
        color: const Color(0xFF1f1f2c),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Age : ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text(
                              bmiModel.age.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Years',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Weight : ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text(
                              bmiModel.weight.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'KG',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Height : ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text(
                              bmiModel.height.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'M',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'BMI Status : ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
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
                                  bmiModel.bmiValue
                                      .toStringAsFixed(2)
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                bmiModel.bmiStatus,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
