
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EnquetesController {
  late bool isVisible;
  Future getEnquetes(String token) async {
    var url = "https://msas.ip3dev.com/api-der/public/api/enquettes?page=1";
    print(url.toString()+" +++++++++++++");
    print(" +++Token+++++++++  $token");
    var response = await http.get(Uri.parse(url),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Authorization': 'Bearer $token',
    },);
    //print('Response body: ${response.body}');
    print('Response status: ${response.statusCode}');

    try{
      if (response.statusCode == 200) {

        //  print(navireData);
        //setState(() {
          dynamic data = json.decode(response.body);
         dynamic dataEnquete=data["data"]["data"];
          // if(totalItems==0){
          //    EasyLoading.showSuccess("Données n'existe pas !");
          // }else{
          //   return taxateurItem;
          // }*/
          print(data);
          return dataEnquete;


      }else if  (response.statusCode == 500) {

        // setState(() {
      //  EasyLoading.showSuccess('Service indisponible!');

        return  throw ("Service inaccèssible");

      } else   {
        throw Exception('les données existent pas');
      }
    } catch (e) {
    return  throw ("Service inaccèssible");
      //return e.toString();
    }
    //print(posteaquaiItem);
  }

  getStringToken() async {
    SharedPreferences prefsToken = await SharedPreferences.getInstance();
    //Return String

    String? tokenValue = prefsToken.getString('token');
    print("controller Enquete");
    // print(tokenValue  );
    // print("-----------------------Hommetokern+++++++++++++++++");
    return tokenValue;
  }
  masquerWidgetSave(String ? typeeplacement) {

  print("typeeplacement");
  print(typeeplacement);
  print("typeeplacement");
    if (typeeplacement == "false") {
      return isVisible = false;
    } else if (typeeplacement == "true") {
      return  isVisible = true;
    }

  }
  getLibelleBouton(String? libelle){


    if(libelle=="true"){
      libelle = "Valider";
    }else if(libelle=="false"){
      // color: Colors.lightBlue
      libelle="Sauvegarder";
    }
    return libelle;

  }



}
