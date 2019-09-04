import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/authentication_bloc/bloc.dart';
import 'resources/user_repository.dart';
import 'ui/home_screen/home_page.dart';
import 'ui/login_screen/login_page.dart';
import 'ui/splash_screen/splash_page.dart';
import 'ui/widgets/loading_indicator.dart';

class CustomerInfo extends Object{
  static final CustomerInfo customerInfo = CustomerInfo._internal(new FlutterSecureStorage());
  final FlutterSecureStorage storage;

  CustomerInfo._internal(this.storage);
  factory CustomerInfo(){
    return customerInfo;
  }
}


class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
         BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            } throw Exception('No Authentication state setup');
          },
        ),
    );
  }
}

