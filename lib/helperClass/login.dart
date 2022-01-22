
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hotelproject/cache_data/cache_data_imp_helper.dart';
import 'package:hotelproject/ui/customerdata.dart';
import 'package:hotelproject/utils/data/data_helper.dart';
CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();


class Logoin{
  void UserLogin(String email,String Password) async{
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: Password
    );
    cacheDataImpHelper.setUserType(DataHelper.USER_TYPE);
    cacheDataImpHelper.setEmail(email);
    cacheDataImpHelper.setPassword(Password);
  }

}