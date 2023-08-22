import 'package:der/controller/enquetesApi.controller.dart';
import 'package:der/pages/enquetesListe.pages.dart';
import 'package:der/pages/projetsListe.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'choisirSection.pages.dart';
import 'home.pages.dart';
import 'nouvelleEnquete.pages.dart';

class DetailProjets extends StatefulWidget {
  // String? valToken;
  dynamic dataProjet;

  DetailProjets({this.dataProjet});

  @override
  State<DetailProjets> createState() => _DetailProjetsState();
}

class _DetailProjetsState extends State<DetailProjets> {
  List itemData = [];

  DateTime dateTime = DateTime.now();

  String? prenomBeneficiaire;

  String? nomBeneficiaire;

  @override
  Widget build(BuildContext context) {
    print(widget.dataProjet);

    // widget.dataProjet['beneficiaire'].forEach((element) {
    //     prenomBeneficiaire=element['prenom_beneficiaire'];
    //   nomBeneficiaire=element['nom_beneficiaire'];
    //
    // });

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              setState(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Projets(),
                    ));
              });
            },
          ),
          title: Text(
            'Détail de projet ',
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
                                    height: 40.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Ref proje")),
                                      trailing: Text(
                                          /*widget.dataProjet['reference_projet']??*/ "0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                    height: 40.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(
                                          child: Text("Titre de Projet")),
                                      trailing: Text(
                                          widget.dataProjet['titre_projet'] ??
                                              "0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                SizedBox(
                                    height: 40.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: InkWell(child: Text("Prenom")),
                                      trailing: Text(
                                          widget.dataProjet[
                                                  'prenom_beneficiaire'] ??
                                              "0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.black12,
                                ),
                                Container(
                                    height: 40.0,
                                    width: 1000.0,
                                    child: ListTile(
                                      title: const InkWell(child: Text("Nom")),
                                      trailing: Text(
                                          widget.dataProjet[
                                                  'nom_beneficiaire'] ??
                                              "0",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54)),
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
