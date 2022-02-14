import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotelproject/models/booking.dart';

class BookProvider extends ChangeNotifier {
  late FirebaseApp app;
  late DatabaseReference base;
  late FirebaseDatabase database;
  List<Booking> allbooking = [];
late Query q;

  void CustomerBooking(String uid) async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("booking");
    q=base.orderByChild("uid").equalTo(uid);
    q.onChildAdded.listen((event) {
      print(event.snapshot.key);
      Booking p = Booking.fromJson(event.snapshot.value);
      allbooking.add(p);
      notifyListeners();
    });
  }
  void addHotelBook(Booking booking) {
    allbooking = [...allbooking, booking];
    notifyListeners();
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