import 'package:flutter/material.dart';
import '../../constants/sizes.dart';
import 'form_header_widget.dart';
import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          /**SECTION-1 [IMAGE & TEXT] */
          child: Container(
            padding: const EdgeInsets.all(VADefaultSize),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FormHeader(size: size, title: "Admin Login"),
              LoginForm(),
            ]),
          ),
        ),
      ),
    );
  }
}
