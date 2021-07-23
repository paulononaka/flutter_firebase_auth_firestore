import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/firebase/auth_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.auth}) : super(const ProfileState.loading());

  final AuthManager auth;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    yield* event.when(tapOnUpdate: _tapOnUpdate, fetchUser: _fetchUser);
  }

  Stream<ProfileState> _fetchUser(TextEditingController nameController) async* {
    try {
      final user = await auth.currentUser();
      nameController.text = user.name;
      yield ProfileState.loaded(user);
    } catch (e) {
      yield const ProfileState.error('An unknown Server error happened :(');
    }
  }

  Stream<ProfileState> _tapOnUpdate(
    NavigatorState navigator,
    String name,
    bool? notificationsEnabled,
  ) async* {
    try {
      yield const ProfileState.loading();
      await auth.update(name: name, notificationsEnabled: notificationsEnabled);
      Fluttertoast.showToast(
          msg: "Profile successfully updated!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
      navigator.pop();
    } on AuthException catch (e) {
      yield ProfileState.error(e.message);
    } catch (e) {
      yield const ProfileState.error('An unknown Server error happened :(');
    }
  }
}
