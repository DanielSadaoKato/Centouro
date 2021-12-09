import 'package:centouro/pages/cadastrar_produto_page.dart';
import 'package:centouro/pages/camera_page.dart';
import 'package:centouro/pages/home_page.dart';
import 'package:centouro/repositories/carrinho_repository.dart';
import 'package:centouro/repositories/pedido_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:centouro/models/produto.dart';
import 'package:provider/provider.dart';

class ReclamacaoPage extends StatefulWidget {
  Produto produto;

  ReclamacaoPage({Key? key, required this.produto}) : super(key: key);

  @override
  _ReclamacaoPageState createState() => _ReclamacaoPageState();
}

class _ReclamacaoPageState extends State<ReclamacaoPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late PedidoRepository listaCarrinho;

  addCarrinho(PedidoRepository listaProdutos, Produto produto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Produto adicionado ao carrinho")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    listaCarrinho = Provider.of<PedidoRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.produto.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(widget.produto.image),
                    height: 80.0,
                    width: 80.0,
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
                      fontSize: 15,
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
                    fontSize: 12,
                    color: Colors.grey[600],
                    //backgroundColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: TextFormField(
                // controller: descricao,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descreva o seu problema com o produto',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a descricao corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Enviar foto do Produto'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CameraPage(),
                  fullscreenDialog: true,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: OutlinedButton(
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Enviar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
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
