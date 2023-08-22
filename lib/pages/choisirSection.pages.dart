import 'package:der/pages/activiteSemeine.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:multiselect/multiselect.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

import 'donneesSpecifiques.pages.dart';
import 'home.pages.dart';

class ChoisirSection extends StatefulWidget {
  String secteurID;
  String dateEnquete;
  String referenceProj;
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
  ChoisirSection(
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
      required this.valOffline});

  @override
  State<ChoisirSection> createState() => _ChoisirSectionState();
}

class _ChoisirSectionState extends State<ChoisirSection> {
  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();
  }

  List itemData = [];
  String selectValue = "";
  String? dateEnquete;

  @override
  Widget build(BuildContext context) {
    // Jiffy.now();

    dateEnquete = DateFormat("yyyy-MM-dd HH:mm")
        .format(DateTime.parse(widget.dateEnquete));
    print("widget.secteurID.toString()");
    print(dateEnquete);
    print(widget.secteurLibelle);
    print(widget.selectedValueCommune);
    print("widget.secteurID.toString()");

    //final apiData= MarchandiseController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Nouvelle Enquete',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50.0,
                              width: 1000.0,
                              color: Colors.grey[300],
                              child: ListTile(
                                title: const InkWell(
                                    child: Text("choisir une section")),
                              ),
                            ),

                            Container(
                              height: 50.0,
                              width: 1000.0,
                              // color: Colors.grey[300],
                              child: RadioListTile(
                                  title: Text(
                                      "suivi des dossiers financiés par DER/FJ"),
                                  value:
                                      "suivi des dossiers financiés par DER/FJ",
                                  groupValue: selectValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectValue = value.toString();
                                      print(selectValue);
                                    });
                                  }),
                            ),

                            Container(
                                height: 50.0,
                                width: 1000.0,
                                // color: Colors.grey[300],
                                child: RadioListTile(
                                    title: const Text(
                                        "suivi des decaissements au niveau IFP"),
                                    value:
                                        "suivi des decaissements au niveau IFP",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                        print(selectValue);
                                      });
                                    })),
                            Container(
                                height: 50.0,
                                width: 1000.0,
                                // color: Colors.grey[300],
                                child: RadioListTile(
                                    title: const Text(
                                        "formation et accompagnement des bénéficiaires de la DER/FJ"),
                                    value:
                                        "formation et accompagnement des bénéficiaires de la DER/FJ",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                      });
                                    })),
                            Container(
                                height: 50.0,
                                width: 1000.0,
                                // color: Colors.grey[300],
                                child: RadioListTile(
                                    title: const Text(
                                        "situation des recouvrement au niveau departemental"),
                                    value:
                                        "situation des recouvrement au niveau departemental",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                        print(selectValue);
                                      });
                                    })),
                            Container(
                                height: 50.0,
                                width: 1000.0,
                                // color: Colors.grey[300],
                                child: RadioListTile(
                                    title: Text(
                                        "organisation des sessions d'animation economique "),
                                    value:
                                        "organisation des sessions d'animation economique",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                        print(selectValue);
                                      });
                                    })),
                            Container(
                                height: 50.0,
                                width: 1000.0,
                                // color: Colors.grey[300],
                                child: RadioListTile(
                                    title: Text(
                                        "activité de représentation dans les comités"),
                                    value:
                                        "activité de représentation dans les comités",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                        print(selectValue);
                                      });
                                    })),
                            Container(
                                height: 50.0,
                                width: 1000.0,
                                // color: Colors.grey[300],
                                child: RadioListTile(
                                    title: Text("autres activités "),
                                    value: "autres activités ",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                        print(selectValue);
                                      });
                                      print(selectValue);
                                    })),

                            //const Divider(height: 0, color: Colors.black12,),
                          ]),
                    ),
                  ],
                ),
              ],
            )),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(selectValue);
          if (selectValue != "") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActiviteSemeine(
                        secteurID: widget.secteurID,
                        secteurLibelle: widget.secteurLibelle,
                        dateEnquete: dateEnquete.toString(),
                        referenceProj: widget.referenceProj,
                        titreProjet: widget.titreProjet,
                        prenomBen: widget.prenomBen,
                        nomBen: widget.nomBen,
                        telBen: widget.telBen,
                        numCNIBen: widget.numCNIBen,
                        adresseBen: widget.adresseBen,
                        selectedValueRgion: widget.selectedValueRgion,
                        selectedValueDepart: widget.selectedValueDepart,
                        selectedValueCommune: widget.selectedValueCommune,
                        selectValue: selectValue,
                        valOffline: widget.valOffline)));
          } else {
            Fluttertoast.showToast(
                msg: "  Veillez selectionnez une option: ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.redAccent,
                textColor: Colors.black,
                fontSize: 16.0);
          }
        },

        label: const Text('suivant '),
        // icon: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
