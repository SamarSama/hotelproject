
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotelproject/models/hotel1.dart';
import 'package:hotelproject/models/profile_model_respose.dart';

class CustomerDataProvider extends ChangeNotifier {
  List<Hotel1> allHotels = [];
  List<Hotel1> searchList = [];

  bool isLoading=true;

  List<String> keys = [];
  ProfileModelRespose? ProfileModel;
  late DatabaseReference userData;

  late FirebaseDatabase database;
  late FirebaseApp app;
  late DatabaseReference base;

  void setAllHotels(List<Hotel1> allHotels) {
    this.allHotels = allHotels;
    notifyListeners();
  }

  void addNewHotel(Hotel1 hotel1) {
    allHotels = [...allHotels, hotel1];
    notifyListeners();
  }
  void changeStateLoading( bool isLoading)
  {
    this.isLoading=isLoading;
    notifyListeners();
  }

  void startRealTimeFirebase() async {

    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hotel");
    base.onChildAdded.listen((event) {
      print(event.snapshot.key);
      keys.add(event.snapshot.key!);
      Hotel1 p = Hotel1.fromJson(event.snapshot.value);
      addNewHotel(p);
      searchList.add(p);

      userData = database.reference().child("profiles").child(
          FirebaseAuth.instance.currentUser!.uid);
      userData.onValue.listen((event) {
        print(event.snapshot.value.toString());
        this.ProfileModel = ProfileModelRespose.fromJson(event.snapshot.value);

        print("ssssssssssssssssssssss");
        print(ProfileModel?.name);
notifyListeners();
        changeStateLoading(false);
//
//      setState(() {
//       });
        // setState(() {
        // });
      });
    });
  }
}



