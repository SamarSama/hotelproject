
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Mainprovider extends ChangeNotifier{

  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;

  Future<void> buildFiirebase(String name)
  async{
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child(name);
  }





}