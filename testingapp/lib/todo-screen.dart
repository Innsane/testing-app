import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void _addNewList() {
    print('add new list');
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return NewListBuilder();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: _addNewList),
        ],
      ),
      body: Text('Zalogowany'),
    );
  }
}

class NewListBuilder extends StatefulWidget {
  const NewListBuilder({Key key}) : super(key: key);

  @override
  _CustomListState createState() => _CustomListState();
}

class _CustomListState extends State<NewListBuilder> {
  final _wordController = TextEditingController();
  final List<String> _customWordList = [];
  final _biggerFont = TextStyle(fontSize: 18.0, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new list'),
      ),
      body: Container(
        color: Colors.grey[900],
        child: ListView.builder(
          itemCount: _customWordList.length,
          itemBuilder: (context, index) => ListTile(
            trailing: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () {
              setState(() {
                _customWordList.remove(_customWordList[index]);
              });
            },
            tileColor: Colors.grey[900],
            title: Text(
              _customWordList[index],
              style: _biggerFont,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add a custom word'),
                  content: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        TextField(
                          controller: _wordController,
                          decoration: InputDecoration(hintText: 'Type here...'),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _customWordList.add(_wordController.text);
                              });
                              Navigator.of(context).pop();
                              _wordController.clear();
                            },
                            child: Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add, color: Colors.grey[900]),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
