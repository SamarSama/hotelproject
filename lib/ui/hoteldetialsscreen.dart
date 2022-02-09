import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/models/hotel1.dart';
import 'package:hotelproject/models/rate_model.dart';
import 'package:hotelproject/models/room.dart';
import 'package:hotelproject/provoder/hotel_detials_provider.dart';
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:hotelproject/ui/roomdetials.dart';
import 'package:provider/provider.dart';

class HotelDetialsScreen extends StatefulWidget {
  final Hotel1 allHotel;


  const HotelDetialsScreen(this.allHotel, {Key? key}) : super(key: key);

  @override
  _HotelDetialsScreenState createState() => _HotelDetialsScreenState();
}

class _HotelDetialsScreenState extends State<HotelDetialsScreen> {
List <RateModel> rate=[];

  late HotelDetialsProvider hotelDetialsProvider;
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base,base1;
  late Query q;
  late Room rooms;
List<Room> allrooms = [];
late RateModel rateModel;
late Mainprovider mainprovider;

  void CalculateHotelRate()async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base1 = database.reference().child("rating");
    q=base1.orderByChild("HotelId").equalTo(widget.allHotel.hotelId.toString());
    base1.onValue.listen((event) {
      print(event.snapshot.value.toString());
      rateModel=RateModel.fromJson(event.snapshot.value);
      print("7777777");
      print(rateModel?.rate);
      setState(() {
      });
    });

  }
  void initState() {
    // TODO: implement initState
    super.initState();

    // UploadUserData();
  }
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    hotelDetialsProvider=Provider.of<HotelDetialsProvider>(context,listen: false);
    hotelDetialsProvider.startRealTimeFirebase(widget.allHotel.hotelId.toString());
    CalculateHotelRate();
    hotelDetialsProvider.images=[];
  }
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: DefaultTabController(
    length: 3,
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text("Hotel Government:${widget.allHotel.hotelGovernment!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Adress:${widget.allHotel.hotelAdress!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Query no:${widget.allHotel.hotelQueryPhone!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Hotel Query no:${widget.allHotel.hotelStarsNo!}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Give rate:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"Arial"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child:
        RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 3,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.yellowAccent,
          ),
          onRatingUpdate: (rating) async{
            app = await Firebase.initializeApp();
            database = FirebaseDatabase(app: app);
            base = database.reference().child("rating").child(widget.allHotel.hotelId.toString()).child(FirebaseAuth.instance.currentUser!.uid!);
            double rate =rating ;
            RateModel ratte=RateModel(
                rate: rate,

              // rate: ratingEnd
            );
            base.set(ratte.toJson()).whenComplete(() {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("success ")));


            });

          },
        )
                  ),


                ],
              ),
            ),
          ),
        ],
      ),

      Selector<HotelDetialsProvider,List<Room>>(
        selector: (p0, p1) {
          return p1.images;
        },
    builder: (context, Value, child) {
          if(Value==[]){
            return Container(
              child: Center(
                child: Text("the Hotel still not puplish the room data",style: TextStyle(fontSize: 40),),
              ),
            ) ;
          }else{
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CarouselSlider(
                      items: [
                        ...Value
                            .map(
                              (e) => InkWell(
                            onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Roomdetials(hotelDetialsProvider.rooms)));
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
                      ...Value.map(
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
                                color: Value[_index]==e
                                    ? Colors.red
                                    : Colors.transparent),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );


          }
    }

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

