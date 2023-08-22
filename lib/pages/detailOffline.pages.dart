import 'dart:convert';

import 'package:der/controller/enquetesApi.controller.dart';
import 'package:der/pages/enquetesListe.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';
import 'choisirSection.pages.dart';
import 'home.pages.dart';
import 'homeOffline.pages.dart';
import 'nouvelleEnquete.pages.dart';
import 'package:http/http.dart' as http;

class DetailOffline extends StatefulWidget {
  String? valToken;
  dynamic dataOffline;

  DetailOffline({this.dataOffline, this.valToken});

  @override
  State<DetailOffline> createState() => _DetailOfflineState();
}

class _DetailOfflineState extends State<DetailOffline> {
  final dataTokenCtrl = EnquetesController();

  List itemData = [];

  DateTime dateTime = DateTime.now();
  final dataEnqueteCtl = EnquetesController();

  Future supprimerEnquete(String idEnquete) async {
    dataTokenCtrl.getStringToken().then((dynamic value) async {
      String? token = value.toString();

      var url = VariableClasse.hostSupprimerEnquete + idEnquete;
      print(url);

      try {
        var response =
            await http.delete(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        print('Response status: ${response.statusCode}');
        //  print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          int statusCodeRe = response.statusCode;

          // setState(() {
          Fluttertoast.showToast(
              msg: "Suppression Reussie",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.black,
              fontSize: 16.0);
          return statusCodeRe;
        }
        if (response.statusCode == 500) {
          // setState(() {

          return throw ("Service inaccèssible");
        } else {
          Fluttertoast.showToast(
              msg: "Erreur de suppression !!!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.red,
              textColor: Colors.red,
              fontSize: 16.0);
          return throw Exception('Erreur de suppression.');
        }
      } catch (e) {
        return e.toString();
      }
    });
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

      var url = VariableClasse.hostPostEnquete;
      print(url);
      print("titre  $titre_projet"
          "nomB  = $nom_beneficiaire"
          "prenom_beneficiaire  = $prenom_beneficiaire"
          "id_secteur: $secteurID"
          "libelle_secteur: $libelle_secteur"
          "activites: $activites"
          "contraintes: $contraintes"
          "date_enquette = $date_enquette");
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
        print('Response body: ${response.body}');
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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Offline(),
                  ));
            },
          ),
          title: Text(
            'Detail enquete offLine ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // body: SingleChildScrollView(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      Row(children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Ref proje")),
                                      trailing: Text(
                                          widget.dataOffline['referenceProj'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title:
                                          InkWell(child: Text("Date Enquete")),
                                      trailing: Text(
                                          DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(widget.dataOffline[
                                                      'dateEnquete'] ??
                                                  "--")),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(
                                          child: Text("Titre de Projet")),
                                      trailing: Text(
                                          widget.dataOffline['titreProjet'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Secteur")),
                                      trailing: Text(
                                          widget.dataOffline[
                                                  'secteurLibelle'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Prenom")),
                                      trailing: Text(
                                          widget.dataOffline['prenomBen'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: const InkWell(child: Text("Nom")),
                                      trailing: Text(
                                          widget.dataOffline['nomBen'] ?? "--",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Téléphone")),
                                      trailing: Text(
                                          widget.dataOffline['telBen'] ?? "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Adresse ")),
                                      trailing: Text(
                                          widget.dataOffline['adresseBen'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Région ")),
                                      trailing: Text(
                                          widget.dataOffline['nomRegion'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title:
                                          InkWell(child: Text("Département ")),
                                      trailing: Text(
                                          widget.dataOffline['nomDepart'] ??
                                              "--",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title:
                                          const InkWell(child: Text("Commune")),
                                      trailing: Text(
                                          widget.dataOffline['nomCommune'] ??
                                              "--",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                      onTap: () {},
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 45.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: const InkWell(
                                          child:
                                              Text("Activité de la semaine")),
                                      trailing: Text(
                                          widget.dataOffline['actSemaine'] ??
                                              "--",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                      onTap: () {},
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                              ]),
                        )
                      ])
                    ]))))
        // ),
        );
  }

  Widget buildDateTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
            initialDateTime: dateTime,
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: DateTime(2000, 2, 1),
            maximumDate: DateTime(2050),
            use24hFormat: true,
            onDateTimeChanged: (dateTime) =>
                /*setState(()*/ this.dateTime = dateTime),
        // ),
      );
}
