import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/bmi/bmi_model.dart';
import '../../../../providers/bmi/bmi_provider.dart';
import '../widgets/update_form.dart';

class UpdateBmiScreen extends StatelessWidget {
  static const routeName = '/update-bmi-screen';
  final BmiModel? bmiModel;
  const UpdateBmiScreen({super.key, this.bmiModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Record',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<BmiProvider>(context, listen: false)
                  .deleteRecord(bmiModel!);
              Future.delayed(const Duration(seconds: 2))
                  .then((value) => Navigator.of(context).popUntil(
                        (route) => route.isFirst,
                      ));
            },
            icon: Icon(
              Icons.delete_forever,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: UpdateForm(
          bmiModel: bmiModel,
        ),
      ),
    );
  }
}
