import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:social_media/auth/signUpView.dart';

import 'loginViewModel.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.deepOrangeAccent,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          'ChitChat',
                          style: TextStyle(
                            color: Theme.of(context).accentTextTheme.title.color,
                            fontSize: 40,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Flexible(
                        child: Form(
                          child: Column(

                            children: [

                              TextFormField(controller: emailController,decoration: InputDecoration(labelText: 'Email'),),
                              SizedBox(height: 20,),
                              TextFormField(controller: passwordController,decoration: InputDecoration(labelText: 'Password'),obscureText: true,),
                                  SizedBox(height: 30,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  RaisedButton(onPressed: (){model.login(context, email: emailController.text, password: passwordController.text);},child: Text('Login'),),
                                ],
                              ),
                              SizedBox(height: 50,),
                              FlatButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SignUpView()));}, child: Text( 'Create an Account if you\'re new.',))
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
