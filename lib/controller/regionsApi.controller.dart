
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';
import 'enquetesApi.controller.dart';
class RegionsApiController {
  dynamic data;
 final dataEnquete= EnquetesController();
 //List posteaquaiItem=[];
 dynamic regionItem;
  Future getRegion() async {
    dataEnquete.getStringToken().then((dynamic value) async {
      String ?token =value.toString();
      print("valToken");
      // print(valToken);
      print("valToken");

      var url = VariableClasse.hostRegion;
      print(url);
      try {
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

          dynamic  regionData = json.decode(response.body);
          print("response-----------");
          //   print( postaquaiData);
          print("response-----------");

            // if(postaquaiData!=null)
            regionItem=regionData["data"];
          SharedPreferences prefRegion = await SharedPreferences.getInstance();
          await prefRegion.setString('regionData', jsonEncode(regionItem).toString());




        } else {
          throw Exception('les données existent pas');
        }
      } catch (e) {
        return e.toString();
      }});
  }




}
