
import 'package:der/pages/enquetesAnalyses.pages.dart';
import 'package:der/pages/geolocalisation.pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controller/enquetesApi.controller.dart';
import '../pages/enquetesListe.pages.dart';
import '../pages/homeOffline.pages.dart';
import '../pages/parametrage.page.dart';
import '../pages/home.pages.dart';
import '../pages/projetsListe.page.dart';
class MonMenu extends StatelessWidget {
  final enqueteData= EnquetesController();
  String? valToken;

  String ?selectValue;
  String  ?secteurID;
  String ?dateEnquete;
  String ?referenceProj;
  dynamic actSemaine=[];
  dynamic containteValue=[];
  String ?titreProjet;
  String ?  prenomBen;
  String ?nomBen; String? secteurLibelle; String ? telBen;String  ? numCNIBen; String ? adresseBen;
  String ?selectedValueRgion; String ?selectedValueDepart; String ?selectedValueCommune;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children:  [
          const DrawerHeader (
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.brown,
                        Colors.brown
                      ]
                  )

              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/der4.png"),
                  backgroundColor: Colors.white,
                  radius: 80,
                ),
              )
          ),

          //backgroundImage: AssetImage("images/flutterlogo.png"),
          ListTile(
            title:const Text ("Home", style: TextStyle(fontSize: 20),),
            leading: const Icon(Icons.account_balance),
            trailing: const Icon(Icons.arrow_right,color: Colors.brown,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                //Navigator.pushNamed(context, '/Tournee()');
                  builder: (context)=> const HomePage( )));
            },
          ),
          const Divider(height: 2, color: Colors.black,),
          ListTile(
            title:const Text ("Mes enquetes", style: TextStyle(fontSize: 20),),
            leading: const Icon(Icons.announcement),
            trailing: const Icon(Icons.arrow_right,color: Colors.brown,),
            onTap: (){
              // Fluttertoast.showToast(
              //     msg: "aucune données disponible",
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.blue,
              //     textColor: Colors.black,
              //     fontSize: 16.0);
              // enqueteData.getStringToken().then((dynamic value) {
              //   valToken =value.toString();
              //   print("valToken");
              //   print(valToken);
              //   print("valToken");
              //
              //
              //
              // });
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> const Offline()));
            },
          ),
          const Divider(height: 2, color: Colors.black,),
          ListTile(
            title:const Text ("Liste des enquetes", style: TextStyle(fontSize: 20),),
            leading: const Icon(Icons.apps),
            trailing: const Icon(Icons.arrow_right,color: Colors.brown,),
            onTap: (){
              enqueteData.getStringToken().then((dynamic value) {
                valToken =value.toString();
                print("Liste des enquetes");
                // print(valToken);
                print("Liste des enquetes");
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> EnquetesListe(/*valToken: valToken.toString()*/)));


              });

            },
          ),
          const Divider(height: 2, color: Colors.black,),
          ListTile(
            title:const Text ("Projets", style: TextStyle(fontSize: 20),),
            leading: const Icon(Icons.ac_unit),
            trailing: const Icon(Icons.arrow_right,color: Colors.brown,),
            onTap: (){
              //  setState(() {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Projets()));


              //  });
              // Navigator.of(context).pop();

            },
          ),
          const Divider(height: 2, color: Colors.black,),
          ListTile(
            title:const Text ("Géolocalisation", style: TextStyle(fontSize: 20),),
            leading: const Icon(Icons.place),
            trailing: const Icon(Icons.arrow_right,color: Colors.brown,),
            onTap: (){
              //  setState(() {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Geolocalisation(secteurID: secteurID="",secteurLibelle: secteurLibelle="", dateEnquete: dateEnquete="",referenceProj: referenceProj=""
                          ,titreProjet: titreProjet="",prenomBen: prenomBen="",nomBen: nomBen="",telBen:telBen="",
                          numCNIBen:numCNIBen="", adresseBen:adresseBen="", selectedValueRgion:selectedValueRgion="", selectedValueDepart:selectedValueDepart="",
                          selectedValueCommune:selectedValueCommune="", selectValue:selectValue="",actSemaine: actSemaine=null, containteValue:containteValue=null, valOffline:"")));

            },
          ),
          const Divider(height: 2, color: Colors.black,),
          ListTile(
            title:const Text ("Parametrage", style: TextStyle(fontSize: 20),),
            leading: const Icon(Icons.build),
            trailing: const Icon(Icons.arrow_right,color: Colors.brown,),
            onTap: (){
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Projets()));


              //  });
              //  setState(() {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Parametrage()));




            },
          ),
          const Divider(height: 2, color: Colors.black,),
        ],
      ),
    );
  }
}

