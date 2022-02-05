import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/provoder/add_room_provider.dart';
import 'package:hotelproject/provoder/customer_data_provider.dart';
import 'package:hotelproject/provoder/hotel_login_provider.dart';
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:hotelproject/provoder/open_provider.dart';
import 'package:hotelproject/ui/open.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


late SharedPreferences prefs;
GlobalKey<NavigatorState> globalKey= GlobalKey<NavigatorState>();
BuildContext myContext =globalKey.currentState!.context;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs =  await SharedPreferences.getInstance();



  runApp( MultiProvider(
    providers: [

      ChangeNotifierProvider(create: (context) => Mainprovider(),),
      ChangeNotifierProvider(create: (context) => OpenProvider(),),
      ChangeNotifierProvider(create: (context) => CustomerDataProvider(),),
      ChangeNotifierProvider(create: (context) => HotelLoginProvider(),),
      ChangeNotifierProvider(create: (context) => AddRoomProvider(),),

    ],


      child: MyApp()));
}
class MyApp extends StatelessWidget {


   MyApp({Key? key}) : super(key: key);
  late OpenProvider openProvider;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: () =>  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Yel"
        ),
        home:open() ,
        navigatorKey: globalKey,

      ),

    );
  }
}


