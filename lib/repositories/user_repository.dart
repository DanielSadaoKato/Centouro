import 'dart:collection';
import 'dart:typed_data';

import 'package:centouro/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserRepository extends ChangeNotifier{
  static List<User> _dados = [
    User(
      nome: 'Admin',
      email: 'admin@hotmail.com',
      senha: '123456'
    ),

    User(
      nome: 'André Emanoel',
      email: 'teste@hotmail.com',
      senha: 'teste123'
    ),
  ];

  List<User> get dados => (_dados);

  saveAll(List<User> users, User user){
      _dados.add(user);
      notifyListeners();

  }
}
