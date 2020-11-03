import 'package:brew/models/brew_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  Widget build(BuildContext context) {
    List<BrewModel> brews = Provider.of<List<BrewModel>>(context) ?? [];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) => _listTile(context, brews[index]),
    );
  }

  Widget _listTile(BuildContext context, BrewModel brew) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 2),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(
            brew.name,
            style: TextStyle(letterSpacing: 2.0),
          ),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
