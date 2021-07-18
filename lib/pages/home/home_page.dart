import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.bloc}) : super(key: key);

  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => state.when(
          loading: () => const Loading(),
          loaded: () => loaded(context),
        ),
      ),
    );
  }

  Widget loaded(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      title: 'Flut Fire',
      logoutOnPressed: () => bloc.add(const HomeEvent.logout()),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Order a new test kit",
              onPressed: () => bloc.add(
                HomeEvent.tapOnOrder(navigatorState: Navigator.of(context)),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            const Text("There is no recent orders", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.2, child: Images.empty),
            SizedBox(height: size.height * 0.03),
            const Text("You are healthy!", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.2, child: Images.healthy),
          ],
        ),
      ),
    );
  }
}
