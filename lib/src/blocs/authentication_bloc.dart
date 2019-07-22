import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../models/user/user.dart';
import '../models/user/authentication.dart';
import '../resources/user_api_provider.dart';
import '../resources/api_exception.dart';
import './validators.dart';

class AuthenticationBloc extends BlocBase with Validators {
  final _repository = UserApiProvider();  
  User authenticatedUser;

  final _loginController = BehaviorSubject<String>();
  Sink<String> get inLogin => _loginController.sink;
  Observable<String> get outLogin => _loginController.stream
      .debounce(Duration(milliseconds: 600))
      .transform(validateUser);

  final _passwordController = BehaviorSubject<String>();
  Sink<String> get inPassword => _passwordController.sink;
  Observable<String> get outPassword => _passwordController.stream
      .debounce(Duration(milliseconds: 600))
      .transform(validatePassword);

  Observable<bool> get submitValid =>
      Observable.combineLatest2(outLogin, outPassword, (l, p) => true);

  final _userController = BehaviorSubject<User>();
  Observable<User> get outProfessional => _userController.stream;
  User get user => _userController.value;

  Future<bool> authenticate() async {
    try {
      Authentication credentials = Authentication(
          username: _loginController.value,
          password: _passwordController.value);

      authenticatedUser = await _repository.authenticate(credentials);

      _userController.sink.add(authenticatedUser);

      return true;
    } on ApiException catch (err) {
      print(err.errorMessage());
    } on PlatformException catch (err) {
      print(err);
    } catch (err) {
      print(err);
    }

    return false;
  }

  @override
  void dispose() {
    _loginController.close();
    _passwordController.close();
    _userController.close();
    super.dispose();
  }
}
