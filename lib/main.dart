
import 'package:der/pages/PdfViewerPage.pages.dart';
import 'package:der/pages/activiteSemeine.pages.dart';
import 'package:der/pages/contact.pages.dart';
import 'package:der/pages/contraintes.pages.dart';
import 'package:der/pages/enquetesAnalyses.pages.dart';
import 'package:der/pages/parametrage.page.dart';
import 'package:der/pages/geolocalisation.pages.dart';
import 'package:der/pages/home.pages.dart';
import 'package:der/pages/login.page.dart';
import 'package:der/pages/nouvelleEnquete.pages.dart';
import 'package:flutter/material.dart';

import 'controller/enquetesApi.controller.dart';


void main() {
  runApp( ExpenseApp());
}


class ExpenseApp extends StatelessWidget {
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
  ExpenseApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => Login(),  //ImageUploadScreen(),//Geolocalisation(),// MaPage(),//Login(),
        "/contact": (context) => Contacts(),
        "/enquetesAnalyses": (context) => EnquetesAnalyses(),
      },
      theme: ThemeData(
          primarySwatch: Colors.brown
      ),
      // title: MaPage(), /*"appTitle",*/
      // home: MaPage(),
      initialRoute:  "/home",
    );
  }
}
/*class MaPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       drawer: MonMenu(),
       appBar: AppBar(title: Text("SupDeco"),),
       body: Center(
        child: Text("Bienvenue à SupDeco ", style: TextStyle(color: Colors.black, fontSize: 20),),
       ),
     );
   }
 }*/
/*
 class MonMenu extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Drawer(
       child: ListView(
         children:  [
           DrawerHeader(
             decoration: BoxDecoration(
               gradient: LinearGradient(colors: [
                 Colors.yellow,
                 Colors.white
               ])
             ),
               child: Center(
                 child: CircleAvatar(
             backgroundImage: AssetImage("images/flutterlogo.png"),
                   radius: 50,
           ),
               )),
           ListTile(
             title:Text ("Home", style: TextStyle(fontSize: 20),),
             leading: Icon(Icons.account_balance),
             trailing: Icon(Icons.arrow_right,color: Colors.yellow,),
             onTap: (){},
           ),
           Divider(height: 2, color: Colors.black,),
           ListTile(
             title:Text ("Contacts", style: TextStyle(fontSize: 20),),
             leading: Icon(Icons.account_balance),
             trailing: Icon(Icons.arrow_right,color: Colors.yellow,),
             onTap: (){
               print("3333333333333");
             },
           ),
           Divider(height: 2, color: Colors.black,),
         ],
       ),
     );
   }
 }

 */



