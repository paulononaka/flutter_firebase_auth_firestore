import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/link_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_input_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_password_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_bloc.dart';

import 'sign_up_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final SignUpBloc bloc;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) => state.when(
          loading: () => loading(context),
          loaded: () => loaded(context: context),
          error: (message) => loaded(context: context, errorMessage: message),
        ),
      ),
    );
  }

  Widget loading(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget loaded({required BuildContext context, String? errorMessage}) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("SIGNUP", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.35, child: Images.signup),
              RoundedInputField(hintText: "Your Email", controller: emailController),
              RoundedPasswordField(controller: passwordController),
              RoundedButton(
                text: "SIGNUP",
                onPressed: () => widget.bloc.add(
                  SignUpEvent.tapOnSignUp(
                    navigatorState: Navigator.of(context),
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                ),
              ),
              if (errorMessage != null)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              SizedBox(height: size.height * 0.03),
              const LinkButton(
                text: 'Don’t have an Account ? ',
                boldText: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
