import 'dart:convert';

import 'package:der/controller/loginApi.controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';
import '../controller/enquetesApi.controller.dart';
import '../views.widget/drawer.wedget.dart';
import 'package:jiffy/jiffy.dart';

import 'package:http/http.dart' as http;

import 'enquetesListe.pages.dart';
import 'homeOffline.pages.dart';
import 'login.page.dart';
import 'nouvelleEnquete.pages.dart';

class Geolocalisation extends StatefulWidget {
  String selectValue;
  String secteurID;
  String dateEnquete;
  String referenceProj;
  dynamic actSemaine;
  dynamic containteValue;
  String titreProjet,
      prenomBen,
      nomBen,
      secteurLibelle,
      telBen,
      numCNIBen,
      adresseBen,
      selectedValueRgion,
      selectedValueDepart,
      selectedValueCommune,
      valOffline;
  //DetailNavire  ({Key? key}) : super(key: key);
  Geolocalisation(
      {required this.secteurID,
      required this.secteurLibelle,
      required this.dateEnquete,
      required this.referenceProj,
      required this.titreProjet,
      required this.prenomBen,
      required this.nomBen,
      required this.telBen,
      required this.numCNIBen,
      required this.adresseBen,
      required this.selectedValueRgion,
      required this.selectedValueDepart,
      required this.selectedValueCommune,
      required this.selectValue,
      required this.actSemaine,
      required this.containteValue,
      required this.valOffline});

  @override
  State<Geolocalisation> createState() => _GeolocalisationState();
}

class _GeolocalisationState extends State<Geolocalisation> {
  Position? position;
  bool? isLoaded;
  TextEditingController altitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final dataEnqueteCtl = EnquetesController();
  final dataLogin = LoginController();
  dynamic localDyna;
  List localList = [];
  //dynamic localList;
  var orderLines = <Map>[];

  getLocal() async {
    print("+++++++++++++Objet-------Geo-----------");
    //  setState(() async {
    SharedPreferences prefDataStorage = await SharedPreferences.getInstance();
    dynamic jsonData = prefDataStorage.getString('jsonLocalStorage');
  }

  Future postEnquetes(
      String reference_projet,
      String date_enquette,
      String titre_projet,
      String prenom_beneficiaire,
      String nom_beneficiaire,
      String telephone_beneficiaire,
      String cni_beneficiaire,
      String adresse_beneficiaire,
      String region,
      String libelle_secteur,
      String secteurID,
      String departement,
      String commune,
      dynamic activites,
      dynamic contraintes) async {
    dataEnqueteCtl.getStringToken().then((dynamic value) async {
      String? token = value.toString();
      print("valToken");
      // print(valToken);
      print("valToken");

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
              'reference_projet': reference_projet,
              'date_enquette': date_enquette,
              'titre_projet': titre_projet,
              'prenom_beneficiaire': prenom_beneficiaire,
              'nom_beneficiaire': nom_beneficiaire,
              'telephone_beneficiaire': telephone_beneficiaire,
              'cni_beneficiaire': cni_beneficiaire,
              'adresse_beneficiaire': adresse_beneficiaire,
              'region': region,
              'libelle_secteur': libelle_secteur,
              'id_secteur': secteurID,
              'departement': departement,
              'commune': commune,
              'activites': activites,
              'contraintes': contraintes
            }));
        print('Response status: ${response.statusCode}');
        // print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          print('Response body: 2000');
          Fluttertoast.showToast(
              msg: "Insertion Reussie",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.black,
              fontSize: 16.0);
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

  @override
  Widget build(BuildContext context) {
    print("afficher");
    print(widget.valOffline);
    print("valOffline");
    getLocal();

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            ' Géolocalisation',
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
          child: Container(

              // padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Card(
                  child: Container(
                // padding: EdgeInsets.all(10.0),
                width: 440,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.0,
                        width: 1000.0,
                        color: Colors.grey[300],
                        child: ListTile(
                          title: const InkWell(
                              child: Text("Optenir la position actuelle")),
                          // trailing: IconButton(
                          //   icon: const Icon(Icons.control_point_sharp,
                          //       color: Colors.black),
                          //   onPressed: validate,
                          // ),
                        ),
                      ),

                      if (isLoaded ?? false) const CircularProgressIndicator(),
                      Container(
                        // color: Colors.grey,
                        height: 50.0,
                        width: 1000.0,
                        child: TextFormField(
                          //enabled: false,
                          controller: altitudeController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            label: Text(" Longitude"),
                            // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                            hintText: ' Longitude".',
                            hintStyle: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),

                      Container(
                        // color: Colors.grey,
                        height: 50.0,
                        width: 1000.0,
                        child: TextFormField(
                          //enabled: false,
                          controller: longitudeController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            label: Text("  Longitude"),
                            // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                            hintText: ' Longitude".',
                            hintStyle: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),

                      const Divider(
                        height: 25,
                        color: Colors.black12,
                      ),

                      Container(
                        // color: Colors.grey,
                        height: 50.0,
                        width: 370,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {});
                            await Geolocator.requestPermission();
                            Geolocator.getCurrentPosition()
                                .then((value) => setState(() {
                                      position = value;
                                      isLoaded = false;
                                      //
                                      altitudeController.text =
                                          "${position?.latitude ?? ""}";
                                      longitudeController.text =
                                          "${position?.longitude ?? ""}";
                                    }));
                          },
                          child: Text("Actualiser la possition"),
                        ),
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.black12,
                      ),
                      // if (dataEnqueteCtl.masquerWidgetSave(widget.valOffline) )
                      Container(
                        // color: Colors.grey,
                        height: 50.0,
                        width: 370,
                        child: ElevatedButton(
                            child: Text(dataEnqueteCtl
                                .getLibelleBouton(widget.valOffline)),
                            onPressed: () async {
                              if (widget.valOffline == "false") {
                                print("+++++++++++++faux------------------");
                                print(localList);
                                print("+++++++++++++faux------------------");
                                localList.add(widget.referenceProj);
                                localList.add(widget.dateEnquete);
                                localList.add(widget.titreProjet);
                                localList.add(widget.prenomBen);
                                localList.add(widget.nomBen);
                                localList.add(widget.telBen);
                                localList.add(widget.numCNIBen);
                                localList.add(widget.adresseBen);
                                localList.add(widget.selectedValueRgion);
                                localList.add(widget.secteurLibelle);
                                localList.add(widget.secteurID);
                                localList.add(widget.selectedValueDepart);
                                localList.add(widget.selectedValueCommune);
                                localList.add(widget.actSemaine);
                                localList.add(widget.containteValue);

                                SharedPreferences prefDataStorage =
                                    await SharedPreferences.getInstance();
                                dynamic jsonData = prefDataStorage
                                    .getString('jsonLocalStorage');

                                if (jsonData == null) {
                                  List<Map<String, dynamic>> mapList = [];

                                  mapList.add({
                                    "referenceProj": localList[0],
                                    "dateEnquete": localList[1],
                                    "titreProjet": localList[2],
                                    "prenomBen": localList[3],
                                    "nomBen": localList[4],
                                    "telBen": localList[5],
                                    "numCNIBen": localList[6],
                                    "adresseBen": localList[7],
                                    "nomRegion": localList[8],
                                    "secteurLibelle": localList[9],
                                    "secteurID": localList[10],
                                    "nomDepart": localList[11],
                                    "nomCommune": localList[12],
                                    "actSemaine": localList[13],
                                    "containte": localList[14]
                                  });

                                  for (var element in mapList) {
                                    String referenceProj =
                                        element["referenceProj"];
                                    dynamic actSemaine = element["actSemaine"];
                                    print(
                                        "+++++++++++++referenceProj------------------");
                                    print(referenceProj);
                                    print(actSemaine);
                                    print(
                                        "+++++++++++++referenceProj------------------");
                                  }

                                  dynamic jsonLocalStorage =
                                      json.encode(mapList);
                                  print(
                                      "+++++++++++++jsonLocalStorage------------------");
                                  print(jsonLocalStorage);
                                  print(
                                      "+++++++++++++jsonLocalStorage------------------");

                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  await pref.setString(
                                      'jsonLocalStorage', jsonLocalStorage);
                                  Fluttertoast.showToast(
                                      msg: "Sauvegarde avec succès",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 10,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NouvelleEnquete(
                                              valOffline: "false"),
                                        ));
                                  });
                                } else {
                                  dynamic localStorage = json.decode(jsonData);

                                  List<Map<String, dynamic>> mapList = [];
                                  // for (var element in localList) {
                                  mapList.add({
                                    "referenceProj": localList[0],
                                    "dateEnquete": localList[1],
                                    "titreProjet": localList[2],
                                    "prenomBen": localList[3],
                                    "nomBen": localList[4],
                                    "telBen": localList[5],
                                    "numCNIBen": localList[6],
                                    "adresseBen": localList[7],
                                    "nomRegion": localList[8],
                                    "secteurLibelle": localList[9],
                                    "secteurID": localList[10],
                                    "nomDepart": localList[11],
                                    "nomCommune": localList[12],
                                    "actSemaine": localList[13],
                                    "containte": localList[14]
                                  });
                                  //   }

                                  for (var element in localStorage) {
                                    mapList.add({
                                      "referenceProj": element["referenceProj"],
                                      "dateEnquete": element["dateEnquete"],
                                      "titreProjet": element["titreProjet"],
                                      "prenomBen": element["prenomBen"],
                                      "nomBen": element["nomBen"],
                                      "telBen": element["telBen"],
                                      "numCNIBen": element["numCNIBen"],
                                      "adresseBen": element["adresseBen"],
                                      "nomRegion": element["nomRegion"],
                                      "secteurLibelle":
                                          element["secteurLibelle"],
                                      "secteurID": element["secteurID"],
                                      "nomDepart": element["nomDepart"],
                                      "nomCommune": element["nomCommune"],
                                      "actSemaine": element["actSemaine"],
                                      "containte": element["containte"]
                                    });
                                    print(
                                        "+++++++++++++referenceProj------------------");
                                  }

                                  print(json.encode(mapList));
                                  dynamic jsonLocalStorage =
                                      json.encode(mapList);

                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  await pref.setString(
                                      'jsonLocalStorage', jsonLocalStorage);
                                  Fluttertoast.showToast(
                                      msg: "Sauvegarde avec succès",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 10,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  setState(() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NouvelleEnquete(
                                              valOffline: "false"),
                                        ));
                                  });
                                }
                              } else if (widget.valOffline == 'true') {
                                postEnquetes(
                                        widget.referenceProj.toString(),
                                        widget.dateEnquete.toString(),
                                        widget.titreProjet.toString(),
                                        widget.prenomBen,
                                        widget.nomBen,
                                        widget.telBen,
                                        widget.numCNIBen,
                                        widget.adresseBen,
                                        widget.selectedValueRgion,
                                        widget.secteurLibelle,
                                        widget.secteurID.toString(),
                                        widget.selectedValueDepart,
                                        widget.selectedValueCommune,
                                        widget.actSemaine,
                                        widget.containteValue)
                                    .then((value) {
                                  // int reponseValue=value;
                                  print("+++++++++++++value----------");
                                  print(value);
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EnquetesListe()));
                                  });

                                  // }
                                });
                              }
                            }),
                      ),

                      const Divider(
                        height: 5,
                        color: Colors.black12,
                      ),
                      //const Divider(height: 0, color: Colors.black12,),
                    ]),
              )))),
    );
  }
}
