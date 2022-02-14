import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/models/booking.dart';
import 'package:hotelproject/models/room.dart';
import 'package:hotelproject/provoder/booking_provider.dart';
import 'package:provider/provider.dart';

import 'customerdata.dart';

class BookingScreen extends StatefulWidget {
  final Room rooms;
  const BookingScreen(this.rooms, {Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late BookingProvider bookingProvider;

  @override

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bookingProvider=Provider.of<BookingProvider>(context,listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking"),
        backgroundColor: Colors.green.shade500,

      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 140.r),
        child: Container(
          child: ListView(
children: [
  Padding(
    padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 10.r),
    child: Center(child: Text("Add Booking data",style: TextStyle(fontFamily: "Arial",fontSize: 40),))
  ),
  Padding(
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    child: TextField(
        style: TextStyle(
            fontFamily: "Arial"

        ),
            controller: bookingProvider.daysnocon,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black),
              ),

              hintText: 'Enter Number of days of stay',
              hintStyle: TextStyle(color: Colors.black),
              labelText: 'Number of days of stay',
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "Yel"

              ),
              prefixIcon: const Icon(
                Icons.ten_k,
                color: Colors.black,
              ),
              //prefixText: ' ',
              //suffixText: 'USD',
              //suffixStyle: const TextStyle(color: Colors.green)),
            )),
  ),
  Padding(
    padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 10.r),
    child: TextField(
      style: TextStyle(
          fontFamily: "Arial"

      ),
            controller:bookingProvider.datecon,
            keyboardType: TextInputType.datetime,
            decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black),
              ),

              hintText: 'Enter Booking date',
              hintStyle: TextStyle(color: Colors.black),
              labelText: 'Booking date',
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "Yel"

              ),
              prefixIcon: const Icon(
                Icons.ac_unit_outlined,
                color: Colors.black
                ,
              ),
              //prefixText: ' ',
              //suffixText: 'USD',
              //suffixStyle: const TextStyle(color: Colors.green)),
            )),
  ),
  Padding(
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    child: TextField(
        style: TextStyle(
            fontFamily: "Arial"

        ),
            controller:bookingProvider.visanocon,
            keyboardType: TextInputType.number,
            maxLength: 3,
            decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black),
              ),

              hintText: 'Enter visa no',
              hintStyle: TextStyle(color: Colors.black),
              labelText: 'Visa no',
              labelStyle: TextStyle(
                  color: Colors.black,
                fontFamily: "Yel"

              ),
              prefixIcon: const Icon(
                Icons.ac_unit_outlined,
                color: Colors.black,
              ),
              //prefixText: ' ',
              //suffixText: 'USD',
              //suffixStyle: const TextStyle(color: Colors.green)),
            )),
  ),
  Padding(
    padding:  EdgeInsets.symmetric(vertical: 10.r,horizontal: 40.r),
    child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
primary: Colors.green
      ),
        onPressed: () async{
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('warring'),
                content: Text('are you sure to sure the booking'),
                actions: <Widget>[
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                  TextButton(
                    child: Text('yes'),
                    onPressed: () {
                      bookingProvider.addbooking(FirebaseAuth.instance.currentUser!.uid, widget.rooms.hotelId!, widget.rooms.roomId!, bookingProvider.datecon.text,bookingProvider.daysnocon.text , bookingProvider.visanocon.text,context);

                      // Dismiss alert dialog
                      // widget.rooms.
                    },
                  ),
                ],
              );
            },
          );

        },
        icon: Icon(Icons.account_circle_rounded),
        label: Text("Book Now")
    ),
  ),
],

          ),
        ),
      ),
    );
  }
}
