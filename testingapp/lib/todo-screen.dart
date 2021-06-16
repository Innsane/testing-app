import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var _globalShoppingLists = [];
var _globalShopingListsElements = [];
final _biggerFont = TextStyle(fontSize: 18.0, color: Colors.white);

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _wordController = TextEditingController();
  void listClicked(dynamic index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_globalShoppingLists[index]),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print('delete');
                  },
                ),
              ],
            ),
            body: Container(
              color: Colors.grey[900],
              child: ListView.builder(
                itemCount: _globalShopingListsElements[index].length,
                itemBuilder: (context, elementsIndex) => ListTile(
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    // edytuj
                  },
                  tileColor: Colors.grey[900],
                  title: Text(
                    _globalShopingListsElements[index][elementsIndex],
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
                        title: Text('Dodaj składni do kupienia'),
                        content: SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              TextField(
                                controller: _wordController,
                                decoration:
                                    InputDecoration(hintText: 'Np. Kiełbasa'),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _globalShopingListsElements[index]
                                          .add(_wordController.text);
                                    });
                                    Navigator.of(context).pop();
                                    _wordController.clear();
                                  },
                                  child: Text('Dodaj'),
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
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _wordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista zakupów'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              print('saved');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[900],
        child: ListView.builder(
          itemCount: _globalShoppingLists.length,
          itemBuilder: (context, index) => ListTile(
            trailing: Icon(
              Icons.edit,
              color: Colors.red,
            ),
            onTap: () {
              listClicked(index);
            },
            tileColor: Colors.grey[900],
            title: Text(
              _globalShoppingLists[index],
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
                  title: Text('Ustaw tytuł listy'),
                  content: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        TextField(
                          controller: _wordController,
                          decoration: InputDecoration(hintText: 'Np. Grill'),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _globalShoppingLists.add(_wordController.text);
                                _globalShopingListsElements.add([]);
                              });
                              Navigator.of(context).pop();
                              _wordController.clear();
                            },
                            child: Text('Stwórz'),
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
