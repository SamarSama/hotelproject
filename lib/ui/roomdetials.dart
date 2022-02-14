import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/models/room.dart';
import 'package:hotelproject/ui/bookingscreen.dart';

class Roomdetials extends StatefulWidget {
  final Room rooms;
  final String roomKey;
  const Roomdetials(this.rooms,this.roomKey,  {Key? key}) : super(key: key);

  @override
  _RoomdetialsState createState() => _RoomdetialsState();
}

class _RoomdetialsState extends State<Roomdetials> {
  late FirebaseApp app;
  late DatabaseReference base;
  late FirebaseDatabase database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();


  }
  void init()async{
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("rooms");

  }

  @override
  Widget build(BuildContext context) {
    print(widget.roomKey);
    return Scaffold(
      appBar: AppBar(
        title: Text("Room data"),
        backgroundColor: Colors.green.shade500,
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
                //  child: Image.network(widget.rooms.roomImage!),
                 child:Container(
                   width:340.w ,
                   height:180.h ,
                   decoration: BoxDecoration(
                     shape: BoxShape.rectangle,
                     borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                     image: DecorationImage(
                       image: NetworkImage( widget.rooms.roomImage!
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
                color: Colors.green,
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
                    child: Text("Room Type:${widget.rooms.roomType!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Number of beds:${widget.rooms.bedNo!} bed",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Night price:${widget.rooms.nightPrice!} E",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Room Content:${widget.rooms.content!}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Room code:${widget.roomKey}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton.icon(
                        onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingScreen(widget.rooms)));
                        },
                        icon: Icon(Icons.account_circle_rounded),
                        label: Text("Book Now")
                    ),
                  ),



                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   showDialog<void>(
      //       context: context,
      //       barrierDismissible: false,
      //       // false = user must tap button, true = tap outside dialog
      //       builder: (BuildContext dialogContext) {
      //         return AlertDialog(
      //           title: Text('warring'),
      //           content: Text('are you sure to delte tis room'),
      //           actions: <Widget>[
      //             TextButton(
      //               child: Text('No'),
      //               onPressed: () {
      //                 Navigator.of(dialogContext).pop(); // Dismiss alert dialog
      //               },
      //             ),
      //             TextButton(
      //               child: Text('yes'),
      //               onPressed: () {
      //                 Navigator.of(dialogContext).pop();
      //                 base.child(widget.rooms.hotelId!)
      //                 .child(widget.roomKey)
      //                 .remove().whenComplete(() {
      //                   Navigator.of(context).pop();
      //                 });
      //                 // Dismiss alert dialog
      //                // widget.rooms.
      //               },
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },child: Icon(Icons.remove_circle),),
    );
  }
}
