import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_bloc.dart';
import 'welcome_bloc.dart';
import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, required this.bloc}) : super(key: key);

  final WelcomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) => state.when(loaded: () => loaded(context)),
      ),
    );
  }

  Widget loaded(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("WELCOME TO FLUTFIRE", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.45, child: Images.welcome),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              onPressed: () => bloc.add(WelcomeEvent.tapOnSignIn(Navigator.of(context))),
            ),
            RoundedButton(
              text: "SIGN UP",
              color: ColorPalette.primaryLightColor,
              textColor: Colors.black,
              onPressed: () => bloc.add(WelcomeEvent.tapOnSignUp(Navigator.of(context))),
            ),
          ],
        ),
      ),
    );
  }
}
