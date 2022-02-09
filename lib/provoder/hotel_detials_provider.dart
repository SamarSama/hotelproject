import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotelproject/models/room.dart';

class HotelDetialsProvider extends ChangeNotifier{

  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  late Room rooms;
  List<Room> images = [];
  void startRealTimeFirebase(String hotelId)async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("rooms").child(hotelId);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      rooms = Room.fromJson(event.snapshot.value);
      images.add(rooms);
      print(rooms.roomImage);
      notifyListeners();

    });

  }
}