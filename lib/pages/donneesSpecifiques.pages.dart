import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

import 'geolocalisation.pages.dart';

class DonneesSpecifiques extends StatefulWidget {
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

  DonneesSpecifiques(
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
  State<DonneesSpecifiques> createState() => _DonneesSpecifiquesState();
}

class _DonneesSpecifiquesState extends State<DonneesSpecifiques> {
  final libelle = TextEditingController();

  List itemData = [];

  String selectValue = "";

  List selectedValue = [];

  List posteaquaiItem = [];
  TextEditingController nomNavireController = TextEditingController();

  TextEditingController surfaceOccupeeController = TextEditingController();

  TextEditingController dateDepot = TextEditingController();

  TextEditingController dateDemaracheActiv = TextEditingController();

  //check environnement  techno socio eco
  List enviTechData = ['Adhésion OP', 'Conseil technique'];
  List selectEnviTechData = [];

  //check enjeux  locaux
  List enjeuxLocaux = [
    'Périurbaine',
    'Inondable',
    'Electrification',
    'Route',
    'Autres'
  ];
  List selectEnjeuxLocaux = [];
  //check Commercialisation  techno socio eco
  List commercialisationData = ['Circuit court', 'Circuit long'];
  List selectCommercialisation = [];

  //check valorisation
  List valorisation = ['Frais', 'Industrie', 'Trnasformations'];
  List selectValorisation = [];

  @override
  Widget build(BuildContext context) {
    //final apiData= MarchandiseController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Données Specifiques',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
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
                                title: const InkWell(
                                    child: Text("données spécifiques")),
                                // trailing: IconButton(
                                //   icon: const Icon(Icons.control_point_sharp,
                                //       color: Colors.black),
                                //   onPressed: validate,
                                // ),
                              ),
                            ),

                            Container(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text('      Superficie'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: '         Superficie.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              width: 1000.0,
                              // color: Colors.grey[300],
                              child: RadioListTile(
                                  title: Text("m2"),
                                  value: "m2",
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
                                    title: const Text("ha"),
                                    value: "ha",
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value.toString();
                                        print(selectValue);
                                      });
                                    })),
                            Container(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(
                                      'Description du fonctionnement global'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText:
                                      'Description du fonctionnement global.',
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
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(
                                      'Description du système de production'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText:
                                      'Description du système de production.',
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
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(
                                      "Priorité de l'exploitation du projet"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText:
                                      "Priorité de l'exploitation du projet.",
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
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                                // color: Colors.grey,
                                height: 50.0,
                                width: 1000.0,
                                child: DropDownMultiSelect(
                                  options: enviTechData,
                                  selectedValues: selectEnviTechData,
                                  onChanged: (value) {
                                    print(
                                        'selected environnement techno-socio-eco $value');
                                    setState(() {
                                      selectEnviTechData = value;
                                    });
                                    print(
                                        'selecte environnement techno-socio-eco $selectEnviTechData .');
                                  },
                                  whenEmpty:
                                      'Selectionnez environnement techno-socio-eco',
                                )),

                            Container(
                                // color: Colors.grey,
                                height: 50.0,
                                width: 1000.0,
                                child: DropDownMultiSelect(
                                  options: enjeuxLocaux,
                                  selectedValues: selectEnjeuxLocaux,
                                  onChanged: (value) {
                                    print('selected enjeux locaux $value');
                                    setState(() {
                                      selectEnjeuxLocaux = value;
                                    });
                                    print(
                                        'selecte enjeux locaux $selectEnjeuxLocaux .');
                                  },
                                  whenEmpty: 'Selectionnez enjeux locaux',
                                )),

                            Container(
                                // color: Colors.grey,
                                height: 50.0,
                                width: 1000.0,
                                child: DropDownMultiSelect(
                                  options: valorisation,
                                  selectedValues: selectValorisation,
                                  onChanged: (value) {
                                    print('selected Valorisation $value');
                                    setState(() {
                                      selectValorisation = value;
                                    });
                                    print(
                                        'selecte Valorisation $selectValorisation .');
                                  },
                                  whenEmpty: 'Selectionnez Valorisation',
                                )),

                            Container(
                                // color: Colors.grey,
                                height: 50.0,
                                width: 1000.0,
                                child: DropDownMultiSelect(
                                  options: commercialisationData,
                                  selectedValues: selectCommercialisation,
                                  onChanged: (value) {
                                    print('selected Commercialisation $value');
                                    setState(() {
                                      selectCommercialisation = value;
                                    });
                                    print(
                                        'selecteCommercialisation $selectCommercialisation .');
                                  },
                                  whenEmpty: 'Selectionnez Commercialisation',
                                )),

                            Container(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextField(
                                controller: dateDemaracheActiv,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.event_outlined,
                                    color: Colors.blue,
                                  ),

                                  label: Text("Date de demarage de l'activité"),
                                  //errorText: _dateDepot ? 'Date dateDepot ne doit pas etre vide':null,
                                  hintText: 'Selectionnez la date enquete.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),

                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.grey,
                              height: 50.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: surfaceOccupeeController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text("Main d'oeuvre"),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: "Main d'oeuvre.",
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),

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
          // print("secteurID:${widget.secteurID}  "  "secteurLibelle: ${widget.secteurLibelle}" "dateEnquete: ${widget.dateEnquete}" "referenceProj: ${widget.referenceProj}"
          //     "titreProjet: ${widget.titreProjet}" "prenomBen: ${widget.prenomBen}" "nomBen: ${widget.nomBen}" "telBen: ${widget.telBen}"
          //     "numCNIBen:${widget.numCNIBen}"  "adresseBen: ${widget.adresseBen}" "selectedValueRgion: ${widget.selectedValueRgion}" "selectedValueDepart: ${widget.selectedValueDepart}"
          //     "selectedValueCommune:${widget.selectedValueCommune}"  "selectValue: ${widget.selectValue}" "actSemaine: ${ widget.actSemaine}" "containteValue: ${widget.containteValue}");

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
                      containteValue: widget.containteValue,
                      valOffline: widget.valOffline)));
        },

        label: const Text('Save '),
        // icon: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
