import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_bloc.dart';

import 'order_bloc.dart';
import 'order_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final OrderBloc bloc;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<OrderBloc, OrderState>(
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
              const Text(
                "The next order should be made in 01-10-2020",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              const Text("Order a new test kit", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.35, child: Images.signin),
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
