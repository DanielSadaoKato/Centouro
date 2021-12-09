import 'dart:collection';

import 'package:centouro/databases/db_firestore.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:centouro/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:centouro/models/produto.dart';

class CarrinhoRepository extends ChangeNotifier {
  List<Produto> _lista = [];

  late FirebaseFirestore db;
  late AuthService auth;

  CarrinhoRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readCarrinho();
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  _readCarrinho() async {
    if (auth.usuario != null && _lista.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/carrinho').get();

      snapshot.docs.forEach((doc) {
        Produto prod = ProdutoListaRepository.lista
            .firstWhere((produto) => produto.title == doc.get('produto'));
        _lista.add(prod);
        notifyListeners();
      });
    }
  }

  remove(Produto produto) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/carrinho')
        .doc(produto.id)
        .delete();
    _lista.remove(produto);
    notifyListeners();
  }

  List<Produto> get lista => (_lista);

  saveCarrinho(List<Produto> produtos, Produto produto) async {
    lista.add(produto);
    await db
        .collection('usuarios/${auth.usuario!.uid}/carrinho')
        .doc(produto.id)
        .set({
      'id': produto.id,
      'produto': produto.title,
      'price': produto.price,
    });
    notifyListeners();
  }
}
