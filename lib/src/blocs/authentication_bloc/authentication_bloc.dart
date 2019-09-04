import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';
import '../../resources/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    final bool hasToken = await userRepository.hasToken();
    if(event is AppFirstStarted){
      if (hasToken) {
        yield AuthenticationAuthenticated();
      }else{
        yield AuthenticationUninitialized();
      }
    }
    if (event is AppStarted) {
      if (hasToken) {
        yield AuthenticationAuthenticated();
      }
      else {
        yield AuthenticationInitialized();
      }
    }
    if(event is NavigateLoggedIn){
      yield  AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
