import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/models/room.dart';

class Roomdetials extends StatefulWidget {
  final Room rooms;
  const Roomdetials(this.rooms,  {Key? key}) : super(key: key);

  @override
  _RoomdetialsState createState() => _RoomdetialsState();
}

class _RoomdetialsState extends State<Roomdetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: [
          Container(
            width:340.w ,
            height:200.h ,

            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    child: ClipOval(
                      child:Image.network(widget.rooms.roomImage!),
                    ),
                    radius: 40.6.r,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(widget.allHotel.hotelName!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                // )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r),bottomLeft:Radius.circular(25.r) )
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
                    child: Text("Number of beds:${widget.rooms.bedNo!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Night price:${widget.rooms.nightPrice!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
