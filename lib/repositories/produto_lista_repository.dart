import 'dart:collection';
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:centouro/models/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoListaRepository extends ChangeNotifier {
  static List<Produto> lista = [];

  List<Produto> get listaP => lista;

  save(List<Produto> produtos, Produto produto) {
    lista.add(produto);
    notifyListeners();
  }

  ProdutoListaRepository() {
    _setupProdutos();
  }

  _setupProdutos() async {
    String uri = 'https://fakestoreapi.com/products';

      final response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final List<dynamic> produtos = json;
        produtos.forEach((produto) {
          Produto data = Produto(
            id: produto['id'].toString(),
            title: produto['title'],
            image: produto['image'],
            price: double.parse(produto['price'].toString()),
            description: produto['description']
          );
          lista.add(data);
        });
        notifyListeners();
      }
  }
}
