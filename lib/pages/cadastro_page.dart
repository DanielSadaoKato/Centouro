import 'package:centouro/pages/login_page.dart';
import 'package:centouro/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:centouro/models/user.dart';
import 'package:centouro/repositories/user_repository.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  late UserRepository users;

  final _form = GlobalKey<FormState>();

  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  late User usuario;

  // registrar(UserRepository users, User usuario, String nome, String email, String senha){
  //   usuario.nome = nome;
  //   usuario.email = email;
  //   usuario.senha = senha;

  //   users.saveAll(users.dados, usuario);

  //   Navigator.pop(context);

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Usuário cadastrado com sucesso!')),
  //   );
  // }

  registrar() async {
    try {
      await context
          .read<AuthService>()
          .registrar(nome.text, email.text, senha.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
      Navigator.pop(context);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  voltarLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    users = Provider.of<UserRepository>(context);
    User usuario = User(nome: '', email: '', senha: '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cadastre sua conta',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: nome,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nome'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe seu nome!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !EmailValidator.validate(value)) {
                        return 'Informe o email corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Senha'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres!';
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
                        registrar();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () => voltarLogin(),
                    child: Text('Voltar ao login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
