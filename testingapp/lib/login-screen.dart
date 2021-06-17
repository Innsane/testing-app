import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'todo-screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(this.isRegister, {Key key}) : super(key: key);

  final bool isRegister;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.isRegister ? Register() : Login();
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var emailInput = '';
  var passwordInput = '';

  var isError = false;
  var errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F),
      appBar: AppBar(
        title: Text('Rejestracja'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.green),
              decoration: new InputDecoration(
                hintText: 'Wprowadź adres email',
                hintStyle: TextStyle(color: Colors.green),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: (String emailValue) {
                emailInput = emailValue;
                if (emailValue == null || emailValue.isEmpty) {
                  return 'Email nie może być pusty.';
                }
                return null;
              },
            ),
            new Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.green),
              decoration: new InputDecoration(
                hintText: 'Wprowadź hasło',
                hintStyle: TextStyle(color: Colors.green),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: (String passwordValue) {
                passwordInput = passwordValue;
                if (passwordValue == null || passwordValue.isEmpty) {
                  return 'Hasło nie może być puste.';
                }
                if (passwordValue.length < 6) {
                  return 'Hasło musi mieć co najmniej 6 znaków.';
                }
                return null;
              },
            ),
            new Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.green),
              decoration: new InputDecoration(
                hintText: 'Powtórz hasło',
                hintStyle: TextStyle(color: Colors.green),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: (String passwordCheckValue) {
                if (passwordCheckValue == null || passwordCheckValue.isEmpty) {
                  return 'Hasło nie może być puste.';
                }
                if (passwordCheckValue != passwordInput) {
                  return 'Podane hasła nie zgadzają się.';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailInput, password: passwordInput);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => TodoScreen()),
                          (Route<dynamic> route) => false);
                    } on FirebaseAuthException catch (e) {
                      isError = true;
                      if (e.code == 'weak-password') {
                        setState(() {
                          errorMessage = 'Wprowadzone hasło jest za słabe.';
                        });
                      } else if (e.code == 'email-already-in-use') {
                        setState(() {
                          errorMessage =
                              'Istnieje już konto dla tego adresu email.';
                        });
                      } else if (e.code == 'invalid-email') {
                        setState(() {
                          errorMessage =
                              'Format adresu email jest nieprawidłowy.';
                        });
                      } else {
                        print('Pojawił się niespodziewany błąd:');
                        setState(() {
                          errorMessage =
                              'Pojawił się niespodziewany błąd: ' + e.code;
                        });
                      }
                    } catch (e) {
                      print('Pojawił się niespodziewany błąd:');
                      setState(() {
                        errorMessage =
                            'Pojawił się niespodziewany błąd: ' + e.code;
                      });
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Column(
              children: [isError ? Text(errorMessage) : Text(' ')],
            ),
          ],
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isError = false;
  var errorMessage = '';
  var emailInput = '';
  var passwordInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F),
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.green),
              decoration: new InputDecoration(
                hintText: 'Adres email',
                hintStyle: TextStyle(color: Colors.green),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: (String email) {
                emailInput = email;
                if (email == null || email.isEmpty) {
                  return 'Email nie może być pusty.';
                }
                return null;
              },
            ),
            new Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.green),
              decoration: new InputDecoration(
                hintText: 'Hasło',
                hintStyle: TextStyle(color: Colors.green),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),

                ),
              ),
              validator: (String password) {
                passwordInput = password;
                if (password == null || password.isEmpty) {
                  return 'Hasło nie może być puste.';
                }
                if (password.length < 6) {
                  return 'Hasło musi mieć co najmniej 6 znaków.';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailInput, password: passwordInput);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => TodoScreen()),
                          (Route<dynamic> route) => false);
                    } on FirebaseAuthException catch (e) {
                      isError = true;
                      print(e.code);
                      if (e.code == 'user-not-found') {
                        setState(() {
                          errorMessage =
                              'Nie znaleziono użytkownika z tym adresem.';
                        });
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          errorMessage = 'Podane hasło jest nieprawidłowe.';
                        });
                      } else if (e.code == 'invalid-email') {
                        setState(() {
                          errorMessage =
                              'Format adresu email jest nieprawidłowy.';
                        });
                      } else {
                        setState(() {
                          errorMessage =
                              'Wystąpił nieoczekiwany błąd:' + e.code;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        isError = true;
                        errorMessage = 'Wystąpił nieoczekiwany błąd:' + e.code;
                      });
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Column(
              children: [isError ? Text(errorMessage) : Text('')],
            ),
          ],
        ),
      ),
    );
  }
}
