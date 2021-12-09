import 'package:centouro/pages/home_page.dart';
import 'package:centouro/repositories/carrinho_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:centouro/models/produto.dart';
import 'package:provider/provider.dart';

class ProdutoDetalhesPage extends StatefulWidget {
  Produto produto;

  ProdutoDetalhesPage({Key? key, required this.produto}) : super(key: key);

  @override
  _ProdutoDetalhesPageState createState() => _ProdutoDetalhesPageState();
}

class _ProdutoDetalhesPageState extends State<ProdutoDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late CarrinhoRepository listaCarrinho;

  comprar() {
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Compra realizada com sucesso!')),
    );
  }

  addCarrinho(CarrinhoRepository listaProdutos, Produto produto) {
    listaProdutos.saveCarrinho(listaProdutos.lista, produto);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Produto adicionado ao carrinho")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    listaCarrinho = Provider.of<CarrinhoRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.produto.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(widget.produto.image),
                    height: 300.0,
                    width: 300.0,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    real.format(widget.produto.price),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.red[300],
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  widget.produto.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    //backgroundColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   margin: EdgeInsets.only(top: 12),
            //   child: ElevatedButton(
            //     onPressed: comprar,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text('COMPRAR'),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: () {
                  addCarrinho(
                    listaCarrinho,
                    widget.produto,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_sharp),
                    Text(' ADICIONAR NO CARRINHO'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
