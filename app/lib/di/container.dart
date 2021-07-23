import 'package:flutter_firebase_auth_firestore/firebase/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/firebase/push_notification.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:flutter_firebase_auth_firestore/network/rest_client.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_repository.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_repository.dart';
import 'package:flutter_firebase_auth_firestore/pages/test_details/test_details_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/test_details/test_details_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/test_details/test_details_repository.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_repository.dart';
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

Future<void> setup({required String baseUrl}) async {
  final getIt = GetIt.instance;

  // Setup
  final pushNotification = PushNotification();
  await pushNotification.setup();

  // Common
  getIt.registerSingleton(pushNotification);
  getIt.registerSingleton(AuthManager(pushNotification: GetIt.I.get<PushNotification>()));
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
  getIt.registerFactory<HomeRepository>(() => HomeRepository(rest: GetIt.I.get<RestClient>()));
  getIt.registerFactory<HomePage>(() => HomePage(bloc: GetIt.I.get<HomeBloc>()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(
        auth: GetIt.I.get<AuthManager>(),
        repository: GetIt.I.get<HomeRepository>(),
      ));

  // Order
  getIt.registerFactory<OrderRepository>(() => OrderRepository(rest: GetIt.I.get<RestClient>()));
  getIt.registerFactory<OrderPage>(() => OrderPage(bloc: GetIt.I.get<OrderBloc>()));
  getIt.registerFactory<OrderBloc>(() => OrderBloc(
        auth: GetIt.I.get<AuthManager>(),
        repository: GetIt.I.get<OrderRepository>(),
      ));

  // TestDetails
  getIt.registerFactory<TestDetailsRepository>(
    () => TestDetailsRepository(rest: GetIt.I.get<RestClient>()),
  );
  getIt.registerFactory<TestDetailsPage>(
    () => TestDetailsPage(bloc: GetIt.I.get<TestDetailsBloc>()),
  );
  getIt.registerFactory<TestDetailsBloc>(() => TestDetailsBloc(
        auth: GetIt.I.get<AuthManager>(),
        repository: GetIt.I.get<TestDetailsRepository>(),
      ));

  // Tests
  getIt.registerFactory<TestsRepository>(() => TestsRepository(rest: GetIt.I.get<RestClient>()));
  getIt.registerFactory<TestsPage>(() => TestsPage(bloc: GetIt.I.get<TestsBloc>()));
  getIt.registerFactory<TestsBloc>(() => TestsBloc(
        auth: GetIt.I.get<AuthManager>(),
        repository: GetIt.I.get<TestsRepository>(),
      ));

  // Profile
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(auth: GetIt.I.get<AuthManager>()));
  getIt.registerFactory<ProfilePage>(() => ProfilePage(bloc: GetIt.I.get<ProfileBloc>()));
}
