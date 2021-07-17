import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flufire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_input_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_password_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_bloc.dart';

import '../../design_system/components/link_button.dart';
import 'sign_up_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key, required this.bloc}) : super(key: key);

  final SignUpBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) => state.when(
          loading: () => loading(context),
          loaded: () => loaded(context),
        ),
      ),
    );
  }

  Widget loading(BuildContext context) {
    bloc.add(const SignUpEvent.load());
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget loaded(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlufireScaffold(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("SIGNUP", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.35, child: Images.signup),
            RoundedInputField(hintText: "Your Email", onChanged: (value) {}),
            RoundedPasswordField(onChanged: (value) {}),
            const RoundedButton(text: "SIGNUP"),
            SizedBox(height: size.height * 0.03),
            const LinkButton(text: 'Don’t have an Account ? '),
          ],
        ),
      ),
    );
  }
}
