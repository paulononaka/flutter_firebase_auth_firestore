import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_input_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/text_theme.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/extensions/date_extension.dart';

import 'test_details_bloc.dart';
import 'test_details_event.dart';
import 'test_details_state.dart';

class TestDetailsPage extends StatefulWidget {
  const TestDetailsPage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final TestDetailsBloc bloc;

  @override
  State<TestDetailsPage> createState() => _TestDetailsPageState();
}

class _TestDetailsPageState extends State<TestDetailsPage> {
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as Order;
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<TestDetailsBloc, TestDetailsState>(
        builder: (context, state) => state.when(
          loading: () => const Loading(),
          loaded: () => loaded(context: context, order: order),
          error: (message) => loaded(context: context, order: order, errorMessage: message),
        ),
      ),
    );
  }

  Widget loaded({required BuildContext context, String? errorMessage, required Order order}) {
    Size size = MediaQuery.of(context).size;
    notesController.text = order.notes;
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cell('Test name', order.testName),
                          cell('Ordered At', order.createdAt.mMMMdyyyyHHmma),
                          cell('Resulted At', order.resultDate.mMMMdyyyyHHmma),
                          cell('Result', order.result),
                        ],
                      ),
                    ),
                    if (errorMessage != null)
                      Text(errorMessage, style: const TextStyle(color: Colors.red)),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                        hint: "Add notes", controller: notesController, icon: Icons.notes),
                    RoundedButton(
                      text: "Add note",
                      onPressed: () => widget.bloc.add(
                        TestDetailsEvent.updateNotes(
                          navigator: Navigator.of(context),
                          order: order,
                          notes: notesController.text,
                        ),
                      ),
                    ),
                    RoundedButton(
                      text: "Send to my email",
                      onPressed: () => widget.bloc.add(
                        TestDetailsEvent.sendEmail(
                          navigator: Navigator.of(context),
                          order: order,
                        ),
                      ),
                    ),
                    RoundedButton(
                      color: ColorPalette.dangerColor,
                      textColor: ColorPalette.primaryLightColor,
                      text: "Erase test",
                      onPressed: () => widget.bloc.add(
                        TestDetailsEvent.deleteOrder(
                          navigator: Navigator.of(context),
                          order: order,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column cell(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 30,
          thickness: 0.5,
          color: ColorPalette.primaryLightColor,
        ),
        Text(label, style: TextStyles.bodyText2),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Text(value, style: TextStyles.caption),
        )
      ],
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
