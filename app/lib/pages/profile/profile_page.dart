import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/dropdown_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_input_field.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:flutter_firebase_auth_firestore/pages/profile/profile_bloc.dart';

import 'profile_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    required this.bloc,
    final Key? key,
  }) : super(key: key);

  final ProfileBloc bloc;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  DateTime dateOfBirth = DateTime.now();
  String selectedGender = '';
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => state.when(
          loading: () => loading(),
          loaded: (user) => loaded(context: context, user: user),
          error: (message) => loaded(context: context, errorMessage: message),
        ),
      ),
    );
  }

  Widget loading() {
    widget.bloc.add(ProfileEvent.fetchUser(nameController));
    return const Loading();
  }

  Widget loaded({required BuildContext context, FlutfireUser? user, String? errorMessage}) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      title: 'My profile',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.35, child: Images.profile),
              RoundedInputField(hint: "Your name", controller: nameController),
              DropdownField(
                  hint: 'Enable notifications',
                  list: _notificationsEnabled,
                  onChanged: (value) => notificationsEnabled = value != 'No'),
              RoundedButton(
                text: "Update",
                onPressed: () => widget.bloc.add(
                  ProfileEvent.tapOnUpdate(
                    navigator: Navigator.of(context),
                    name: nameController.text,
                    notificationsEnabled: notificationsEnabled,
                  ),
                ),
              ),
              if (errorMessage != null)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  List<String> get _notificationsEnabled => ['Yes', 'No'];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
