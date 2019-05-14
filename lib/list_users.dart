import 'package:flutter/material.dart';
import 'package:flutter_crud/utils/connection.dart';
import 'package:sqflite/sqflite.dart';

class ListUsers extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  Database _database;
  List _users;

  void initState() {
    SqliteDB.connect().then((database) {
      _database = database;
    });
  }

  @override
  Widget build(BuildContext context) {

    _database.rawQuery('SELECT * FROM users').then((data) {
      setState(() {
        _users = data;
      });
    });

    return Expanded(
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index]['name']),
            subtitle: Text(_users[index]['email']),
          );
        },
      ),
    );
  }
}
