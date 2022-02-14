import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelproject/models/services.dart';

class ServiceProvider extends ChangeNotifier{
  late FirebaseApp app;
  late FirebaseDatabase database;
  late DatabaseReference base;
  TextEditingController servicecon=TextEditingController();
  TextEditingController servicetypecon=TextEditingController();
  void addservice(String servicetext,String servicetypetext,String hotelId,cc)async{
    if(servicecon.text==""||servicetypecon.text==""){
      ScaffoldMessenger.of(cc)
          .showSnackBar(SnackBar(content: Text("Please Enter the data ")));
      return;

    }else
    {
      showDialog<void>(
        context: cc,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Loading....'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),

          );
        },
      );
      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base = database.reference().child("services").child(hotelId);

        String HotelId =hotelId;
        String servicce =servicetext.trim() ;
        String servicetypee = servicetypetext.trim();
      Services ss=Services(
            hotelIs: HotelId,
            service: servicce,
            servicetype: servicetypee,

          // rate: ratingEnd
        );
        base.push().set(ss.toJson()).whenComplete(() {


          this.servicetypecon.text="";
          this.servicecon.text="";

          Navigator.of(cc).pop();
          ScaffoldMessenger.of(cc)
              .showSnackBar(SnackBar(content: Text("success ")));

        });

    }
  }


}