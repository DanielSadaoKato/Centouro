import 'package:centouro/repositories/carrinho_repository.dart';
import 'package:centouro/repositories/produto_lista_repository.dart';
import 'package:centouro/repositories/user_repository.dart';
import 'package:centouro/services/auth_service.dart';
import 'package:centouro/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => UserRepository()),
      ChangeNotifierProvider(create: (context) => ProdutoListaRepository()),
      ChangeNotifierProvider(
        create: (context) => CarrinhoRepository(
          auth: context.read<AuthService>(),
        ),
      ),
    ],
    child: MeuAplicativo(),
  ));
}
