import 'dart:async';

import 'package:bloc/bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.loading());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    yield* event.when(load: _load);
  }

  Stream<SignUpState> _load() async* {
    yield const SignUpState.loaded();
  }
}
