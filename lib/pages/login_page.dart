import 'package:centouro/models/user.dart';
import 'package:centouro/pages/produtos_page.dart';
import 'package:centouro/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:centouro/models/user.dart';
import 'package:centouro/pages/cadastro_page.dart';
import 'package:centouro/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserRepository users;

  final _form = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;

  // login(UserRepository lista, String email, String senha){
  //   lista.dados.forEach((user) {
  //     if(user.email == email && user.senha == senha){
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => ProdutoPage(),
  //         ),
  //       );
  //     }
  //   });
  // }
  
  login() async {
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroPage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    users = Provider.of<UserRepository>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100), 
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem vindo!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty || !EmailValidator.validate(value)){
                        return 'Informe o email corretamente!';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Informe sua senha!';
                      }else if(value.length < 6){
                        return 'Sua senha deve ter no mínimo 6 caracteres!';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if(_form.currentState!.validate()){
                        // login(users, email.text, senha.text);
                        login();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => registrar(), 
                  child: Text('Ainda não tem conta? Cadastra-se agora!')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
