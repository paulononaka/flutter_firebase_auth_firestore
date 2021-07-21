import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/server_error.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/text_theme.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_bloc.dart';
import 'package:flutter_firebase_auth_firestore/extensions/date_extension.dart';

import 'tests_bloc.dart';
import 'tests_event.dart';
import 'tests_state.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final TestsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<TestsBloc, TestsState>(
        builder: (context, state) => state.when(
          loading: () => loading(),
          loaded: (list) => loaded(context: context, list: list),
          error: (message) => ServerError(errorMessage: message),
        ),
      ),
    );
  }

  Widget loading() {
    bloc.add(const TestsEvent.fetchOrderList());
    return const Loading();
  }

  Widget loaded({required BuildContext context, required List<Order> list}) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            if (list.isEmpty)
              const Text("You haven't ordered any test kit yet", style: TextStyles.headline1)
            else
              const Text("All ordered tests", style: TextStyles.headline1),
            SizedBox(height: size.height * 0.03),
            if (list.isEmpty)
              SizedBox(height: size.height * 0.5, child: Images.empty)
            else
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      trailing: const Icon(Icons.arrow_right),
                      title: Text(list[index].testName),
                      subtitle: Text(list[index].createdAt.mMMMdyyyy),
                      onTap: () => bloc.add(TestsEvent.tapOnTest(
                        navigator: Navigator.of(context),
                        order: list[index],
                      )),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
