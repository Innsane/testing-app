import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        title: Text('Rejestracja'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Wprowadź adres email',
              ),
              validator: (String emailValue) {
                emailInput = emailValue;
                if (emailValue == null || emailValue.isEmpty) {
                  return 'Email nie może być pusty.';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Wprowadź hasło',
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
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Powtórz hasło',
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
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailInput, password: passwordInput);
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (contex) => new TodoScreen(),
                        ),
                      );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
