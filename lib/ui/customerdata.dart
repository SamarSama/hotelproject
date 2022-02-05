import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/Models/Drawermodel.dart';
import 'package:hotelproject/cache_data/cache_data_imp_helper.dart';
import 'package:hotelproject/main.dart';
import 'package:hotelproject/models/profile_model2.dart';
import 'package:hotelproject/models/hotel1.dart';
import 'package:hotelproject/models/profile_model_respose.dart';
import 'package:hotelproject/provoder/customer_data_provider.dart';
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:hotelproject/ui/open.dart';
import 'package:hotelproject/ui/userdata_screen.dart';
import 'package:provider/provider.dart';

import 'hoteldetialsscreen.dart';


class CustomerData extends StatefulWidget {

  @override
  _CustomerDataState createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {

  late Mainprovider mainprovider;
  late CustomerDataProvider customerDataProvider;

  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();
  var currentPage = 0;
   ProfileModelRespose? ProfileModel;
   late DatabaseReference userData;
  late final uid;

  List<Hotel1> searchList = [];


  void startRealTimeFirebase()async {
await  mainprovider.buildFiirebase("hotel");

    //// User user = await auth.currentUser!;
    // uid = user.uid;
    // final uemail = user.email;

    mainprovider.base.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      Hotel1 p=Hotel1.fromJson(event.snapshot.value);
      customerDataProvider.addNewHotel(p);
      searchList.add(p);
      // setState(() {
      // });
    });
    userData=mainprovider.database.reference().child("profiles").child(FirebaseAuth.instance.currentUser!.uid);
    userData.onValue.listen((event) {
     print(event.snapshot.value.toString());
     ProfileModel=ProfileModelRespose.fromJson(event.snapshot.value);
     print(ProfileModel?.name);

     setState(() {
      });
   })
       .onDone(() {
   });

  }


  // void UploadUserData()async {
  //   app  =  await Firebase.initializeApp();
  //   database = FirebaseDatabase(app: app);
  //   userData=database.reference().child("profiles").child(FirebaseAuth.instance.currentUser!.uid);
  //   userData.onChildAdded.listen((event) {
  //     print(event.snapshot.value.toString());
  //     ProfileModel=ProfileModelRespose.fromJson(event.snapshot.value);
  //     print(ProfileModel?.name);
  //
  //     setState(() {
  //     });
  //   }).onDone(() {
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainprovider = Provider.of<Mainprovider>(myContext,listen: false);
    customerDataProvider = Provider.of<CustomerDataProvider>(myContext,listen: false);
    startRealTimeFirebase();
   // UploadUserData();
  }
  List drawerMenu1=[
    Drawermodel(Icons.dashboard, "User Profile",0),
    Drawermodel(Icons.contacts, "Hotels",1),
    Drawermodel(Icons.notes, "Booking",2),
    Drawermodel(Icons.event, "Add Compliaments",3),
  ];
  List drawerMenu2=[
    Drawermodel(Icons.settings, "Settings",4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Home Page"),
        backgroundColor: Colors.green,//pages[0]
      ),
      body: ListView(
        
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: ListView(

              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 70),
                    child: Center(
                      child: Text(
                        "Aro For Hotel",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 70,
                      horizontal: MediaQuery.of(context).size.height / 70),
                  child: Text(
                    "Find Your Hotel",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 70,
                      horizontal: MediaQuery.of(context).size.height / 70),
                  child: TextField(
                      onChanged: (char) {
                        if (char.isEmpty) {

                            customerDataProvider.setAllHotels(searchList);


                        }else
                        {
                          customerDataProvider.allHotels=[];
                          for(Hotel1 model in searchList  )
                          {
                            if (model.hotelGovernment!.contains(char)||
                                model.hotelName!.contains(char)
                                ||
                                model.hotelAdress!.contains(char)
                            ) {
                              customerDataProvider.addNewHotel(model);
                            }
                          }


                        }



                      },
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),

                        hintText: 'Enter Search Data',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Enter Search Data',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        //prefixText: ' ',
                        //suffixText: 'USD',
                        //suffixStyle: const TextStyle(color: Colors.green)),
                      )),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Hotels",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Selector<CustomerDataProvider,List<Hotel1>>(
          selector: (p0, p1) {
            return p1.allHotels;
          },
          builder: (context, hotles, child) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                childAspectRatio:1 /1.5 ,// to disable GridView's scrolling

              ),
              itemCount: hotles.length,
              padding: EdgeInsets.all(2.0.r),
              itemBuilder: (BuildContext context, int index) {
                return     GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HotelDetialsScreen(hotles[(hotles.length - 1) - index]),
                    ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: Container(
                      width: 130.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                        image: DecorationImage(
                          image: NetworkImage( hotles[(hotles.length - 1) - index]
                              .hotelImage!,),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child:  Padding(
                        padding: EdgeInsets.all(0.r),
                        child: Container(

                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.black,
                                  const Color(0x19000000),
                                ],
                                begin: const FractionalOffset(0.0, 1.0),
                                end: const FractionalOffset(0.0, 0.0),
                                tileMode: TileMode.clamp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text(
                                    " ${hotles[(hotles.length - 1) - index].hotelName}",
                                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500,color: Colors.white),
                                  ),
                                ),
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
                              ],

                            ),
                          ),

                        ),
                      ), /* add child content here */
                    ),
                  ),
                );

              },
            );
          },

        )



          ),
          // ...... other list children.
        ],
      ), //child safearea => widget? ,


      //drawerScrimColor: Colors.black,
      onDrawerChanged: (state){
        //ternary operator
       // state? showToast("opened",duration: Duration(seconds: 5),context: context):showToast("closed",duration: Duration(seconds: 5),context: context);
      },
      drawer: SafeArea(
        child: Drawer(
          elevation: 2.3,
          child: ListView(
            // header
            children: [
              DrawerHeader(
                //container with alignment.center
                decoration: BoxDecoration(color: Colors.green),
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child:Image.network(ProfileModel?.imgUrl ?? "")

                      ),
                      radius: 50,

                    ),
                    Text(
                      ProfileModel?.name??"",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ), //he
              ...drawerMenu1.map((e) => fmenu1(e)),
              Divider(height: 1,thickness: 0,),
              ...drawerMenu2.map((e) => fmenu1(e)),
              Divider(height: 1,thickness: 0,),
              /// logout
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
                dense: true,
                onTap: () async{
               await FirebaseAuth.instance.signOut();
               cacheDataImpHelper.setEmail("");
               customerDataProvider.allHotels=[];
               cacheDataImpHelper.setPassword("");
               cacheDataImpHelper.setUserType("");
               Navigator.of(context)
               .pushReplacement(MaterialPageRoute(builder: (context) => open(),));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget fmenu1(Drawermodel item){
    return  ListTile(

      leading: Icon(item.drawericon),
      title: Text(item.drawertext),
      subtitle: Text("Open Dashboard"),
      contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
      dense: true,

      onTap: (){
        Navigator.of(context).pop();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.drawertext)));

        switch(item.index){
          case 0:
           // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.text)));
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>userdata_screen()));
            break;
          case 1:
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.text)));
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomerData()));
            break;
        }
      },
    );
  }

}

