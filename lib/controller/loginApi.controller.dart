
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';



class LoginController {




 Future sendLogin(String email, String password) async {
  //BonBloc bb= BonBloc();
  var url = VariableClasse.hostLogin;


  //String va= Constant.client_secret;
print(url);
  try {


  var response = await http.post(Uri.parse(url),

  body: <String, String>{
  // 'client_id': Constant.client_id,
  // 'grant_type': Constant.grant_type,
  // 'client_secret': Constant.client_secret,
  // 'scope': Constant.openid,
   'email': email,
   'password': password,

  });

  print('Response status: ${response.statusCode}');
  //print('Response: $response');
  //  print('Response body: ${response.body}');
  // EasyLoading.show(status: 'loading...');

  if (response.statusCode == 200) {
 dynamic datareponse = json.decode(response.body);
 //print(datareponse['user']['name']);
 //print(datareponse['user']);
dynamic token = datareponse['token'].toString();
 String nomP = datareponse['user']['name'];
 String email = datareponse['user']['email'];
 print('----------------user+++++++++++++++++');
 print("----------------name++++++++++++++");
 print(datareponse['user']['name']);
    print("----------------Controllertoken++++++++++++++");
 //print(token);
 print('Controllertoken ');
    SharedPreferences prefToken = await SharedPreferences.getInstance();
    await prefToken.setString('token', token.toString());

    SharedPreferences prefNomP = await SharedPreferences.getInstance();
      await prefNomP.setString('nomP', nomP);
 SharedPreferences prefEmail = await SharedPreferences.getInstance();
 await prefEmail.setString('email', email);

 print('eeeeeeeeeeeeeeeeeee');




  Fluttertoast.showToast(
  msg: "Connexion succès!!" ,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.CENTER,
  timeInSecForIosWeb: 5,
  backgroundColor: Colors.blue,
  textColor: Colors.black,
  fontSize: 16.0);

  return datareponse;



  } else if (response.statusCode == 500) {

    // setState(() {
    Fluttertoast.showToast(
        msg: "Service indisponible" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 16.0);
    return response.statusCode;
    // });
    //Navigator.pop(context);
    /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DetailTerrePlain(surfaceTotal: int.parse('${widget.surfaceTotal}'),
          codeTerrePlein: widget.codeTerrePlein.toString(), zoneCo: widget.zoneCode, zoneLi: widget.zoneLibelle,),) )*/;

  }else if (response.statusCode == 401){
    Fluttertoast.showToast(
        msg: "Verifier nom utilisateur/mot de passe" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 16.0);

  return throw ("Verifier nom utilisateur/mot de passe.");
  }else if (response.statusCode == 400){
    Fluttertoast.showToast(
        msg: "Erreur du Serveur " ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 16.0);

   return  throw ('Erreur du Serveur.');
   }else if(response.statusCode==422){
    Fluttertoast.showToast(
        msg: "Verifier nom utilisateur/mot de passe" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 16.0);
  }
    else{
    Fluttertoast.showToast(
        msg: "Erreur du Serveur" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 16.0);
    throw ('Erreur du Serveur.');
  }

  } catch (e) {

  // throw ("Service inaccèssible");

  //return e.toString();
    return  ("${e}Service inaccèssible" );
  }
}

// Methode qui stock le nom utilisateur
  Future getValidation ()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic loginVal= prefs.getString('email');
    print(loginVal);
  }

  // Deconnexion de l'utilisateur
  Future getDeconnecUser ()async{
    final SharedPreferences prefsDeco = await SharedPreferences.getInstance();
    prefsDeco.remove("email") ;


  }

  /*
* la methode qui traite et revoie le libelle Zone
* */
  getZone(String? zoneTerreP) {

    String ? zoneTer;
    //zoneTer==zoneTer0?"Zone nord":"Zone sude";
    if(zoneTerreP=="2012006"){
      zoneTer="Zone sud  ";
    }else{
      zoneTer="Zone nord ";

    }
    return zoneTer;
  }

  /*
* la methode qui traite et revoie le statut
* */


  //Foction qui traite affichage de couleur des icons selon leurs statuts
  Color getCouleur(String? statut){
    if(statut=="Validée"){

      return Colors.green;
    }else if(statut=="Rejetée"){
      return Colors.red;

    }else{
      // grey[300]
      return Colors.grey;

    }
  }

//methode qui trait le statut des tournée
  masquerWidgetStatut(String? statut) {
    // setState(() {
    late bool isVisible;
    // typeStatut=statut;
    if (statut == "Rejetée") {

      isVisible = true;
    } else {

      isVisible = false;
    }
    return isVisible;
    // });
  }






}
