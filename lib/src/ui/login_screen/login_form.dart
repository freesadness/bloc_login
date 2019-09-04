import 'package:dongey/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:dongey/src/blocs/authentication_bloc/authentication_state.dart';
import 'package:dongey/src/blocs/login_bloc/bloc.dart';
import 'package:dongey/src/resources/user_repository.dart';
import 'package:dongey/src/ui/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (
            BuildContext context,
            LoginState state,
            ) {
          if(state is LoginInitial){
//            AuthenticationBloc(userRepository: UserRepository()).dispatch(AuthenticationAuthenticated());
////            Navigator.pop(context, MaterialPageRoute(
////                builder: (BuildContext context)=>HomePage()
////                ));
          }
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed:
                  state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
