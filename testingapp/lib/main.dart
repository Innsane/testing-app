import 'package:flutter/material.dart';

import 'login-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Testing App Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  loginPressed(isRegister) {
    print(isRegister);
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (contex) => new LoginScreen(
          isRegister,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Zaloguj się, aby rozpocząć.\nJeśli nie masz konta, użyj adresu email do rejestracji.',
            ),
            ElevatedButton(
              onPressed: () => loginPressed(false),
              child: Text('Zaloguj'),
            ),
            ElevatedButton(
              onPressed: () => loginPressed(true),
              child: Text('Rejestracja'),
            ),
          ],
        ),
      ),
    );
  }
}
