import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotelproject/models/booking.dart';
import 'package:hotelproject/provoder/book_get.dart';
import 'package:hotelproject/provoder/book_provider.dart';
import 'package:provider/provider.dart';

class HotelBooking extends StatefulWidget {
  const HotelBooking({Key? key}) : super(key: key);

  @override
  _HotelBookingState createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  late BookProvider bookProvider;

  BookGet bookGet=Get.put(BookGet());
  @override
  void initState() {
    super.initState();
    bookGet.customerBooking(FirebaseAuth.instance.currentUser!.uid);


  }
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // bookProvider=Provider.of<BookProvider>(context,listen: false);
    //
    // bookProvider.customerBooking(FirebaseAuth.instance.currentUser!.uid);
    // bookProvider.allbooking.clear();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Data"),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   bookGet.changeName("samar");
      // },),
      body:
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Center(child: Obx(
        //         (){
        //           return Text(bookGet.name.toString(),style: TextStyle(
        //               fontSize: 40
        //           ),);
        //         }
        //     ))
        //   ],
        // )
///provider
      // Selector<BookProvider,List<Booking>>(
      //   selector: (p0, p1) {
      //     return p1.allbooking;
      //   },
      //   builder: (context, booking, child) {
      //     return ListView.builder(
      //         itemCount: booking.length,
      //         itemBuilder: (_ ,int index){
      //           return Card(
      //             color: Colors.green,
      //             child: Container(
      //               width: 500.w,
      //               height: 100.h,
      //               child: Row(
      //                 children: [
      //                   Text(booking[index].bookingdata!),
      //
      //
      //                 ],
      //               ),
      //             ),
      //
      //           );
      //         }
      //     );
      //   },
      //   shouldRebuild:(previous, next) =>  true,
      // ),
/// get x
      Obx(
          (){
            print(bookGet.allbooking.value.length);
            return ListView.builder(
                itemCount: bookGet.allbooking.value.length,
                itemBuilder: (_ ,int index){
                  return Card(
                    color: Colors.green,
                    child: Container(
                      width: 500.w,
                      height: 100.h,
                      child: Row(
                        children: [
                          Text(bookGet.allbooking.value[index].bookingdata!),


                        ],
                      ),
                    ),

                  );
                }
            );
          }
      ),
    );
  }
}
