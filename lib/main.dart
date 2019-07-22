import 'package:flutter/material.dart';

import 'package:bloc_pattern/bloc_pattern.dart';

import 'src/blocs/authentication_bloc.dart';

import 'src/screens/login/login_screen.dart';
import 'src/screens/home/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Bloc',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen()
        },
      ),
      blocs: [
        Bloc((i) => AuthenticationBloc()),
      ],
    );
  }
}
