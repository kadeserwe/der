import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.constantVariable.dart';
import '../controller/loginApi.controller.dart';
import 'home.pages.dart';
import 'homeOffline.pages.dart';
import 'nouvelleEnquete.pages.dart';

class Login extends StatelessWidget {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  getSecteur() async {
    SharedPreferences prefSceteur = await SharedPreferences.getInstance();

    dynamic dataSecteur = prefSceteur.getString('secteurData');
  }

  @override
  Widget build(BuildContext context) {
    getSecteur();
    final apiSso = LoginController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Align(
              alignment: Alignment.center,
              child: Text(
                "Bienvenue sur DER mobile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset("images/der1.png")),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: loginController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: ' Identifiant',
                    hintText: 'Enter votre  identifiant'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'mot de passe',
                    hintText: 'Enter votre mot de passe'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  print(loginController.text);
                  print(passwordController.text);
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.setString('email', loginController.text);
                  apiSso
                      .sendLogin(loginController.text, passwordController.text)
                      .then((dynamic value) {
                    dynamic reponseValue = value;

                    if (reponseValue != null) {
                      String? email = reponseValue['user']["email"];

                      if (email?.isEmpty == false) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    }

                    return const Center(child: CircularProgressIndicator());
                  });
                },
                child: const Text(
                  'Connexion',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50.0,
              width: 1000.0,
              // color: Colors.grey[300],
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ), //Offline
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NouvelleEnquete(valOffline: "false"),
                      ));
                },
                child: const Text('Passer en mode Offline'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
