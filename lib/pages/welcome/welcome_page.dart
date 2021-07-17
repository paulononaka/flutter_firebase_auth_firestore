import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flufire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        builder: (context, state) => state.when(
          loading: () => loading(context),
          loaded: () => loaded(context),
        ),
      ),
    );
  }

  Widget loading(BuildContext context) {
    bloc.add(const WelcomeEvent.load());
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
            const Text(
              "WELCOME TO FLUFIRE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            const RoundedButton(
              text: "LOGIN",
            ),
            const RoundedButton(
              text: "SIGN UP",
              color: ColorPalette.primaryLightColor,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
