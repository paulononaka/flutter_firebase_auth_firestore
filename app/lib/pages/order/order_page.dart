import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/server_error.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/text_theme.dart';
import 'package:flutter_firebase_auth_firestore/models/sti_std.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_bloc.dart';
import 'package:flutter_firebase_auth_firestore/extensions/date_extension.dart';

import 'order_bloc.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({required this.bloc, final Key? key}) : super(key: key);

  final OrderBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) => state.when(
          loading: () => loading(),
          loaded: (list) => loaded(context: context, list: list),
          error: (message) => ServerError(errorMessage: message),
        ),
      ),
    );
  }

  Widget loading() {
    bloc.add(const OrderEvent.fetchStiStdList());
    return const Loading();
  }

  Widget loaded({required BuildContext context, required List<StiStd> list}) {
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              "The next order should be made until ${DateTime.now().mMMMdyyyy}",
              style: TextStyles.bodyText1,
            ),
            const Text(
              "Available tests",
              style: TextStyles.headline2,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Card(
                  elevation: 1,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    trailing: const Icon(Icons.save),
                    title: Text(list[index].name, style: TextStyles.bodyText2),
                    subtitle: Text(list[index].information),
                    onTap: () => bloc.add(OrderEvent.tapOnTest(
                      navigator: Navigator.of(context),
                      stiStd: list[index],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
