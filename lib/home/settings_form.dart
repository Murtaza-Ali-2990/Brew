import 'package:brew/loading.dart';
import 'package:brew/models/brew_user.dart';
import 'package:brew/models/user_data.dart';
import 'package:brew/services/database_service.dart';
import 'package:brew/utils/decor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  final wrapper;
  Settings({this.wrapper});
  _SettingsState createState() => _SettingsState(wrapper ?? false);
}

class _SettingsState extends State<Settings> {
  String _name, _sugar;
  int _strength;
  final wrapper;

  _SettingsState(this.wrapper);

  List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  final _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final brewUser = Provider.of<BrewUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: brewUser.user).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData data = snapshot.data;
            return Column(
              children: [
                AppBar(
                  leading: Image.asset('assets/coffee_icon.png'),
                  backgroundColor: Colors.brown,
                  title: Text(
                    'Update Brew Settings',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _name ?? data.name,
                          decoration: textInputDecor.copyWith(hintText: 'Name'),
                          validator: (value) =>
                              value.isEmpty ? 'Please enter a Name' : null,
                          onChanged: (value) => setState(() => _name = value),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: textInputDecor,
                          value: _sugar ?? data.sugar,
                          items: sugars
                              .map((e) => DropdownMenuItem(
                                    child: Text('$e sugar(s)'),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (e) => setState(() => _sugar = e),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Slider(
                          label: 'Strength',
                          value: (_strength ?? data.strength).toDouble(),
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          activeColor: Colors.brown[_strength ?? data.strength],
                          inactiveColor:
                              Colors.brown[_strength ?? data.strength],
                          onChanged: (value) =>
                              setState(() => _strength = value.round()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                            color: Colors.brown,
                            onPressed: () async {
                              if (_key.currentState.validate()) {
                                await DatabaseService(uid: brewUser.user)
                                    .updateUserData(
                                        _name ?? data.name,
                                        _sugar ?? data.sugar,
                                        _strength ?? data.strength);
                              }
                              if (!wrapper) Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Text('Update',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Loading();
        });
  }
}
