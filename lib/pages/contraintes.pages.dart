import 'dart:convert';
import 'package:der/pages/donneesSpecifiques.pages.dart';
import 'package:der/pages/geolocalisation.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Contrainte extends StatefulWidget {
  String selectValue;
  String secteurID;
  String dateEnquete;
  String referenceProj;
  dynamic actSemaine;
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

  Contrainte(
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
      required this.valOffline});

  @override
  State<Contrainte> createState() => _ContrainteState();
}

class _ContrainteState extends State<Contrainte> {
  List<Contraintes> ContraintesList = <Contraintes>[];
  List containteValue = [];
  dynamic containteValueJson;

  final formKey = new GlobalKey<FormState>();
  var ID_Controller = new TextEditingController();
  var DifficulteRencontre_Controller = new TextEditingController();
  var SolutionTrouve_Controller = new TextEditingController();
  var SuiviNecessaire_Controller = new TextEditingController();
  var lastID = 0;

  String? ValTest;

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();
    // ;
    lastID++;
    ID_Controller.text = lastID.toString();
  }

  // Method that is used to refresh the UI and show the new inserted data.
  refreshList() {
    setState(() {
      ID_Controller.text = lastID.toString();
      containteValue;
    });
  }

  // Method used to validate the user data
  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String ID = ID_Controller.text;
      String N = DifficulteRencontre_Controller.text;
      String LN = SolutionTrouve_Controller.text;
      String A = SuiviNecessaire_Controller.text;
      Contraintes p = Contraintes(int.parse(ID), N, LN, A);
      ContraintesList.add(p);
      lastID++;
      refreshList();
      DifficulteRencontre_Controller.text = "";
      SolutionTrouve_Controller.text = "";
      SuiviNecessaire_Controller.text = "";
      containteValue.add(p.ID);
      containteValue.add(p.DifficulteRencontre);
      containteValue.add(p.SolutionTrouve);
      containteValue.add(p.SuiviNecessaire);
      ValTest = (p.DifficulteRencontre);
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

  final libelle = TextEditingController();

  List itemData = [];

  String selectValue = "";

  List selectedValue = [];

  getJson(dynamic valueContrainte) {
    containteValueJson = json.encode(valueContrainte);

    return containteValueJson;
  }

  @override
  Widget build(BuildContext context) {
    getJson(containteValue);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Contraintes',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.0,
                              width: 1000.0,
                              color: Colors.grey[300],
                              child: ListTile(
                                title:
                                    const InkWell(child: Text("contraintes")),
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
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text("Person ID:"),
                              // TextField(
                              //   controller: ID_Controller,
                              //   enabled: false,
                              // ),
                              Container(
                                // color: Colors.grey,
                                height: 60.0,
                                width: 1000.0,
                                child: TextFormField(
                                  //enabled: false,
                                  controller: DifficulteRencontre_Controller,
                                  //keyboardType: TextInputType.number,
                                  validator: (val) => val?.length == 0
                                      ? "Enter Difficulté Rencontrée"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Difficulté Rencontrée:"),
                                    // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                    hintText: "Difficulté Rencontrée",
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
                                  controller: SolutionTrouve_Controller,
                                  //keyboardType: TextInputType.number,
                                  validator: (val) => val?.length == 0
                                      ? "Enter Solution Trouvée"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Solution Trouvée"),
                                    // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                    hintText: "Solution Trouvée",
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
                                  controller: SuiviNecessaire_Controller,
                                  keyboardType: TextInputType.text,
                                  validator: (val) => val?.length == 0
                                      ? "Enter Suivi Necessaire"
                                      : null,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    label: Text("Suivi Necessaire"),
                                    // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                    hintText: "Suivi Necessaire",
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
                              label: Text("Difficuté rencontrée"),
                            ),

                            DataColumn(
                              label: Text("Solution trouvée"),
                            ),

                            DataColumn(
                              label: Text("Suivi nécessaire"),
                            ),
                            DataColumn(
                              label: Text("Action"),
                            ),
                          ],
                          rows: ContraintesList.map(
                            (p) => DataRow(cells: [
                              // DataCell(
                              //   Text(p.ID.toString()),
                              // ),
                              DataCell(
                                Text(p.DifficulteRencontre),
                              ),

                              DataCell(
                                Text(p.SolutionTrouve),
                              ),

                              DataCell(
                                Text(p.SuiviNecessaire.toString()),
                              ),
                              DataCell(IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  print(containteValueJson);
                                  print("containteValue");
                                  print(containteValue);
                                  print("containteValue");
                                  int de = p.ID;
                                  String difficulteRencontre =
                                      p.DifficulteRencontre;
                                  String solutionTrouve = p.SolutionTrouve;
                                  String suiviNecessaire = p.SuiviNecessaire;
                                  print(de);
                                  setState(() {
                                    ContraintesList!.remove(p);

                                    for (var i = 0;
                                        i < containteValue.length;
                                        i++) {
                                      if (containteValue[i] == de) {
                                        containteValue.removeAt(i);
                                      }
                                      if (containteValue[i] ==
                                          difficulteRencontre) {
                                        containteValue.removeAt(i);
                                      }
                                      if (containteValue[i] == solutionTrouve) {
                                        containteValue.removeAt(i);
                                      }
                                      if (containteValue[i] ==
                                          suiviNecessaire) {
                                        containteValue.removeAt(i);
                                      }
                                    }
                                    print("sorti");
                                    print(containteValue);
                                    print("fin");
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
            print("++++++++++++ValTest--------------");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Geolocalisation(
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
                        actSemaine: widget.actSemaine,
                        containteValue: containteValueJson,
                        valOffline: widget.valOffline)));
          } else {
            Fluttertoast.showToast(
                msg: "  les champs sont obligatoires : ",
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

class Contraintes {
  int ID;
  String DifficulteRencontre, SolutionTrouve, SuiviNecessaire;
  Contraintes(this.ID, this.DifficulteRencontre, this.SolutionTrouve,
      this.SuiviNecessaire);
}
