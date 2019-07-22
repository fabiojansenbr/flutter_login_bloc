import 'dart:async';

class Validators {
  final validateUser =
      StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    (user.isNotEmpty && user.length > 3)
        ? sink.add(user)
        : sink.addError('Usuário inválido');
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    (password.isNotEmpty && password.length > 4)
        ? sink.add(password)
        : sink.addError('Senha inválida');
  });
}
