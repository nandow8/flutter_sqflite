import 'package:flutter/material.dart';
import 'package:flutter_crud/utils/connection.dart';

class ListUsers extends StatefulWidget {
  List users;

  ListUsers({ Key key, this.users }) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
   

  @override
  Widget build(BuildContext context) {

    List _users = widget.users;

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
