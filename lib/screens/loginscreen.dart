import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/models/productdata.dart';
import 'package:shopping_app/screens/product_list.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var currentemail, currentpassword;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Icon(Icons.cancel),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40.0, left: 20.0),
                child: Center(
                  child: Text(
                    "Login for Shopping",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Image.asset('assets/login.png'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return "Enter Email";
                }
              }),
              onChanged: (value) {
                currentemail = value;
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )),
                  label: const Text("E-mail"),
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400)),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return "Enter password";
                }
              }),
              onChanged: ((value) {
                currentpassword = value;
              }),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  prefixIcon: const Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )),
                  label: const Text("Password"),
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400)),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
              height: 40.0,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProductList()));
                    // getdata(currentemail, currentpassword);
                  }
                },
                child: Text("SUBMIT"),
                style: ElevatedButton.styleFrom(
                    elevation: 10.0, primary: Colors.black),
              ))
        ]),
      ),
    )));
  }

  Future getdata(String email, String password) async {
    var client = http.Client();
    var response = await client.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        body: jsonEncode({'email': email, 'password': password}));
    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductList()));
    } else {
      print("Invalid");
      throw Exception('Failed to load data');
    }
  }
}
