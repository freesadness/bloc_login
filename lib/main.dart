import 'package:bloc/bloc.dart';
import 'package:dongey/src/blocs/authentication_bloc/bloc.dart';
import 'package:dongey/src/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'package:flutter/material.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    builder: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted());
    },
    child: App(
      userRepository: userRepository,
    ),
  ));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugPrint(error.toString());
  }
}
