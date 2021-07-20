import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/models/sti_std_list.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_bloc.dart';

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
          loaded: (stiStdList) => loaded(context: context, stiStdList: stiStdList),
          error: (message) => error(context: context, errorMessage: message),
        ),
      ),
    );
  }

  Widget loading() {
    bloc.add(const OrderEvent.fetchStiStdList());
    return const Loading();
  }

  Widget loaded({required BuildContext context, required StiStdList stiStdList}) {
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const Text(
              "The next order should be made until 01-10-2020",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "Available tests",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stiStdList.stiStdList.length,
                itemBuilder: (context, index) => Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    trailing: const Icon(Icons.arrow_right),
                    title: Text(stiStdList.stiStdList[index].name),
                    subtitle: Text(stiStdList.stiStdList[index].information),
                    onTap: () => bloc.add(OrderEvent.tapOnTest(
                      navigator: Navigator.of(context),
                      stiStd: stiStdList.stiStdList[index],
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

  Widget error({required BuildContext context, required String errorMessage}) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.2),
            Text(errorMessage, style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.2, child: Images.error),
          ],
        ),
      ),
    );
  }
}
