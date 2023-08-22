import 'dart:convert';

import 'package:der/controller/secteursApi.controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';
import '../controller/enquetesApi.controller.dart';
import '../controller/loginApi.controller.dart';
import '../views.widget/drawer.wedget.dart';
import 'detailOffline.pages.dart';
import 'enquetesListe.pages.dart';
import 'home.pages.dart';
import 'login.page.dart';
import 'package:http/http.dart' as http;

class Offline extends StatefulWidget {
  const Offline({super.key});

  @override
  State<Offline> createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  dynamic dataDataStorage;
  final dataSecteur = SecteurApiController();
  String? refLibelle;
  dynamic dodDecJson;
  dynamic dataJson0;
  dynamic dataJson1;
  dynamic dataJson2;
  dynamic dataJson3;
  dynamic dodJson;
  String? stringJson;
  final dataTokenCtrl = EnquetesController();
  int f = 1;
  dynamic dataOff;

  Future postEnquetes(dynamic dataOffline) async {
    dataTokenCtrl.getStringToken().then((dynamic value) async {
      String? token = value.toString();

      var url = VariableClasse.hostPostEnquete;
      print(url);
      try {
        var response = await http.post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              'reference_projet': dataOffline["referenceProj"],
              'date_enquette': dataOffline["dateEnquete"],
              'titre_projet': dataOffline["titreProjet"],
              'prenom_beneficiaire': dataOffline["prenomBen"],
              'nom_beneficiaire': dataOffline["nomBen"],
              'telephone_beneficiaire': dataOffline["telBen"],
              'cni_beneficiaire': dataOffline["numCNIBen"],
              'adresse_beneficiaire': dataOffline["adresseBen"],
              'region': dataOffline["nomRegion"],
              'libelle_secteur': dataOffline["secteurLibelle"],
              'id_secteur': dataOffline["secteurID"],
              'departement': dataOffline["nomDepart"],
              'commune': dataOffline["nomCommune"],
              'activites': dataOffline["actSemaine"],
              'contraintes': dataOffline["containte"]
            }));
        print('Response status: ${response.statusCode}');
        // print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          print('Response body: 2000');

          int statusCodeRep = response.statusCode;
          return statusCodeRep;
        } else {
          print('Response erreur');
          return response.statusCode;
        }
      } catch (e) {
        return e.toString();
      }
    });
  }

  getSecteur() async {
    SharedPreferences prefDataStorage = await SharedPreferences.getInstance();

    setState(() {
      dynamic jsonData = prefDataStorage.getString('jsonLocalStorage');

      if (jsonData != null) {
        dataDataStorage = json.decode(jsonData);
        dynamic dataStorage = json.encode(jsonData);
        if (dataDataStorage[0] == null) {
          print("null");
          print("-------------json.decode");
          print(dataDataStorage.length);
          print("-------------json.jsonEncode");

          print(dataStorage);
        } else if (dataDataStorage[0] != null) {
          print("-------------json.decode");
          print(dataStorage);
        }
      }
      if (jsonData == null) {
        print("---0000000000000000000-refLibelle");
        Fluttertoast.showToast(
            msg: "pas des enquetes disponible!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      dataSecteur.getSecteur();

      getSecteur();
    });

    // String  tokenVal=getStringToken();
  }

  @override
  Widget build(BuildContext context) {
    final dataLogin = LoginController();
    return Scaffold(
      // drawer: MonMenu(),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));

              // });
            },
          ),
          title: Text(
            '  Mode Offline',
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
      body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
                height: 2,
                color: Colors.black12,
              ),
          itemCount: (dataDataStorage == null) ? 0 : dataDataStorage.length,
          itemBuilder: (context, index) {
            // DateTime inputDate;
            return ListTile(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailOffline(
                              dataOffline: dataDataStorage[index])));
                });
              },
              title: InkWell(
                child: Text(
                    "${dataDataStorage[index]['referenceProj']}  ${dataDataStorage[index]['prenomBen']}"),
              ),
              subtitle: Text(
                  "${dataDataStorage[index]['titreProjet']}  ${dataDataStorage[index]['secteurLibelle']}"),
              // leading: const Icon(Icons.apps, color: Colors.lightBlue, size: 30,),

              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: <Widget>[
                    Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(
                        "${dataDataStorage[index]['dateEnquete']}"))),
                    const Icon(Icons.arrow_right,
                        color: Colors.lightBlueAccent),
                  ],
                ),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Offline(),) );

          if (dataDataStorage != null) {
            for (dataOff in dataDataStorage) {
              postEnquetes(dataOff);
            }

            Fluttertoast.showToast(
                msg: "  Synchroniser : ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.redAccent,
                textColor: Colors.black,
                fontSize: 16.0);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
            SharedPreferences prefDataStorage =
                await SharedPreferences.getInstance();

            prefDataStorage.remove("jsonLocalStorage");
          } else {
            Fluttertoast.showToast(
                msg: "  pas des enquetes disponible : ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.redAccent,
                textColor: Colors.black,
                fontSize: 16.0);
          }
        },

        label: const Text('Synchroniser '),
        // icon: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
