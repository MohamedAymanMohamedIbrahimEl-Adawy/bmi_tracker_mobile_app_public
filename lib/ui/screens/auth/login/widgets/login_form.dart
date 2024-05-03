import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/models/login/login_request_model.dart';
import '../../../../../providers/auth/auth_provider.dart';
import '../../shared_widgets/custom_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userIdControllre = TextEditingController();

  final TextEditingController _passwordControllre = TextEditingController();

  final FocusNode userIdFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    var uuid = const Uuid();
    await Provider.of<AuthProvider>(context, listen: false).login(
      LoginRequestModel(
        id: uuid.v1(),
        createdDate: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _userIdControllre.dispose();
    _passwordControllre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/login.svg',
                  height: 280,
                  width: 280,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  'welcomeBack'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButtonWithLoading(
                title: 'login'.tr(),
                function: () async {
                  await login();
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
