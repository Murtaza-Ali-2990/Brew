import 'package:brew/home/settings_form.dart';
import 'package:brew/models/brew_model.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatefulWidget {
  final anon;
  Home({this.anon});
  _HomeState createState() => _HomeState(anon ?? false);
}

class _HomeState extends State<Home> {
  final anon;
  _HomeState(this.anon);

  Widget build(BuildContext context) {
    _settingsSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Settings();
          });
    }

    return StreamProvider<List<BrewModel>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(
            'Brew',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          actions: [
            RaisedButton.icon(
                color: Colors.brown,
                onPressed: () async {
                  await AuthService().signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Sign out')),
            if (!anon)
              RaisedButton.icon(
                  color: Colors.brown,
                  onPressed: _settingsSheet,
                  icon: Icon(Icons.settings),
                  label: Text('Settings'))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
