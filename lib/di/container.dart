import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_page.dart';
import 'package:get_it/get_it.dart';

void setup() {
  final getIt = GetIt.instance;

  // Welcome
  getIt.registerFactory<WelcomeBloc>(() => WelcomeBloc());
  getIt.registerFactory<WelcomePage>(() => WelcomePage(bloc: GetIt.I.get<WelcomeBloc>()));

  // Home
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerFactory<HomePage>(() => HomePage(bloc: GetIt.I.get<HomeBloc>()));

  // Navigation
  getIt.registerFactory(() => const AppNavigator());
}
