import 'dart:convert';

import 'package:der/controller/loginApi.controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:der/pages/choisirSection.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.variableclasse.dart';
import '../controller/enquetesApi.controller.dart';
import 'activiteSemeine.pages.dart';
import 'donneesSpecifiques.pages.dart';
import 'enquetesListe.pages.dart';
import 'home.pages.dart';
import 'homeOffline.pages.dart';
import 'login.page.dart';

class NouvelleEnquete extends StatefulWidget {
  //NouvelleEnquete  ({Key? key}) : super(key: key);
  String valOffline;
  NouvelleEnquete({required this.valOffline});

  @override
  State<NouvelleEnquete> createState() => _NouvelleEnqueteState();
}

class _NouvelleEnqueteState extends State<NouvelleEnquete> {
  getSecteurData() async {
    SharedPreferences prefSceteur = await SharedPreferences.getInstance();

    dynamic dataSecteur = prefSceteur.getString('secteurData');
    dynamic dataRegion = prefSceteur.getString('regionData');

    if (dataRegion == null) {
      Fluttertoast.showToast(
          msg: "  données n'existent pas ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.redAccent,
          textColor: Colors.black,
          fontSize: 16.0);
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      sectuerDataList.add(dataSecteur);

      setState(() {
        sectuerDataListJson = jsonDecode(dataSecteur);
        regionDataListJson = jsonDecode(dataRegion);
      });
    }
  }

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();

    getRegion();

    getSecteurData();
  }

  List itemData = [];

  dynamic selectedValueSection;
  dynamic selectedValueRgion;
  String? selectedValueNomRgion;
  dynamic selectedValueDepart;
  String? selectedValueNomDepart;
  dynamic selectedValueCommune;
  String? selectedValueNomCommune;
  List posteaquaiItem = [];
  List regionItem = [];
  List departementItem = [];
  dynamic departementI;
  List communeItem = [];
  String? libelleSelectedValueSection;
  String? idSelectedValueSection;
  TextEditingController nomNavireController = TextEditingController();

  TextEditingController referenceProjController = TextEditingController();

  TextEditingController dateEnqueteController = TextEditingController();
  TextEditingController titreProjetController = TextEditingController();
  TextEditingController prenomBenController = TextEditingController();
  TextEditingController nomBenController = TextEditingController();

  TextEditingController telBenController = TextEditingController();
  TextEditingController adresseBenController = TextEditingController();
  TextEditingController numCNIBenController = TextEditingController();
  TextEditingController dateDemaracheActiv = TextEditingController();

  String? dateEnquete;

  final dataLogin = LoginController();

  final dataEnquete = EnquetesController();

  dynamic data;
  //dynamic sectuerData;
  List sectuerDataList = [];
  List sectuerDataListJson = [];
  List regionDataListJson = [];
  String? libelles;

  List secteur = [];
  dynamic lib;
  Future getSecteur() async {
    dataEnquete.getStringToken().then((dynamic value) async {
      String? token = value.toString();
      print("valToken");
      // print(valToken);
      print("valToken");

      var url = VariableClasse.hostSectuer;
      print(url);
      try {
        var response = await http.get(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          regionDataListJson.clear();

          data = json.decode(response.body);

          setState(() async {
            sectuerDataListJson = data["data"];
          });
        } else {
          throw Exception('les données existent pas');
        }
      } catch (e) {
        return e.toString();
      }
    });
  }

  getDepart(dynamic dataRegion) {
    setState(() {
      departementItem = dataRegion["departements"];
    });

    return departementItem;
  }

  Future getRegion() async {
    dataEnquete.getStringToken().then((dynamic value) async {
      String? token = value.toString();
      print("valToken");
      // print(valToken);
      print("valToken");

      var url = VariableClasse.hostRegion;
      print(url);
      try {
        var response = await http.get(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        // EasyLoading.show(status: 'loading...');
        if (response.statusCode == 200) {
          dynamic regionData = json.decode(response.body);

          setState(() {
            regionDataListJson = regionData["data"];
          });
        } else {
          throw Exception('les données existent pas');
        }
      } catch (e) {
        return e.toString();
      }
    });
  }

  String dropdownValue = 'Dog';
  @override
  Widget build(BuildContext context) {
    //final apiData= MarchandiseController();
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (widget.valOffline == "false") {
                print("if false ${widget.valOffline}");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NouvelleEnquete(
                        valOffline: '',
                      ),
                    ));
              } else if (widget.valOffline == "true") {
                print("else true  ${widget.valOffline}");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnquetesListe(),
                    ));
              }
            },
          ),
          title: Text(
            ' Nouvelle enquete',
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
                              height: 48.0,
                              width: 1000.0,
                              color: Colors.grey[300],
                              child: const ListTile(
                                title: InkWell(
                                    child: Text("Initialisation")),
                                // trailing: IconButton(
                                //   icon: const Icon(Icons.control_point_sharp,
                                //       color: Colors.black),
                                //   onPressed: validate,
                                // ),
                              ),
                            ),

                            Container(
                              height: 48.0,
                              width: 1000.0,
                              color: Colors.white,
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text("  Selectionnez Secteur"),
                                  value: selectedValueSection,
                                  items: sectuerDataListJson.map((secteur) {
                                    return DropdownMenuItem(
                                        value: secteur,
                                        child: Text(secteur['libelle']));
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedValueSection = value;
                                      libelleSelectedValueSection =
                                          selectedValueSection["libelle"];
                                      idSelectedValueSection =
                                          selectedValueSection["id"].toString();
                                    });
                                  }),
                            ),

                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextField(
                                controller: dateEnqueteController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.event_outlined,
                                    color: Colors.blue,
                                  ),

                                  label: Text('Date enquete'),
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
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);
                                    dateEnquete = DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                    print(formattedDate);
                                    print(
                                        "notre Date  =$dateEnquete"); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateEnqueteController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: referenceProjController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Référence projet'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Référence projet.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: titreProjetController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Titre de projet'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Titre de projet.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),

                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: prenomBenController,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Prenom bénéficiaire'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Prenom bénéficiaire.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),

                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: nomBenController,
                                // keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Nom bénéficiaire'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Nom bénéficiaire.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: telBenController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Tél du bénéficiaire'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Tél du bénéficiaire.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: numCNIBenController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Numero CNI du bénéficiaire'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Numero CNI du bénéficiaire.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.grey,
                              height: 48.0,
                              width: 1000.0,
                              child: TextFormField(
                                //enabled: false,
                                controller: adresseBenController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  label: Text(' Adresse du bénéficiaire'),
                                  // errorText: _surfaceOccupee ? 'Surface occupée ne doit pas etre vide': null,

                                  hintText: ' Adresse du bénéficiaire.',
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              height: 48.0,
                              width: 1000.0,
                              //color: Colors.grey,
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text("  Selectionnez region"),
                                  value: selectedValueRgion,
                                  items:
                                      regionDataListJson.map((dynamic region) {
                                    return DropdownMenuItem(
                                        value: region,
                                        child: Text(region['nom_region']));
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedValueRgion = value;
                                      getDepart(selectedValueRgion);

                                      selectedValueNomRgion =
                                          selectedValueRgion['nom_region'] ??
                                              "";

                                      departementItem =
                                          selectedValueRgion["departements"];
                                    });
                                  }),
                            ),
                            Container(
                              height: 48.0,
                              width: 1000.0,
                              //color: Colors.grey,
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(" Selectionnez departement"),
                                  value: selectedValueDepart,
                                  items: departementItem.map((depart) {
                                    return DropdownMenuItem(
                                        value: depart,
                                        child: Text(depart['nom_departement']));
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedValueDepart = value;
                                      selectedValueNomDepart =
                                          selectedValueDepart[
                                              "nom_departement"];

                                      communeItem =
                                          selectedValueDepart["communes"];
                                    });
                                  }),
                            ),

                            Container(
                              height: 48.0,
                              width: 1000.0,
                              //color: Colors.grey,
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(" commune"),
                                  value: selectedValueCommune,
                                  items: communeItem.map((commune) {
                                    return DropdownMenuItem(
                                        value: commune,
                                        child: Text(commune['nom_commune']));
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedValueCommune = value;
                                      selectedValueNomCommune =
                                          selectedValueCommune['nom_commune'];
                                    });
                                  }),
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
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Offline(),) );

          print(idSelectedValueSection);
          print(widget.valOffline);
          if (idSelectedValueSection != null &&
              dateEnquete != null &&
              referenceProjController.text != "" &&
              titreProjetController.text != "" &&
              prenomBenController.text != "" &&
              telBenController.text != "" &&
              numCNIBenController.text != "" &&
              adresseBenController.text != "" &&
              selectedValueRgion != null &&
              selectedValueNomDepart != null &&
              selectedValueNomCommune != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChoisirSection(
                        secteurID: selectedValueSection["id"].toString(),
                        secteurLibelle: selectedValueSection["libelle"],
                        dateEnquete: dateEnquete.toString(),
                        referenceProj: referenceProjController.text,
                        titreProjet: titreProjetController.text,
                        prenomBen: prenomBenController.text,
                        nomBen: nomBenController.text,
                        telBen: telBenController.text,
                        numCNIBen: numCNIBenController.text,
                        adresseBen: adresseBenController.text,
                        selectedValueRgion: selectedValueRgion['nom_region'],
                        selectedValueDepart:
                            selectedValueDepart['nom_departement'],
                        selectedValueCommune:
                            selectedValueCommune['nom_commune'],
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

class Persons {
  int ID, NombreHomme, NombreFemme;
  String IntituleActivite, DescriptionActivite, typeMaterielUtilise;
  Persons(this.ID, this.IntituleActivite, this.DescriptionActivite,
      this.NombreHomme, this.NombreFemme, this.typeMaterielUtilise);
}
