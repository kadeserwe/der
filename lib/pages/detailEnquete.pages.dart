import 'package:der/controller/enquetesApi.controller.dart';
import 'package:der/pages/enquetesListe.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../config/config.variableclasse.dart';
import 'choisirSection.pages.dart';
import 'home.pages.dart';
import 'nouvelleEnquete.pages.dart';
import 'package:http/http.dart' as http;

class DetailEnquetes extends StatefulWidget {
  String? valToken;
  dynamic dataEnquete;

  DetailEnquetes({this.dataEnquete, this.valToken});

  @override
  State<DetailEnquetes> createState() => _DetailEnquetesState();
}

class _DetailEnquetesState extends State<DetailEnquetes> {
  final dataEnqueteCtrl = EnquetesController();

  List itemData = [];

  DateTime dateTime = DateTime.now();

  Future supprimerEnquete(String idEnquete) async {
    dataEnqueteCtrl.getStringToken().then((dynamic value) async {
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
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Erreur de suppression !!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.red,
            textColor: Colors.red,
            fontSize: 16.0);
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
              // setState(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnquetesListe(),
                  ));

              // });
            },
          ),
          title: const Text(
            'Détail enquête ',
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
                                      title: const InkWell(
                                          child: Text("Ref proje")),
                                      trailing: Text(
                                          widget.dataEnquete[
                                                  'reference_projet'] ??
                                              "--",
                                          style: const TextStyle(
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
                                      title: const InkWell(
                                          child: Text("Date Enquête")),
                                      trailing: Text(
                                          DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(widget.dataEnquete[
                                                      'created_at'] ??
                                                  "--")),
                                          style: const TextStyle(
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
                                      title: const InkWell(
                                          child: Text("Titre de Projet")),
                                      trailing: Text(
                                          widget.dataEnquete['titre_projet'] ??
                                              "--",
                                          style: const TextStyle(
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
                                          const InkWell(child: Text("Secteur")),
                                      trailing: Text(
                                          widget.dataEnquete[
                                                  'libelle_secteur'] ??
                                              "--",
                                          style: const TextStyle(
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
                                          const InkWell(child: Text("Prenom")),
                                      trailing: Text(
                                          widget.dataEnquete[
                                                  'prenom_beneficiaire'] ??
                                              "--",
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
                                      title: const InkWell(child: Text("Nom")),
                                      trailing: Text(
                                          widget.dataEnquete[
                                                  'nom_beneficiaire'] ??
                                              "--",
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
                                      title: const InkWell(
                                          child: Text("Téléphone")),
                                      trailing: Text(
                                          widget.dataEnquete[
                                                  'telephone_beneficiaire'] ??
                                              "--",
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
                                      title: const InkWell(
                                          child: Text("Adresse ")),
                                      trailing: Text(
                                          widget.dataEnquete[
                                                  'adresse_beneficiaire'] ??
                                              "--",
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
                                      title:
                                          const InkWell(child: Text("Région ")),
                                      trailing: Text(
                                          widget.dataEnquete['region'] ?? "--",
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
                                          widget.dataEnquete['departement'] ??
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
                                          widget.dataEnquete['commune'] ?? "--",
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
                                      title:
                                          const InkWell(child: Text("Statut")),
                                      trailing: Text(
                                          widget.dataEnquete['status'] ?? "--",
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
                                  height: 60.0,
                                  width: 1000.0,
                                  //color: Colors.lightBlue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(
                                          child: const Text("supprimer "),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    scrollable: true,
                                                    title: const Text(
                                                        'Voulez-vous supprimer'),
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Form(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                                height: 45.0,
                                                                width: 1000.0,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    ElevatedButton(
                                                                        child: Text(
                                                                            "Oui"),
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              widget.dataEnquete["id"]);

                                                                          supprimerEnquete(widget.dataEnquete["id"].toString())
                                                                              .then((value) {
                                                                            // int reponseValue=value;
                                                                            print("+++++++++++++value----------");
                                                                            print(value);

                                                                            setState(() {
                                                                              // if(value==200){
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => EnquetesListe(),
                                                                                  ));

                                                                              //   }
                                                                            });

                                                                            //  }
                                                                          });
                                                                        }),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    ElevatedButton(
                                                                        child: Text(
                                                                            "Non"),
                                                                        onPressed:
                                                                            () {
                                                                          //Navigator.();
                                                                          Navigator.pop(
                                                                              context);
                                                                        })
                                                                  ],
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }),
                                      const SizedBox(width: 5),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Annuler"),
                                      ),
                                    ],
                                  ),
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
