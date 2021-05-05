import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(this.isRegister, {Key key}) : super(key: key);

  final bool isRegister;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isRegister ? Text('Rejestracja') : Text('Logowanie'),
      ),
      body: Container(
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: widget.isRegister ? Text('Rejestracja') : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
