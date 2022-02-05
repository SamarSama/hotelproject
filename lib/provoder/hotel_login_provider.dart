
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelproject/cache_data/cache_data_imp_helper.dart';
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:hotelproject/ui/hotelareahome.dart';
import 'package:hotelproject/utils/data/data_helper.dart';

class HotelLoginProvider extends ChangeNotifier {
  late FirebaseDatabase database;
  late Mainprovider mainprovider;
  late DatabaseReference Hoteldata;
  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();
  late FirebaseApp app;
  Future<void> HotelLogin (String hotelId,co)async{
    app  =  await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    Hoteldata=database.reference().child("hotel");
    Query t=Hoteldata.orderByChild("HotelId").equalTo(hotelId);
    t.onValue.listen((event) {
      print(event.snapshot.value.toString());
      if(event.snapshot.value !=null){
        cacheDataImpHelper.setUserType(DataHelper.HOTEL_TYPE);
        cacheDataImpHelper.setHotelCode(hotelId);
        print(hotelId);
        Navigator.of(co).pushReplacement(MaterialPageRoute(builder: (context) => HotelAreaHome( text: hotelId,)));
      }else{
        print("not exist");
      }
    });

  }


}