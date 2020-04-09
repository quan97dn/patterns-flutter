import 'package:flutter/material.dart';
import 'package:flutter_app_mvvm/login/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      loginViewModel.emailSink.add(emailController.text);
    });

    passwordController.addListener(() {
      loginViewModel.passwordSink.add(passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
            stream: loginViewModel.emailStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'example@gmail.com',
                  labelText: 'Email *',
                  errorText: snapshot.data,
                ),
              );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder<String>(
            stream: loginViewModel.passwordStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password *',
                  errorText: snapshot.data,
                ),
              );
            },
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 200,
            height: 45,
            child: StreamBuilder<bool>(
              stream: loginViewModel.btnStream,
              builder: (context, snapshot) {
                return RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: snapshot.data == true
                      ? () {
                          //
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
