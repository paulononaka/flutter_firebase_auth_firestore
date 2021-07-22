import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/date_selector.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/dropdown_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/link_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_input_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_password_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_bloc.dart';

import 'sign_up_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  DateTime dateOfBirth = DateTime.now();
  String selectedGenitalia = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
      title: 'SIGNUP',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.15, child: Images.signup),
              RoundedInputField(
                hint: "Email",
                controller: emailController,
              ),
              RoundedPasswordField(
                controller: passwordController,
              ),
              RoundedInputField(
                hint: "Name",
                controller: nameController,
              ),
              DateSelectorField(
                hint: "Date Of Birth",
                onChanged: (value) => dateOfBirth = value,
              ),
              RoundedInputField(
                hint: "Gender",
                controller: genderController,
              ),
              DropdownField(
                hint: 'Genitalia',
                list: _genitaliaList,
                onChanged: (value) => selectedGenitalia = value,
              ),
              RoundedButton(
                text: "SIGNUP",
                onPressed: () => widget.bloc.add(
                  SignUpEvent.tapOnSignUp(
                    navigator: Navigator.of(context),
                    password: passwordController.text,
                    user: FlutfireUser(
                        email: emailController.text,
                        name: nameController.text,
                        dateOfBith: dateOfBirth,
                        gender: genderController.text,
                        genitalia: selectedGenitalia),
                  ),
                ),
              ),
              if (errorMessage != null)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              LinkButton(
                text: 'Already have an Account ? ',
                boldText: 'Sign In',
                onPressed: () => widget.bloc.add(
                  SignUpEvent.tapOnSignIn(navigator: Navigator.of(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> get _genitaliaList => ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genderController.dispose();
    super.dispose();
  }
}
