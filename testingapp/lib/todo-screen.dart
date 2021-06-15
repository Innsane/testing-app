import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Text('Zalogowany'),
    );
  }
}
