import 'package:flutter/material.dart';
import 'package:flutter_bloc/login/login_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LoginBloc(),
        child: BodyWidget(),
      ),
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

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      Provider.of(context).emailSink.add(emailController.text);
    });

    passwordController.addListener(() {
      Provider.of(context).passwordSink.add(passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
            stream: loginBloc.emailStream,
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
            stream: loginBloc.passwordStream,
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
              stream: loginBloc.btnStream,
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
