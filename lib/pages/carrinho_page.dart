import 'package:centouro/pages/home_page.dart';
import 'package:centouro/pages/produtos_page.dart';
import 'package:centouro/repositories/carrinho_repository.dart';
import 'package:centouro/repositories/pedido_repository.dart';
import 'package:flutter/material.dart';
import 'package:centouro/models/produto.dart';
import 'package:centouro/pages/cadastrar_produto_page.dart';
import 'package:centouro/pages/produto_detalhes_page.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({Key? key}) : super(key: key);

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  late CarrinhoRepository listaCarrinho;
  List<Produto> listaTeste = [];
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    listaCarrinho = Provider.of<CarrinhoRepository>(context);
    //final tabela = ProdutoRepository.tabela;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de compras'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            leading: SizedBox(
              child: Image.network(listaCarrinho.lista[produto].image),
              width: 90,
              height: 90,
            ),
            title: Text(
              listaCarrinho.lista[produto].title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            subtitle: Text(real.format(listaCarrinho.lista[produto].price)),
            trailing: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Remover do carrinho'),
                    onTap: () {
                      Provider.of<CarrinhoRepository>(context, listen: false)
                          .remove(listaCarrinho.lista[produto]);
                    },
                  ),
                ),
              ],
            ),
            // IconButton(
            //   icon: const Icon(Icons.more_vert),
            //   onPressed: remover(),
            // ),
            // Text(
            //     real.format(listaCarrinho.lista[produto].preco).toString()),

            // real.format(widget.produto.preco),
          );
        },
        padding: EdgeInsets.all(20),
        separatorBuilder: (_, __) => Divider(),
        itemCount: listaCarrinho.lista.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => comprar(listaCarrinho.lista),
        icon: Icon(Icons.shopping_bag_sharp),
        label: Text(
          'COMPRAR',
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // mostrarDetalhes(Produto produto) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ProdutoDetalhesPage(produto: produto),
  //     ),
  //   );
  // }

  remover() {}

  comprar(List<Produto> lista) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Compra realizada com sucesso!")),
    );

    lista.forEach((produto) {
      Provider.of<CarrinhoRepository>(context, listen: false).remove(produto);
      Provider.of<PedidoRepository>(context, listen: false)
          .savePedido(lista, produto);
    });
  }

  cadastrarNovo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastrarProdutoPage(),
      ),
    );
  }
}
