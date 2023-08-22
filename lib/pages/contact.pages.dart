import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.pages.dart';

class Contacts extends StatelessWidget {
  TextEditingController nomNavireController = TextEditingController();
  TextEditingController surfaceOccupeeController = TextEditingController();
  TextEditingController dateDepot = TextEditingController();
  TextEditingController dateFinOperation = TextEditingController();
  TextEditingController editerTexte = TextEditingController();
  TextEditingController editerTexteMarchandise = TextEditingController();
  TextEditingController dateDebutController = TextEditingController();
  List itemData = [];
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //iconTheme: const IconThemeData(color: Colors.white),
          /* actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.search, color: Colors.white ),
          )
        ],*/
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
          title: const Text(
            'Bénéficiaires',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // body: SingleChildScrollView(
        body: SingleChildScrollView(
            child: Container(

                // padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Card(
                    child: Container(
                  // padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),
                        Container(
                            height: 50.0,
                            width: 1000.0,
                            child: ListTile(
                              title: const InkWell(child: Text("Prenom")),
                              trailing: Text("ff",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            )),
                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),

                        Container(
                            height: 50.0,
                            width: 1000.0,
                            child: ListTile(
                              title: const InkWell(child: Text("Nom")),
                              trailing: Text('Par Avion',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            )),
                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),

                        Container(
                            height: 50.0,
                            width: 1000.0,
                            child: const ListTile(
                              title: InkWell(child: Text("Numero CNI")),
                              trailing: Text(" 2017sn",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            )),
                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),

                        Container(
                            height: 50.0,
                            width: 1000.0,
                            child: const ListTile(
                              title: InkWell(child: Text("Téléphone")),
                              trailing: Text("778892456",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            )),
                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),

                        Container(
                            height: 50.0,
                            width: 1000.0,
                            child: const ListTile(
                              title: InkWell(child: Text("Adresse ")),
                              trailing: Text("sicap Baobab",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            )),
                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),
                        Container(
                            height: 50.0,
                            width: 1000.0,
                            child: ListTile(
                              title: const InkWell(child: Text("Commune")),
                              trailing: Text("Dakar ",
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
                            height: 50.0,
                            width: 1000.0,
                            child: ListTile(
                              title: const InkWell(child: Text("Action")),
                              trailing: Text("ok ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                              onTap: () {},
                            )),

                        const Divider(
                          height: 0,
                          color: Colors.black12,
                        ),

                        //const Divider(height: 0, color: Colors.black12,),
                      ]),
                ))))
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
