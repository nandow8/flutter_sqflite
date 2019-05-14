import 'package:flutter/material.dart';
import './utils/connection.dart';

class FormEditUser extends StatefulWidget {
  Map initialData = {};
  var onChange;
  FormEditUser({Key key, this.initialData, this.onChange}):super(key: key);

  @override
  _FormEditUserState createState() => _FormEditUserState();
}

class _FormEditUserState extends State<FormEditUser> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {
    'enabled': false
  };

  @override
  Widget build(BuildContext context) {
    // print(widget.initialData);
    _formData['id'] = widget.initialData['id'];
    _formData['name'] = widget.initialData['name'];
    _formData['email'] = widget.initialData['email'];
    _formData['enabled'] = widget.initialData['enabled'];
    
    return Card(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.initialData['name'],
                decoration: InputDecoration(
                  labelText: 'Nome'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                },
                onSaved: (value) {
                  _formData['name'] = value;
                }
              ),
              TextFormField(
                initialValue: widget.initialData['email'],
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                },
                onSaved: (value) {
                  _formData['email'] = value;
                }
              ),
              Switch(
                value: _formData['enabled'] == 1 ? true : false,
                onChanged: (value) {
                  _formData['enabled'] = value;
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Cadastrar', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _updateData();
                    _formKey.currentState.reset();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateData() async {
    var data = [
      _formData['name'],
      _formData['email'],
      _formData['enabled'],
      _formData['id'],
    ];
    var database = await SqliteDB.connect();
    await database.rawUpdate(
      'UPDATE users SET name=?, email=?, enabled=? WHERE id=?',
      data
    );
    widget.onChange();
    Navigator.of(context).pop();
  }
}