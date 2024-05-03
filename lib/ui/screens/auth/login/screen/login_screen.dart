import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopCard(),
            SizedBox(
              height: 60,
            ),
            LoginForm()
          ],
        ),
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          'assets/images/v3.svg',
          height: 127,
        ),
      ],
    );
  }
}
