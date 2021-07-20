import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:flutter_firebase_auth_firestore/network/rest_client.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_repository.dart';
import 'package:flutter_firebase_auth_firestore/pages/profile/profile_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/profile/profile_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_in/sign_in_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_in/sign_in_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_page.dart';
import 'package:get_it/get_it.dart';

void setup({required String baseUrl}) {
  final getIt = GetIt.instance;

  // Common
  getIt.registerSingleton(AuthManager());
  getIt.registerFactory(() => AppNavigator(authManager: GetIt.I.get<AuthManager>()));
  getIt.registerFactory(() => RestClient(baseUrl: baseUrl));

  // Welcome
  getIt.registerFactory<WelcomeBloc>(() => WelcomeBloc());
  getIt.registerFactory<WelcomePage>(() => WelcomePage(bloc: GetIt.I.get<WelcomeBloc>()));

  // Sign In
  getIt.registerFactory<SignInBloc>(() => SignInBloc(auth: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<SignInPage>(() => SignInPage(bloc: GetIt.I.get<SignInBloc>()));

  // Sign Up
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(auth: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<SignUpPage>(() => SignUpPage(bloc: GetIt.I.get<SignUpBloc>()));

  // Home
  getIt.registerFactory<HomeBloc>(() => HomeBloc(auth: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<HomePage>(() => HomePage(bloc: GetIt.I.get<HomeBloc>()));

  // Order
  getIt.registerFactory<OrderRepository>(() => OrderRepository(rest: GetIt.I.get<RestClient>()));
  getIt.registerFactory<OrderPage>(() => OrderPage(bloc: GetIt.I.get<OrderBloc>()));
  getIt.registerFactory<OrderBloc>(() => OrderBloc(
        auth: GetIt.I.get<AuthManager>(),
        repository: GetIt.I.get<OrderRepository>(),
      ));

  // Tests
  getIt.registerFactory<TestsBloc>(() => TestsBloc(auth: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<TestsPage>(() => TestsPage(bloc: GetIt.I.get<TestsBloc>()));

  // Profile
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(auth: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<ProfilePage>(() => ProfilePage(bloc: GetIt.I.get<ProfileBloc>()));
}
