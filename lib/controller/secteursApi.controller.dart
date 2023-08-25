
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';
import 'enquetesApi.controller.dart';
class SecteurApiController {
  dynamic data;
 final dataEnquete= EnquetesController();
 //List posteaquaiItem=[];
 dynamic sectuerData;
  Future getSecteur() async {
    dataEnquete.getStringToken().then((dynamic value) async {
      String ?token =value.toString();
      print("valToken");
      // print(valToken);
      print("valToken");


      try {
        var url = VariableClasse.hostSectuer;
        print(url);
        var response = await http.get(Uri.parse(url)

          ,headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        // EasyLoading.show(status: 'loading...');
        if (response.statusCode == 200) {

          print("response-----------");

          data = json.decode(response.body);
          // SharedPreferences prefSecteur = await SharedPreferences.getInstance();
          // await prefSecteur.setString('secteurData', data);
          print("response-----------");
          //   print( postaquaiData);
          print("response-----------");
          //

            // if(postaquaiData!=null)
          //  posteaquaiItem=data["data"];

            print("postaquaiData-----------");
          //  print( posteaquaiItem);
            print("postaquaiData-----------");
            sectuerData=data["data"];

            SharedPreferences prefSecteur = await SharedPreferences.getInstance();
            await prefSecteur.setString('secteurData', jsonEncode(sectuerData).toString());




        } else {
          throw Exception('les données existent pas');
        }
      } catch (e) {
       // return e.toString();
      }});
  }




}
