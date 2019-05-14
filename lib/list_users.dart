import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          return Slidable(
            delegate: SlidableBehindDelegate(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_users[index]['name']),
                subtitle: Text(_users[index]['email']),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {
                  print('editarx');
                },
              ),
              IconSlideAction(
                caption: 'Remover',
                color: Colors.red,
                icon: Icons.delete_forever,
                onTap: () {
                  print('editarx');
                },
              )
            ],
          );
        },
      ),
    );
  }
}
