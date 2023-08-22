import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/loginApi.controller.dart';
import 'login.page.dart';

class Parametrage extends StatefulWidget {
  @override
  _ParametrageState createState() => _ParametrageState();
}

class _ParametrageState extends State<Parametrage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  getNom() async {
    SharedPreferences prefsNom = await SharedPreferences.getInstance();

    nameController.text = prefsNom.getString('nomP')!;
    emailController.text = prefsNom.getString('email')!;

    return;
  }

  final dataLogin = LoginController();

  @override
  Widget build(BuildContext context) {
    getNom();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Parametrage de mode Offline ',
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
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   radius: 70,
              //
              //     child: Image.asset("images/der1.png"),
              //   //child: Image.network("https://protocoderspoint.com/wp-content/uploads/2020/10/PROTO-CODERS-POINT-LOGO-water-mark-.png"),
              // ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 30, bottom: 0),
                //padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  enabled: false,
                  controller: emailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(),
                      labelText: ' Email',
                      hintText: ' votre  Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                // padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  enabled: false,
                  controller: nameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(),
                      labelText: ' Nom & Prenom',
                      hintText: ' votre  Nom & Prenom'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(),
                      labelText: ' le mot de passe',
                      hintText: 'le mot de passe'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Svp entrez le mot de passe';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: confirmpassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'confirmer le mot de passe',
                      hintText: 'confirmer le mot de passe'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "mot de passe non valide",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.blue,
                          textColor: Colors.black,
                          fontSize: 16.0);
                      return 'mot de passe non valide';
                    }
                    print(password.text);

                    print(confirmpassword.text);

                    if (password.text != confirmpassword.text) {
                      Fluttertoast.showToast(
                          msg: "mot de passe n'est pas identique",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.blue,
                          textColor: Colors.black,
                          fontSize: 16.0);
                      return "mot de passe n'est pas identique";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      print("valider");
                      Fluttertoast.showToast(
                          msg: "valider",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.blue,
                          textColor: Colors.black,
                          fontSize: 16.0);

                      return;
                    } else {
                      print("non valider");
                      Fluttertoast.showToast(
                          msg: " non valider",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.blue,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    }
                  },
                  child: Text("Valider"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
