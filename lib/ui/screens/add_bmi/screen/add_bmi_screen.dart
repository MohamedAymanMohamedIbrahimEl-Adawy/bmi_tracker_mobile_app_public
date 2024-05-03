import 'package:flutter/material.dart';

import '../widgets/add_form.dart';

class AddBmiScreen extends StatelessWidget {
  static const routeName = '/add-bmi-screen';
  const AddBmiScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Record',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: const SafeArea(
        child: AddForm(),
      ),
    );
  }
}
