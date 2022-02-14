
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotelproject/models/hotel1.dart';

class CustomerDataProvider extends ChangeNotifier{
  List<Hotel1> allHotels = [];
  List<Hotel1> searchList = [];

  List<String> keys = [];

  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  void setAllHotels( List<Hotel1> allHotels)
  {
    this.allHotels=allHotels;
    notifyListeners();
  }

  void addNewHotel(Hotel1 hotel1)
  {
    allHotels=[...allHotels,hotel1];
    notifyListeners();
  }
  void startRealTimeFirebase()async {
     app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hotel");
  base.onChildAdded.listen((event) {
      print(event.snapshot.key);
      keys.add(event.snapshot.key!);
      Hotel1 p=Hotel1.fromJson(event.snapshot.value);
      addNewHotel(p);
      searchList.add(p);
      // setState(() {
      // });
    });

  }

}