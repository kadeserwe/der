import 'dart:convert';

import 'package:der/controller/regionsApi.controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/secteursApi.controller.dart';
import '../controller/loginApi.controller.dart';
import '../views.widget/drawer.wedget.dart';
import 'login.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dataSecteur = SecteurApiController();
  final dataRegion = RegionsApiController();
  getSecteur() async {
    SharedPreferences prefSceteur = await SharedPreferences.getInstance();

    dynamic dataSecteur = prefSceteur.getString('secteurData');
    dynamic dataRegion = prefSceteur.getString('regionData');
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? stringValue = prefs.getString('email');
    // String? tokenValue = prefsToken.getString('token');

    return stringValue;
  }

  getStringToken() async {
    SharedPreferences prefsToken = await SharedPreferences.getInstance();

    String? tokenValue = prefsToken.getString('token');

    return tokenValue;
  }

  @override
  void initState() {
    super.initState();

    dataSecteur.getSecteur();
    dataRegion.getRegion();
    getSecteur();
  }

  @override
  Widget build(BuildContext context) {
    final dataLogin = LoginController();
    return Scaffold(
      drawer: MonMenu(),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            '              DER ',
            style: TextStyle(color: Colors.white, fontSize: 16.5),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(left: 80.0, right: 40.0),
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () async => {
                dataLogin.getDeconnecUser(),
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false)
              },
            ),
          ]),
      body: Center(
        child: Image.asset("images/der1.png"),
      ),
    );
  }
}
