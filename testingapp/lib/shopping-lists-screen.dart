import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var _globalShoppingLists = [];
var _globalShopingListsElements = [];
final _biggerFont = TextStyle(fontSize: 18.0, color: Colors.white);

class ShoppingListsScreen extends StatefulWidget {
  const ShoppingListsScreen({Key key}) : super(key: key);

  @override
  _ShoppingListsScreen createState() => _ShoppingListsScreen();
}

class _ShoppingListsScreen extends State<ShoppingListsScreen> {
  void listClicked(dynamic index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return SingleList(index: index);
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Edytuj przedmiot'),
                          content: SizedBox(
                            height: 140,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _wordController,
                                  decoration:
                                      InputDecoration(hintText: 'Np. Grill'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _globalShoppingLists[index] =
                                            _wordController.text;
                                      });
                                    },
                                    child: Text('Akceptuj'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Anuluj'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Napewno chcesz usunąć ten przedmiot?'),
                          content: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _globalShoppingLists.removeAt(index);
                                        _globalShopingListsElements
                                            .removeAt(index);
                                      });
                                    },
                                    child: Text('Usuń'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Anuluj'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
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
            },
          );
        },
        child: Icon(Icons.add, color: Colors.grey[900]),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class SingleList extends StatefulWidget {
  final dynamic index;
  SingleList({this.index});

  @override
  _SingleList createState() => _SingleList();
}

class _SingleList extends State<SingleList> {
  final _wordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_globalShoppingLists[widget.index]),
      ),
      body: Container(
        color: Colors.grey[900],
        child: ListView.builder(
          itemCount: _globalShopingListsElements[widget.index].length,
          itemBuilder: (context, elementsIndex) => ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Edytuj przedmiot'),
                          content: SizedBox(
                            height: 140,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _wordController,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _globalShopingListsElements[
                                                widget.index][elementsIndex] =
                                            _wordController.text;
                                      });
                                    },
                                    child: Text('Akceptuj'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Anuluj'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Napewno chcesz usunąć ten przedmiot?'),
                          content: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _globalShopingListsElements[
                                                widget.index]
                                            .removeAt(elementsIndex);
                                      });
                                    },
                                    child: Text('Usuń'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Anuluj'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            onTap: () {
              // checkmark?
            },
            tileColor: Colors.grey[900],
            title: Text(
              _globalShopingListsElements[widget.index][elementsIndex],
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
                        decoration: InputDecoration(hintText: 'Np. Kiełbasa'),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                _globalShopingListsElements[widget.index]
                                    .add(_wordController.text);
                              },
                            );
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
            },
          );
        },
        child: Icon(Icons.add, color: Colors.grey[900]),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
