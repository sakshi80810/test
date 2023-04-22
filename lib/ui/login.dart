// Create a Form widget.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_workspace/database/apis.dart';
import 'package:flutter_workspace/model/login_model.dart';
import 'package:flutter_workspace/ui/signup.dart';
import 'package:flutter_workspace/utility/toast_message.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dashboard.dart';

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({super.key});

  @override
  MyLoginFormState createState() {
    return MyLoginFormState();
  }
}

class MyLoginFormState extends State<MyLoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleMailControlerLogin = new TextEditingController();
  TextEditingController titlePwdControllerLogin = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      TextFormField(
                        controller: titleMailControlerLogin,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Please enter username',
                          labelText: 'Username *',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: titlePwdControllerLogin,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.key),
                          hintText: 'Please enter password',
                          labelText: 'Password *',
                        ),
                        obscureText: true,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                ToastMessage().toastInGrey(context, "Processing data");

                                login(titleMailControlerLogin.text.toString(),
                                    titlePwdControllerLogin.text.toString());
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: GestureDetector(
                              child: Text("Create an account. Signup?",
                                  style: TextStyle(fontSize: 20)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MySignupForm()),
                                );
                              })),
                    ],
                  )),
            )));
  }

  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse(ApiConnections.BASE_URl + ApiConnections.LOGIN),
          body: {'email': email, 'password': password});
      // body: {'email': 'eve.holt@reqres.in', 'password': 'cityslicka'});
      if (response.statusCode == 200) {
        ToastMessage().toastInBlack(context, "Login successful");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const Dashboard()));
      } else {
        ToastMessage().toastInRed(context, "Invalid data");
      }
      titleMailControlerLogin.clear();
      titlePwdControllerLogin.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
