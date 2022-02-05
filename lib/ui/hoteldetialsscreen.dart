import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/models/hotel1.dart';
import 'package:hotelproject/models/room.dart';

class HotelDetialsScreen extends StatefulWidget {
  final Hotel1 allHotel;


  const HotelDetialsScreen(this.allHotel, {Key? key}) : super(key: key);

  @override
  _HotelDetialsScreenState createState() => _HotelDetialsScreenState();
}

class _HotelDetialsScreenState extends State<HotelDetialsScreen> {
  List<Room> images = [

  ];
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  late Room rooms;
  void startRealTimeFirebase()async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("rooms").child(widget.allHotel.hotelId.toString());
    base.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      rooms = Room.fromJson(event.snapshot.value);
      images.add(rooms);

      print("images of fire");
      print(rooms.roomImage);
      print("///////////////////");

      setState(() {});
    });

  }
  void initState() {
    // TODO: implement initState
    super.initState();
   print("55555555");
    startRealTimeFirebase();
    // UploadUserData();
  }
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: DefaultTabController(
    length: 4,
    child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey.shade100,
    bottom: const TabBar(
    tabs: [
    Tab(icon: Icon(Icons.hotel,color: Colors.green,),child: Text(
      'Hotel Data',style:TextStyle(color: Colors.green)
    ),),
    Tab(icon: Icon(Icons.airline_seat_legroom_extra_rounded,color: Colors.green,),child: Text("Roomsٌٌ",style:TextStyle(color: Colors.green) ,),),
    Tab(icon: Icon(Icons.auto_stories_rounded,color: Colors.green,),child: Text("Services",style:TextStyle(color: Colors.green)),),
      Tab(icon: Icon(Icons.star,color: Colors.green,),child: Text("Give Rate",style:TextStyle(color: Colors.green)),),

    ],
    ),
    title: const Text('Hotel Detials',style:TextStyle(color: Colors.green)),

    ),
    body:  TabBarView(

    children: [
      ListView(
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
                        child:Image.network(widget.allHotel.hotelImage!),
                    ),
                    radius: 40.6.r,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.allHotel.hotelName!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r),bottomLeft:Radius.circular(25.r) )
            ),


          ),
          Card(
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text("Hotel Government:${widget.allHotel.hotelGovernment!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Hotel Adress:${widget.allHotel.hotelAdress!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Hotel Query no:${widget.allHotel.hotelQueryPhone!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Hotel Query no:${widget.allHotel.hotelStarsNo!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child:
        RatingBar.builder(
          initialRating: 2,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 3,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.yellowAccent,
          ),
          onRatingUpdate: (rating) {



          },
        )
                ),


              ],
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
                      margin: EdgeInsets.only(bottom: 20),
              child: CarouselSlider(
                items: [
                  ...images
                      .map(
                                (e) => InkWell(
                                  onTap: () {
                                    print("sssssssssssssss");
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Image.network(
                                      e.roomImage!,
                                      width: 300.w,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                        ],
                options: CarouselOptions(
                    autoPlay: true,
                            height: 400.h,
                            autoPlayInterval: Duration(seconds: 4),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.50,
                            enlargeCenterPage: true,
                            onPageChanged: (index, _) {
                              setState(() {
                                _index = index;
                              });
                            }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...images.map(
                      (e) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: images[_index]==e
                              ? Colors.red
                              : Colors.transparent),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      Center(
        child: Text("It's sunny here"),
      ),
      Center(
        child: Text("It's sunny here"),
      ),
    ],
    ),
    ),
    ),
    );
  }
  }

