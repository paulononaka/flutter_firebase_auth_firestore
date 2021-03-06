import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/link_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_input_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_password_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_in/sign_in_bloc.dart';

import 'sign_in_bloc.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final SignInBloc bloc;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) => state.when(
          loading: () => const Loading(),
          loaded: () => loaded(context: context),
          error: (message) => loaded(context: context, errorMessage: message),
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
              const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.35, child: Images.signin),
              RoundedInputField(hint: "Your Email", controller: emailController),
              RoundedPasswordField(controller: passwordController),
              RoundedButton(
                text: "LOGIN",
                onPressed: () => widget.bloc.add(
                  SignInEvent.tapOnSignIn(
                    navigator: Navigator.of(context),
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                ),
              ),
              if (errorMessage != null)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              LinkButton(
                text: 'Don???t have an Account ? ',
                boldText: 'Sign Up',
                onPressed: () => widget.bloc.add(
                  SignInEvent.tapOnSignUp(navigator: Navigator.of(context)),
                ),
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
