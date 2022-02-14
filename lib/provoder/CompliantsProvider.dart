import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelproject/models/compliants.dart';
import 'package:hotelproject/ui/customerdata.dart';

class CompliantsProvider extends ChangeNotifier{
  late FirebaseApp app;
  late DatabaseReference base;
  late FirebaseDatabase database;
  TextEditingController compliantscon=TextEditingController();

  void addcompliants (String compliant,String uid,cc)async{
    if(compliantscon.text==""){
      ScaffoldMessenger.of(cc)
          .showSnackBar(SnackBar(content: Text("Please Enter the data ")));
      return;

    }else
    {
      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base = database.reference().child("compliants");
      String uidd =uid;
      String compliant =compliantscon.text.trim();
      String respond = "no response";
      String compliantdate =DateTime.now().toString();
      Compliants com=Compliants(
        uid: uidd,
        compliant:  compliantscon.text,
        dateOfCompliant: compliantdate,
        compliantRespond :respond,
      );
      base.push().set(com.toJson()).whenComplete(() {
        Navigator.of(cc).push(MaterialPageRoute(builder: (context)=>CustomerData()));

      });
    }

  }

}