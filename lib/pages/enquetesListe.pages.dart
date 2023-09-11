import 'dart:convert';

import 'package:der/controller/enquetesApi.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../config/config.variableclasse.dart';
import 'detailEnquete.pages.dart';
import 'choisirSection.pages.dart';
import 'home.pages.dart';
import 'nouvelleEnquete.pages.dart';

class EnquetesListe extends StatefulWidget {
  const EnquetesListe({super.key, });

  @override
  State<EnquetesListe> createState() => _EnquetesListeState();
}

class _EnquetesListeState extends State<EnquetesListe> {
  final dataEnquete = EnquetesController();
  TextEditingController nomNavireController = TextEditingController();

  TextEditingController surfaceOccupeeController = TextEditingController();

  TextEditingController dateDepot = TextEditingController();

  TextEditingController dateFinOperation = TextEditingController();

  TextEditingController editerTexte = TextEditingController();

  TextEditingController editerTexteMarchandise = TextEditingController();

  TextEditingController dateDebutController = TextEditingController();

  List itemData = [];
  dynamic listeEscale;

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEnquetes();
  }

  Future getEnquetes() async {
    dataEnquete.getStringToken().then((dynamic value) async {
      String? token = value.toString();



      try {
        var url = VariableClasse.hostListeEnquete;

        var response = await http.get(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        //print('Response body: ${response.body}');
        //  print('Response status: ${response.statusCode}');
        if (response.statusCode == 200) {
          setState(() {
            dynamic data = json.decode(response.body);
            listeEscale = data["data"]["data"];
          });
        } else if (response.statusCode == 500) {
          Fluttertoast.showToast(
              msg: "Pas de permission",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.black,
              fontSize: 16.0);

          return throw ("Service inaccèssible");
        } else {
          Fluttertoast.showToast(
              msg: "les données existent pas",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.black,
              fontSize: 16.0);
          throw Exception('les données existent pas');
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Une erreur s'est produite ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            fontSize: 16.0);
        // return throw ("Service inaccèssible");
        //return e.toString();
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
                  builder: (context) => const HomePage(),
                ));

            // });
          },
        ),
        title: Text(
          'Les Enquetes ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // body: SingleChildScrollView(
      body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
                height: 2,
                color: Colors.black12,
              ),
          itemCount: (listeEscale == null) ? 0 : listeEscale.length,
          itemBuilder: (context, index) {
            // DateTime inputDate;
            return ListTile(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          //builder: (context)=> Tournee()
                          builder: (context) => DetailEnquetes(
                              dataEnquete: listeEscale[
                                  index] /*,valToken: widget.valToken*/)));
                });
              },
              title: InkWell(
                child: Text(
                    "${listeEscale[index]['nom_beneficiaire']}  ${listeEscale[index]['prenom_beneficiaire']}"),
              ),
              subtitle: Text(
                  "${listeEscale[index]['reference_projet']}  ${listeEscale[index]['titre_projet']}"),
              leading: const Icon(
                Icons.apps,
                color: Colors.lightBlue,
                size: 30,
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: <Widget>[
                    Text(DateFormat("dd/MM/yyyy").format(
                        DateTime.parse("${listeEscale[index]['created_at']}"))),
                    const Icon(Icons.arrow_right,
                        color: Colors.lightBlueAccent),
                  ],
                ),
              ),
            );
          }),
      //     floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {},
      //
      //       icon: const Icon(Icons.add),
      //     label:  Text(''),
      //
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  //builder: (context)=> Tournee()
                  builder: (context) => NouvelleEnquete(valOffline: "true")));
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );

    // ),
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
