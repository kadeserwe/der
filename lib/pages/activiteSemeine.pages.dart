import 'dart:convert';

import 'package:der/pages/contraintes.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActiviteSemeine extends StatefulWidget {
  String secteurID;
  String dateEnquete;
  String referenceProj, selectValue;
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

  ActiviteSemeine(
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
      required this.valOffline});

  @override
  State<ActiviteSemeine> createState() => _ActiviteSemeineState();
}

class _ActiviteSemeineState extends State<ActiviteSemeine> {
  List<Activite> PersonsLst = <Activite>[];
  List actSemaine = [];
  dynamic actSemaineValue;

  final formKey = new GlobalKey<FormState>();
  var ID_Controller = new TextEditingController();
  var IntituleActivite_Controller = new TextEditingController();
  var DescriptionActivite_Controller = new TextEditingController();
  var NombreHomme_Controller = new TextEditingController();
  var NombreFemme_Controller = new TextEditingController();
  var typeMaterielUtilise_Controller = new TextEditingController();
  // var ddd_Controller = new TextEditingController();
  List val = [];
  var lastID = 0;
  String? ValTest;

  @override
  // Method e de initiation de l'application .
  void initState() {
    super.initState();
    lastID++;
    ID_Controller.text = lastID.toString();
  }

  // Methode qui refresh la vue avec les  données.
  refreshList() {
    setState(() {
      ID_Controller.text = lastID.toString();
      actSemaine;
    });
  }

  // Method used to validate the user data
  validate() {
    if (formKey.currentState!.validate()) {
      ();
      formKey.currentState!.save();
      String ID = ID_Controller.text;
      String N = IntituleActivite_Controller.text;
      String LN = DescriptionActivite_Controller.text;
      String A = NombreHomme_Controller.text;
      String NbF = NombreFemme_Controller.text;
      String TMU = typeMaterielUtilise_Controller.text;

      Activite p =
          Activite(int.parse(ID), N, LN, int.parse(A), int.parse(NbF), TMU);
      PersonsLst.add(p);
      //actSemaine.add(p);
      lastID++;
      refreshList();
      IntituleActivite_Controller.text = "";
      DescriptionActivite_Controller.text = "";
      NombreHomme_Controller.text = "";
      NombreFemme_Controller.text = "";
      typeMaterielUtilise_Controller.text = "";

      actSemaine.add(p.ID);
      actSemaine.add(p.IntituleActivite);
      actSemaine.add(p.DescriptionActivite);
      actSemaine.add(p.NombreHomme);
      actSemaine.add(p.NombreFemme);
      actSemaine.add(p.typeMaterielUtilise);
      ValTest = (p.IntituleActivite);
    }
  }

  // Method to check the value of age, age is int or not
  bool NotIntCheck(var N) {
    final V = int.tryParse(N);

    if (V == null) {
      print("Not Int");
      return true;
    } else {
      print("Int");
      return false;
    }
  }

  List itemData = [];

  getJson(dynamic valueActivite) {
    actSemaineValue = json.encode(valueActivite);

    return actSemaineValue;
  }

  @override
  Widget build(BuildContext context) {
    getJson(actSemaine);

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
        padding: const EdgeInsets.all(20.0),
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
                                    child: Text("activité de la semaine")),
                                trailing: IconButton(
                                  icon: const Icon(Icons.control_point_sharp,
                                      color: Colors.black),
                                  onPressed: validate,
                                ),
                              ),
                            ),
                            //const Divider(height: 0, color: Colors.black12,),
                          ]),
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  child: ListView(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                width: 1000.0,
                                child: TextFormField(
                                  controller: IntituleActivite_Controller,
                                  //keyboardType: TextInputType.number,
                                  validator: (val) => val?.length == 0
                                      ? "Enter intitulé de l'activité"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Intitulé de l'activité:"),
                                    hintText: "Enter intitulé de l'activité",
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
                                  controller: DescriptionActivite_Controller,
                                  //keyboardType: TextInputType.number,
                                  validator: (val) => val?.length == 0
                                      ? "Enter description de l'Activité"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Description de l'activité"),
                                    hintText: "Enter description de l'activité",
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
                                  controller: NombreHomme_Controller,
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val?.length == 0
                                      ? "Enter nombre d'homme"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Nombre d'homme"),
                                    hintText: "Enter nombre d'homme",
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
                                  controller: NombreFemme_Controller,
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val?.length == 0
                                      ? "Enter nombre de femme"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Nombre de femme"),
                                    // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                    hintText: "Enter nombre de femme",
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
                                  controller: typeMaterielUtilise_Controller,
                                  keyboardType: TextInputType.text,
                                  validator: (val) => val?.length == 0
                                      ? "Enter type materiel utilisé"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Type materiel utilisé"),
                                    // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                    hintText: "Type materiel utilisé",
                                    hintStyle: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            // DataColumn(
                            //   label: Text("ID"),
                            // ),
                            DataColumn(
                              label: Text("Intitulé de l'activité"),
                            ),
                            DataColumn(
                              label: Text("Description de l'activité"),
                            ),
                            DataColumn(
                              label: Text("Nombre d'homme"),
                            ),
                            DataColumn(
                              label: Text("Nombre de femme"),
                            ),
                            DataColumn(
                              label: Text("Type de materiel utilisé"),
                            ),
                            DataColumn(
                              label: Text("Action"),
                            ),
                          ],
                          rows: PersonsLst.map(
                            (p) => DataRow(cells: [
                              // DataCell(
                              //   Text(p.ID.toString()),
                              // ),
                              DataCell(
                                Text(p.IntituleActivite),
                              ),
                              DataCell(
                                Text(p.DescriptionActivite),
                              ),
                              DataCell(
                                Text(p.NombreHomme.toString()),
                              ),
                              DataCell(
                                Text(p.NombreFemme.toString()),
                              ),
                              DataCell(
                                Text(p.typeMaterielUtilise.toString()),
                              ),
                              DataCell(IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  int de = p.ID;
                                  String intituleActivite = p.IntituleActivite;
                                  String descriptionActivite =
                                      p.DescriptionActivite;
                                  int nombreHomme = p.NombreHomme;
                                  int nombreFemme = p.NombreFemme;
                                  String TypeMaterielUtilise =
                                      p.typeMaterielUtilise;
                                  print(de);
                                  setState(() {
                                    PersonsLst!.remove(p);
                                    //  containteValueJson!.remove(de);

                                    for (var i = 0;
                                        i < actSemaine.length;
                                        i++) {
                                      if (actSemaine[i] == de) {
                                        actSemaine.removeAt(i);
                                      }
                                      if (actSemaine[i] == intituleActivite) {
                                        actSemaine.removeAt(i);
                                      }
                                      if (actSemaine[i] ==
                                          descriptionActivite) {
                                        actSemaine.removeAt(i);
                                      }
                                      if (actSemaine[i] == nombreHomme) {
                                        actSemaine.removeAt(i);
                                      }
                                      if (actSemaine[i] == nombreFemme) {
                                        actSemaine.removeAt(i);
                                      }
                                      if (actSemaine[i] ==
                                          TypeMaterielUtilise) {
                                        actSemaine.removeAt(i);
                                      }
                                    }
                                  });
                                  //Delete row
                                },
                              )),
                            ]),
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            )),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (ValTest != null) {
            print("++ValTest");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Contrainte(
                        secteurID: widget.secteurID,
                        secteurLibelle: widget.secteurLibelle,
                        dateEnquete: widget.dateEnquete,
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
                        selectValue: widget.selectValue,
                        actSemaine: actSemaineValue,
                        valOffline: widget.valOffline)));
          } else {
            Fluttertoast.showToast(
                msg: "  les champs sont obligatoires : ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 8012,
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

class Activite {
  int ID, NombreHomme, NombreFemme;
  String IntituleActivite, DescriptionActivite, typeMaterielUtilise;
  Activite(this.ID, this.IntituleActivite, this.DescriptionActivite,
      this.NombreHomme, this.NombreFemme, this.typeMaterielUtilise);
}
