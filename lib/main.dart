import 'package:flutter/material.dart';
import './utils/connection.dart';
import './form_user.dart';
import './list_users.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  Database _database;
  List _users = [];

  void initState() {
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    SqliteDB.connect().then((database) {
        return database.rawQuery('select * from users');
      })
      .then((data) {
        print(data);
      });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          FormUser(onSaved: () {
            getUsers();
          },),
          ListUsers(
            users: _users,
            onChange: () {
              getUsers();
            },
          ),
        ],
      ),
    );
  }

  getUsers() {
    SqliteDB.connect().then((database) {
      _database = database;
      _database.rawQuery('select * from users').then((data) {
        setState(() {
         _users = data; 
        });
      });
    });
  }
}
