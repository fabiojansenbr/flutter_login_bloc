import 'package:flutter/material.dart';

import 'package:bloc_pattern/bloc_pattern.dart';

import '../../blocs/authentication_bloc.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/LoginScreen';

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget _usernameTextField(BuildContext context, AuthenticationBloc bloc) {
    return StreamBuilder(
      stream: bloc.outLogin,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: TextField(
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            focusNode: _usernameFocus,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                labelText: "Usuário",
                labelStyle: TextStyle(color: Colors.black38, fontSize: 18.0),
                errorText: snapshot.error),
            onChanged: bloc.inLogin.add,
            onSubmitted: (userInput) {
              _fieldFocusChange(context, _usernameFocus, _passwordFocus);
            },
          ),
        );
      },
    );
  }

  Widget _passwordTextField(BuildContext context, AuthenticationBloc bloc) {
    return StreamBuilder(
      stream: bloc.outPassword,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: EdgeInsets.only(top: 5, bottom: 15),
          child: TextField(
            textAlign: TextAlign.center,
            obscureText: true,
            focusNode: _passwordFocus,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.black38, fontSize: 18.0),
                errorText: snapshot.error),
            onChanged: bloc.inPassword.add,
            onSubmitted: (passwordInput) {},
          ),
        );
      },
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: FlutterLogo(),
    );
  }

  Widget _submitButton(BuildContext context, AuthenticationBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return ButtonTheme(
          padding: EdgeInsets.all(13.0),
          minWidth: double.infinity,
          buttonColor: Color(0xFF1BAA89),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          child: RaisedButton(
            textColor: Colors.white,
            child: Text("Entrar", style: TextStyle(fontSize: 16.0)),
            onPressed: (snapshot.data == null)
                ? null
                : () {
                    bloc.authenticate().then((isAuthenticated) {
                      if (isAuthenticated) {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      }

                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Container(
                                color: Colors.white,
                                child: Text("Falha no login"),
                              ));
                    });
                  },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<AuthenticationBloc>();

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            _backgroundImage(context),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 17.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Login",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700)),
                        Text("Bem vindo a Plataforma XYZ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      _usernameTextField(context, bloc),
                      _passwordTextField(context, bloc),
                    ],
                  ),
                  _submitButton(context, bloc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
