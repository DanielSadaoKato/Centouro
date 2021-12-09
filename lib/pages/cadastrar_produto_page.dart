import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:centouro/models/produto.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:provider/provider.dart';

class CadastrarProdutoPage extends StatefulWidget {
  const CadastrarProdutoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarProdutoPage> createState() => _CadastrarProdutoPageState();
}

class _CadastrarProdutoPageState extends State<CadastrarProdutoPage> {
  final _form = GlobalKey<FormState>();
  final nome = TextEditingController();
  final descricao = TextEditingController();
  final codigo = TextEditingController();
  final preco = TextEditingController();
  late ProdutoListaRepository listaProdutos;
  late Produto produto;

  cadastrar(ProdutoListaRepository listaProdutos, Produto produto, String nome,
      String descricao, String codigo, double preco) {
    produto.image = 'images/tenis.png';
    produto.title = nome;
    produto.description = descricao;
    produto.id = codigo;
    produto.price = preco;
    listaProdutos.save(listaProdutos.listaP, produto);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cadastro realizado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    listaProdutos = Provider.of<ProdutoListaRepository>(context);
    Produto produto = Produto(
        image: 'images/tenis.png',
        title: 'jao',
        description: 'teste',
        id: '111',
        price: 121);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produtos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: nome,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o nome corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: descricao,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'descricao',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe a descricao corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: codigo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'codigo',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o codigo corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: preco,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'preco',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o preco corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        cadastrar(
                            listaProdutos,
                            produto,
                            nome.text,
                            descricao.text,
                            codigo.text,
                            double.parse(preco.text));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(Icons.check),
                        Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
