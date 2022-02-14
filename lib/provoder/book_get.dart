import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotelproject/models/booking.dart';

class BookGet extends GetxController {
  RxInt count=0.obs;
  RxString name="".obs;


  void increnmntCount()
  {
    count++;



  }
  void changeName( String name)
  {
    this.name.value=name;

  }


  late FirebaseApp app;
  late DatabaseReference base;
  late FirebaseDatabase database;
  RxList<Booking> allbooking = <Booking>[].obs;
late Query q;

  void customerBooking(String uid) async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("booking");
    q=base.orderByChild("uid").equalTo(uid);

    print(q.toString());
    q.onChildAdded.listen((event) {
      print(event.snapshot.key);
      Booking p = Booking.fromJson(event.snapshot.value);
      allbooking.value.add(p);
      allbooking.refresh();

    });
  }
  void addHotelBook(Booking booking) {
  //  allbooking = [...allbooking, booking];

  }
  void HotelBooking(String HotelKey) async {

    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("booking");
    q=base.orderByChild("HotelId").equalTo(HotelKey);
    q.onChildAdded.listen((event) {
      print(event.snapshot.key);
      Booking p = Booking.fromJson(event.snapshot.value);
      addHotelBook(p);
    });
  }
}