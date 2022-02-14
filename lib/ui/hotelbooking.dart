import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/models/booking.dart';
import 'package:hotelproject/provoder/book_provider.dart';
import 'package:provider/provider.dart';

class HotelBooking extends StatefulWidget {
  const HotelBooking({Key? key}) : super(key: key);

  @override
  _HotelBookingState createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  late BookProvider bookProvider;
  @override
  void initState() async{
    super.initState();


  }
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bookProvider=Provider.of<BookProvider>(context,listen: false);
    bookProvider.CustomerBooking(FirebaseAuth.instance.currentUser!.uid);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Data"),
      ),
      body: Selector<BookProvider,List<Booking>>(
        selector: (p0, p1) {
          return p1.allbooking;
        },
        builder: (context, booking, child) {
          return ListView.builder(
            itemCount: booking.length,
              itemBuilder: (_ ,int index){
                return Card(
                  color: Colors.green,
                  child: Container(
                    width: 500.w,
                    height: 100.h,
                    child: Row(
                      children: [
                        Text(booking[index].bookingdata!)

                      ],
                    ),
                  ),

                );
              }
          );
        },
      ),

    );
  }
}
