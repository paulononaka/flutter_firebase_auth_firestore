import 'dart:async';

import 'package:bloc/bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.loading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield* event.when(load: _load);
  }

  Stream<HomeState> _load() async* {
    yield const HomeState.loaded();
  }
}
