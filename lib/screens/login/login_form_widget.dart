import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../controllers/signin_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final loginController = Get.put(SignInController());
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final _emailController = loginController.email;
    final _passwordController = loginController.password;

    return Form(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: VAFormHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  prefixIcon: Icon(LineAwesomeIcons.user),
                  labelText: VAEmail,
                  hintText: VAEmail,
                ),
              ),
              const SizedBox(
                height: VAFormHeight - 20,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  label: Text(VAPassword),
                  prefixIcon: Icon(LineAwesomeIcons.key),
                  suffix: IconButton(
                    icon: _obscureText
                        ? Icon(LineAwesomeIcons.eye)
                        : Icon(LineAwesomeIcons.eye_slash),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(LineAwesomeIcons.user),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'ARCTB',
                      child: Text(
                        'ARCTB',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'TBM',
                      child: Text(
                        'TBM',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    loginController.onLoginPressed(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                    print(_emailController.text);
                    print(_passwordController.text);
                  },
                  child: Text(
                    VALogin.toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
