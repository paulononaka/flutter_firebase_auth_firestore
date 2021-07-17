import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:get_it/get_it.dart';

void setup() {
  final getIt = GetIt.instance;

  // Home
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerFactory<HomePage>(() => HomePage(bloc: GetIt.I.get<HomeBloc>()));
}
