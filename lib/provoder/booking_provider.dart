import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelproject/models/booking.dart';
import 'package:hotelproject/ui/customerdata.dart';

class BookingProvider extends ChangeNotifier{
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  TextEditingController datecon=TextEditingController();
  TextEditingController daysnocon=TextEditingController();
  TextEditingController visanocon=TextEditingController();
  Future<void> addbooking(String uid, String hotelId,String roomId,String bookingdata,dynamic noOfDays,String visano,cc) async{
    if(datecon.text==""||daysnocon.text==""||visanocon.text==""){
      ScaffoldMessenger.of(cc)
          .showSnackBar(SnackBar(content: Text("Please Enter the data ")));
      return;

    }else
    {

      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base = database.reference().child("booking");
      String uidd =uid;
      String hotelid =hotelId.trim();
      String roomid = roomId.trim();
      String bookingdataa =bookingdata.trim();
      dynamic noOfDayss =noOfDays;
      String visanoo=visano.trim();
      String dateofprocess=DateTime.now().toString();
      Booking book=Booking(
        uid: uidd,
        hotelId:  hotelid,
        roomId: roomid,
        bookingdata :bookingdataa,
        noOfDays: noOfDayss,
        visano: visanoo,
        dateofprocess: dateofprocess,
        // rate: ratingEnd
      );
      base.push().set(book.toJson()).whenComplete(() {
        Navigator.of(cc).push(MaterialPageRoute(builder: (context)=>CustomerData()));

      });

    }
  }

}

