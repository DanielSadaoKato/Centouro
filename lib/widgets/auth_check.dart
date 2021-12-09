import 'package:centouro/pages/home_page.dart';
import 'package:centouro/pages/login_page.dart';
import 'package:centouro/pages/produtos_page.dart';
import 'package:centouro/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if(auth.isLoading){
      return loading();
    }else if(auth.usuario == null){
      return LoginPage();
    }else{
      return HomePage();
    }
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}