import 'package:der/pages/enquetesListe.pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fichierView.page.dart';
import 'geolocalisation.pages.dart';
import 'home.pages.dart';

class EnquetesAnalyses extends StatefulWidget {
  String? valToken;
  EnquetesAnalyses({this.valToken});
  @override
  State<EnquetesAnalyses> createState() => _EnquetesAnalysesState();
}

class _EnquetesAnalysesState extends State<EnquetesAnalyses> {
  TextEditingController nomNavireController = TextEditingController();

  TextEditingController surfaceOccupeeController = TextEditingController();

  TextEditingController dateDepot = TextEditingController();

  TextEditingController dateFinOperation = TextEditingController();

  TextEditingController editerTexte = TextEditingController();

  TextEditingController editerTexteMarchandise = TextEditingController();

  TextEditingController dateDebutController = TextEditingController();

  List itemData = [];

  DateTime dateTime = DateTime.now();

  getStringToken() async {
    SharedPreferences prefsToken = await SharedPreferences.getInstance();
    //Return String

    String? tokenValue = prefsToken.getString('token');

    return tokenValue;
  }

  @override
  void initState() {
    super.initState();
    getStringToken();
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
        title: const Text(
          'Enquests et les Analyses',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // body: SingleChildScrollView(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  getStringToken().then((dynamic value) {
                    String valToken = value.toString();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnquetesListe()));
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Enquete point focal",
                  style: TextStyle(fontSize: 10), textAlign: TextAlign.justify)
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              // Text("Analyse RES", style: TextStyle(fontSize: 10), textAlign: TextAlign.right),
              const Text("Analyse risques environnementaux et sociaux",
                  style: TextStyle(fontSize: 10), textAlign: TextAlign.right),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Singlefilepicker()));
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Analyse genre",
                  textAlign: TextAlign.justify, style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},

        label: const Text('suivant '),
        // icon: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
            onDateTimeChanged: (dateTime) => this.dateTime = dateTime),
        // ),
      );
}
