import 'dart:async';

import 'package:bloc/bloc.dart';
import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState.loading());

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    yield* event.when(load: _load);
  }

  Stream<WelcomeState> _load() async* {
    yield const WelcomeState.loaded();
  }
}
