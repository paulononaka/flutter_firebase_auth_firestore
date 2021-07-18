import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/text_theme.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_bloc.dart';

import 'tests_bloc.dart';
import 'tests_state.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final TestsBloc bloc;

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<TestsBloc, TestsState>(
        builder: (context, state) => state.when(
          loading: () => const Loading(),
          loaded: () => loaded(context: context),
          error: (message) => loaded(context: context, errorMessage: message),
        ),
      ),
    );
  }

  final List dummyList = List.generate(20, (index) {
    return {
      "id": index,
      "title": "This is the title $index",
      "subtitle": "This is the subtitle $index"
    };
  });

  Widget loaded({required BuildContext context, String? errorMessage}) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const Text(
              "All ordered tests",
              style: TextStyles.headline1,
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: ListView.builder(
                itemCount: dummyList.length,
                itemBuilder: (context, index) => Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(dummyList[index]["id"].toString()),
                      backgroundColor: Colors.purple,
                    ),
                    title: Text(dummyList[index]["title"]),
                    subtitle: Text(dummyList[index]["subtitle"]),
                    trailing: const Icon(Icons.add_a_photo),
                  ),
                ),
              ),
            )
          ],
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
