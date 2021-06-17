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
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error:');
          print(snapshot);
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Color(0xFF1F1F1F),
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Zaloguj się, aby rozpocząć.\nJeśli nie masz konta, skorzystaj z rejestracji.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green[300],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () => loginPressed(false),
                        child: Text('Zaloguj'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => loginPressed(true),
                      child: Text('Rejestracja'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
