import 'package:centouro/pages/home_page.dart';
import 'package:centouro/pages/produtos_page.dart';
import 'package:centouro/pages/reclamacao_page.dart';
import 'package:centouro/repositories/carrinho_repository.dart';
import 'package:centouro/repositories/pedido_repository.dart';
import 'package:flutter/material.dart';
import 'package:centouro/models/produto.dart';
import 'package:centouro/pages/cadastrar_produto_page.dart';
import 'package:centouro/pages/produto_detalhes_page.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({Key? key}) : super(key: key);

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  late PedidoRepository listaPedido;
  List<Produto> listaTeste = [];
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    listaPedido = Provider.of<PedidoRepository>(context);
    //final tabela = ProdutoRepository.tabela;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Compras'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            leading: SizedBox(
              child: Image.network(listaPedido.lista[produto].image),
              width: 90,
              height: 90,
            ),
            title: Text(
              listaPedido.lista[produto].title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            subtitle: Text(real.format(listaPedido.lista[produto].price)),
            trailing: PopupMenuButton(
              icon: Icon(Icons.warning_amber_sharp),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Enviar Reclamação'),
                    onTap: () => enviarReclamacao(listaPedido.lista[produto]),
                  ),
                ),
              ],
            ),
          );
        },
        padding: EdgeInsets.all(20),
        separatorBuilder: (_, __) => Divider(),
        itemCount: listaPedido.lista.length,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => comprar(listaPedido.lista),
      //   icon: Icon(Icons.shopping_bag_sharp),
      //   label: Text(
      //     'COMPRAR',
      //     style: TextStyle(
      //       letterSpacing: 0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
    );
  }

  remover() {}

  comprar(List<Produto> lista) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Compra realizada com sucesso!")),
    );
    lista.forEach((produto) {
      Provider.of<PedidoRepository>(context, listen: false).remove(produto);
    });
  }

  enviarReclamacao(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReclamacaoPage(produto: produto),
      ),
    );
  }
}
