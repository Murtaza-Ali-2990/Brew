import 'package:brew/loading.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/utils/decor.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, pass;
  int error = 0;
  bool loading = false;
  final _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[200],
            appBar: AppBar(
              backgroundColor: Colors.brown,
              title: Text(
                'Brew',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    TextFormField(
                      initialValue: email,
                      validator: (value) =>
                          value.isEmpty ? 'Enter an E-mail' : null,
                      decoration: textInputDecor.copyWith(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: pass,
                      validator: (value) =>
                          value.isEmpty ? 'Enter a Password' : null,
                      decoration: textInputDecor.copyWith(hintText: 'Password'),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => pass = value);
                      },
                    ),
                    SizedBox(height: 30.0),
                    RaisedButton(
                      color: Colors.brown,
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Text('Sign In or Register',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                      onPressed: () async {
                        if (_key.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic user = await AuthService()
                              .emailPassSignIn(email: email, password: pass);
                          if (user == 'invalid-email')
                            error = 1;
                          else if (user == 'wrong-password')
                            error = 2;
                          else if (user == 'weak-password')
                            error = 3;
                          else
                            error = 0;
                          if (error != 0) setState(() => loading = false);
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      onPressed: () async {
                        await AuthService().anonymousSignIn();
                      },
                      color: Colors.brown,
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Text('Sign In as Guest',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    if (error == 1)
                      Text(
                        'E-mail is Invalid',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    if (error == 2)
                      Text(
                        'Wrong Password. Please try again.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    if (error == 3)
                      Text(
                        'Weak Password',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}
