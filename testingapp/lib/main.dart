import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login-screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Error:');
          print(snapshot);
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
