import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider_architecture/provider_architecture.dart';
import 'package:social_media/auth/signUpViewModel.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) =>
          Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'name'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(controller: emailController,
                            decoration: InputDecoration(labelText: 'E-mail'),),
                          SizedBox(height: 50,),
                          TextFormField(controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password'),),


                        ],
                      ),

                    ),
                    Row(children: <Widget>[RaisedButton(onPressed: () {
                      model.signUp(context, email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text);
                    }, child: Text('SignUp'),)
                    ], mainAxisAlignment: MainAxisAlignment.end,),

                    FlatButton(
                      onPressed: () {
//                    Navigator.of(context).pushReplacement(
//                        MaterialPageRoute(builder: (ctx) => LoginView()));
                      },
                      child: Text(
                        'Already have an account?.',
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
