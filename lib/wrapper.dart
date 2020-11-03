import 'package:brew/auth/sign_in.dart';
import 'package:brew/home/home.dart';
import 'package:brew/home/settings_form.dart';
import 'package:brew/loading.dart';
import 'package:brew/models/user_data.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/brew_user.dart';

class Wrapper extends StatefulWidget {
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Widget build(BuildContext context) {
    final brewUser = Provider.of<BrewUser>(context);
    if (brewUser == null)
      print('Brewuser is null');
    else
      print('User is ${brewUser.user}');
    if (brewUser == null) return Loading();
    if (brewUser.user == null) return SignIn();
    final anon = AuthService().isAnon();
    if (anon) return Home(anon: true);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: brewUser.user).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.name.isEmpty)
            return Scaffold(
              body: Settings(
                wrapper: true,
              ),
            );
          return Home();
        }
        return Loading();
      },
    );
  }
}
