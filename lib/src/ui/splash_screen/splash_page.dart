import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/authentication_bloc/bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
    BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: Text('Splash Screen')),
            FlatButton(
                onPressed: (){
                  authenticationBloc.dispatch(NavigateLoggedIn());
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (BuildContext context)=>LoginPage(userRepository: UserRepository())
//                  ));
                },
                child: Text('login'))
          ],
        ),
      ),
    );
  }
}