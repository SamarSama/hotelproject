import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/cache_data/cache_data_imp_helper.dart';
import 'package:hotelproject/helperClass/login.dart';
import 'package:hotelproject/models/hotel1.dart';
import 'package:hotelproject/models/profile_model_respose.dart';
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:hotelproject/utils/data/data_helper.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'addroomsscreen.dart';
import 'addservicescreen.dart';
import 'open.dart';

class HotelAreaHome extends StatefulWidget {
  final String text;

  const HotelAreaHome({Key? key,required this.text}): super(key: key);

  @override
  _HotelAreaHomeState createState() => _HotelAreaHomeState();
}

class _HotelAreaHomeState extends State<HotelAreaHome> {
  late FirebaseDatabase database;
  late Mainprovider mainprovider;
  late DatabaseReference base;
  late FirebaseApp app;
  Hotel1? ProfileModel;
  String?key;

  Hotel1 ?hoteldata;
  void ReturnHotelData()async {
    app  =  await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("hotel")
        .child(widget.text);

    base.onValue.listen((event) {

      print(event.snapshot.value.toString());



      setState(() {

        ProfileModel =Hotel1.fromJson(event.snapshot.value);
        print(ProfileModel!.hotelAdress!);



      });

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ReturnHotelData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Data"),
      ),
      body:  ListView(
        children: [
          Container(
            width:340.w ,
            height:200.h ,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child:Container(
                      width:340.w ,
                      height:180.h ,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                        image: DecorationImage(
                          image: NetworkImage(
                              ProfileModel!.hotelImage!
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )

                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(widget.allHotel.hotelName!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                // )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r),bottomLeft:Radius.circular(20.r) )
            ),


          ),
          Card(
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Serial no:${widget.text}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Name:${ProfileModel?.hotelName} bed",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Star no:${ProfileModel?.hotelStarsNo} Star",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Rate:${ProfileModel?.rate}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Query Phone:${ProfileModel?.hotelQueryPhone}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      drawer:Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text('Drawer Header',style: TextStyle(fontSize: 20,color: Colors.white),)),
            ),
            ListTile(
              title: const Text('Add Hotel Services'),
              trailing:Icon(Icons.add) ,

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddServiceScreen( hotelId: widget.text,)));

              },
            ),
            Divider(height: 1,thickness: 1,),

            ListTile(
              title: const Text('Add Hotel Rooms'),
              trailing:Icon(Icons.save) ,

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>addroomscreen( text: widget.text,)));

              },
            ),
            Divider(height: 1,thickness: 1,),

            ListTile(
              title: const Text('Users Booking'),
              trailing:Icon(Icons.book) ,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(height: 1,thickness: 1,),

            ListTile(
              title: const Text('Logout'),
              trailing:Icon(Icons.logout) ,

              onTap: () {
                cacheDataImpHelper.setHotelCode("");
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => open(),));
              },
              //"-Mt56By1k7uyBUh-dvvI"
            ),
          ],
        ),
      ) ,
    );
  }
}

