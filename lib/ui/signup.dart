// Create a Form widget.
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workspace/database/apis.dart';
import 'package:flutter_workspace/ui/login.dart';
import 'package:flutter_workspace/utility/toast_message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MySignupForm extends StatefulWidget {
  const MySignupForm({super.key});

  @override
  MySignupFormState createState() {
    return MySignupFormState();
  }
}

var errorResponse = "";

class MySignupFormState extends State<MySignupForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleFnameControlerSignUp = new TextEditingController();
  TextEditingController titleLnameControllerSignUp =
      new TextEditingController();
  TextEditingController titleEmailControllerSignUp =
      new TextEditingController();
  TextEditingController titlePwdControllerSignUp = new TextEditingController();
  TextEditingController titleCPwdControllerSignUp = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            body: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        TextFormField(
                          controller: titleFnameControlerSignUp,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Please enter first name',
                            labelText: 'First name *',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: titleLnameControllerSignUp,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Please enter last name',
                            labelText: 'Last name *',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: titleEmailControllerSignUp,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Please enter email',
                            labelText: 'Email *',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: titlePwdControllerSignUp,
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
                        TextFormField(
                          controller: titleCPwdControllerSignUp,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.key),
                            hintText: 'Please enter confirm password',
                            labelText: 'Confirm Password *',
                          ),
                          obscureText: true,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter confirm password';
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
                                }
                                register(
                                    titleEmailControllerSignUp.text.toString(),
                                    titlePwdControllerSignUp.text.toString());
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: const Text(
                                  'Sign Up',
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
                                child: Text("Already an account. Login?",
                                    style: TextStyle(fontSize: 20)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyLoginForm()),
                                  );
                                })),
                      ],
                    ),
                  )),
                ))));
  }

  void register(String email, password) async {
    try {
      Response response = await post(
          Uri.parse(ApiConnections.BASE_URl+ApiConnections.SIGNUP),
          body: {'email': email, 'password': password});
      print(response.statusCode);
      if (response.statusCode == 200) {
        ToastMessage().toastInBlack(context, "Registration successful");
      } else {
        ToastMessage().toastInRed(context, "Invalid data");
      }
      titleFnameControlerSignUp.clear();
      titleLnameControllerSignUp.clear();
      titleEmailControllerSignUp.clear();
      titlePwdControllerSignUp.clear();
      titleCPwdControllerSignUp.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
