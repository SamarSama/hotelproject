import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelproject/cache_data/cache_data_imp_helper.dart';
import 'package:hotelproject/main.dart';
import 'package:hotelproject/ui/admin.dart';
import 'package:hotelproject/ui/customerdata.dart';
import 'package:hotelproject/ui/hotelareahome.dart';
import 'package:hotelproject/utils/data/data_helper.dart';

class OpenProvider extends ChangeNotifier{
  int i=0;
  int y=0;
  late FirebaseDatabase database;
  late DatabaseReference Hoteldata;
  late FirebaseApp app;
  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();


  void increaseI()
  {
    i++;
    notifyListeners();
  }

  void increaseY()
  {
    y++;
    notifyListeners();
  }


  void loginCache()async{

    String userType=cacheDataImpHelper.getUserType();
  //  print(userType);

    if (userType==DataHelper.ADMIN_TYPE) {


      Future.delayed(Duration(milliseconds: 200),(){
        Navigator.of(myContext).pushReplacement(
            MaterialPageRoute(builder: (cc) => admin()));
      });

    } else if (userType==DataHelper.HOTEL_TYPE){
      try {
        String Hotelcode=cacheDataImpHelper.getHotelCode();

        if (Hotelcode.isEmpty) {
          return;

        }
        else{
          app  =  await Firebase.initializeApp();
          database = FirebaseDatabase(app: app);
          Hoteldata=database.reference().child("hotel");
          Query t=Hoteldata.orderByChild("HotelId").equalTo(Hotelcode);
          t.onValue.listen((event) {
            cacheDataImpHelper.setUserType(DataHelper.HOTEL_TYPE);
            cacheDataImpHelper.setHotelCode(Hotelcode);
            print(Hotelcode);
            Navigator.of(myContext).pushReplacement(MaterialPageRoute(builder: (context) => HotelAreaHome(text: Hotelcode,)));
          });

        }
      } on FirebaseAuthException catch (e) {




      }

    }

    else if(userType==DataHelper.USER_TYPE)
    {
      try {
        String email=cacheDataImpHelper.getEmail();
        String password=cacheDataImpHelper.getPassword();
        if (email.isEmpty||password.isEmpty) {
          return;
        }
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        );




        Navigator.of(myContext).pushReplacement(MaterialPageRoute(builder: (context) => CustomerData()));
      } on FirebaseAuthException catch (e) {


      }
    }


  }
}