import 'dart:collection';

import 'package:centouro/databases/db_firestore.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:centouro/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:centouro/models/produto.dart';

class PedidoRepository extends ChangeNotifier {
  List<Produto> _lista = [];

  late FirebaseFirestore db;
  late AuthService auth;

  PedidoRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readPedido();
  }

  _startFirestore() async {
    db = DBFirestore.get();
  }

  _readPedido() async {
    if (auth.usuario != null && _lista.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/pedido').get();

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
        .collection('usuarios/${auth.usuario!.uid}/pedido')
        .doc(produto.id)
        .delete();
    _lista.remove(produto);
    notifyListeners();
  }

  List<Produto> get lista => (_lista);

  savePedido(List<Produto> produtos, Produto produto) async {
    lista.add(produto);
    await db
        .collection('usuarios/${auth.usuario!.uid}/pedido')
        .doc(produto.id)
        .set({
      'id': produto.id,
      'produto': produto.title,
      'price': produto.price,
    });
    notifyListeners();
  }
}
