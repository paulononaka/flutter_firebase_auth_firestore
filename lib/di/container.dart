import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_in/sign_in_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_in/sign_in_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_page.dart';
import 'package:get_it/get_it.dart';

void setup() {
  final getIt = GetIt.instance;

  // Common
  getIt.registerSingleton(AuthManager());
  getIt.registerFactory(() => AppNavigator(authManager: GetIt.I.get<AuthManager>()));

  // Welcome
  getIt.registerFactory<WelcomeBloc>(() => WelcomeBloc());
  getIt.registerFactory<WelcomePage>(() => WelcomePage(bloc: GetIt.I.get<WelcomeBloc>()));

  // Sign In
  getIt.registerFactory<SignInBloc>(() => SignInBloc(authManager: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<SignInPage>(() => SignInPage(bloc: GetIt.I.get<SignInBloc>()));

  // Sign Up
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(authManager: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<SignUpPage>(() => SignUpPage(bloc: GetIt.I.get<SignUpBloc>()));

  // Home
  getIt.registerFactory<HomeBloc>(() => HomeBloc(authManager: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<HomePage>(() => HomePage(bloc: GetIt.I.get<HomeBloc>()));

  // Order
  getIt.registerFactory<OrderBloc>(() => OrderBloc(authManager: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<OrderPage>(() => OrderPage(bloc: GetIt.I.get<OrderBloc>()));
}
