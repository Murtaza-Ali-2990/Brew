import 'package:brew/loading.dart';
import 'package:brew/models/brew_user.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(Brew());
}

class Brew extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return MaterialApp(
            home: Scaffold(
              body: Text(snapshot.error.toString()),
            ),
          );
        else if (snapshot.connectionState == ConnectionState.done)
          return StreamProvider<BrewUser>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );

        return MaterialApp(home: Loading());
      },
    );
  }

  Future<FirebaseApp> _initialize() async {
    return await Firebase.initializeApp();
  }
}
