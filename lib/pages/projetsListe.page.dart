import 'dart:convert';

import 'package:der/pages/detailProjet.pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../config/config.variableclasse.dart';
import '../controller/enquetesApi.controller.dart';
import 'home.pages.dart';

class Projets extends StatefulWidget {
  Projets();

  @override
  State<Projets> createState() => _ProjetsState();
}

class _ProjetsState extends State<Projets> {
  dynamic data;
  dynamic listeEscale;
  final dataEnquete = EnquetesController();
  @override
  Widget build(BuildContext context) {
    print(" Demarrer ...");
    // loadApi();
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
            'Liste des projets ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Container(
              child: ListView.separated(
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
                          print("listeEscale[index]");
                          print(listeEscale[index]);
                          print("listeEscale[index]");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProjets(
                                      dataProjet: listeEscale[index])));
                        });
                      },
                      title: InkWell(
                        child:
                            Text("${listeEscale[index]['reference_projet']}"),
                      ),
                      subtitle: Text("${listeEscale[index]['titre_projet']}"),
                      leading: const Icon(
                        Icons.ac_unit,
                        color: Colors.lightBlue,
                        size: 30,
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: <Widget>[
                            Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                "${listeEscale[index]['created_at']}"))),
                            const Icon(Icons.arrow_right,
                                color: Colors.lightBlueAccent),
                          ],
                        ),
                      ),
                    );
                  })),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadApi();
  }

  void loadApi() async {
    dataEnquete.getStringToken().then((dynamic value) async {
      String? token = value.toString();

      var url = VariableClasse.hostListeProjet;

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

      try {
        if (response.statusCode == 200) {
          setState(() {
            data = json.decode(response.body);
            listeEscale = data['data']['data'];
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
        return throw ("Service inaccèssible");
        //return e.toString();
      }
    });
  }
}
