import 'package:flutter/material.dart';
import 'package:centouro/models/produto.dart';
import 'package:centouro/pages/cadastrar_produto_page.dart';
import 'package:centouro/pages/produto_detalhes_page.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({Key? key}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  late ProdutoListaRepository listaProdutos;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    listaProdutos = Provider.of<ProdutoListaRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            leading: SizedBox(
              child: Image.network(listaProdutos.listaP[produto].image),
              width: 90,
              height: 90,
            ),
            title: Text(
              listaProdutos.listaP[produto].title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            trailing: Text(
                real.format(listaProdutos.listaP[produto].price).toString()),
            // real.format(widget.produto.preco),
            onTap: () => mostrarDetalhes(listaProdutos.listaP[produto]),
          );
        },
        padding: EdgeInsets.all(20),
        separatorBuilder: (_, __) => Divider(),
        itemCount: listaProdutos.listaP.length,
      ),
    );
  }

  mostrarDetalhes(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdutoDetalhesPage(produto: produto),
      ),
    );
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
