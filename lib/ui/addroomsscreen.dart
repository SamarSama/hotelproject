import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelproject/helperClass/ImportantFun.dart';
import 'package:hotelproject/models/room.dart';
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
class addroomscreen extends StatefulWidget {
  final String text;
  const addroomscreen( {Key? key,required this.text}) : super(key: key);

  @override
  _addroomscreenState createState() => _addroomscreenState();
}

class _addroomscreenState extends State<addroomscreen> {
 late Mainprovider mainprovider;


  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference refStorage ;
  TextEditingController bednocon=TextEditingController();
  TextEditingController nightpricecon=TextEditingController();
  TextEditingController roomtypecon=TextEditingController();

  File ?imagge;
  ImportantFun importantFun=ImportantFun();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainprovider=Provider.of<Mainprovider>(context,listen: false);
    startRealTimeFirebase();
  }


  void startRealTimeFirebase()async {

 await  mainprovider.buildFiirebase("rooms");

    mainprovider.base.child(widget.text.toString());
    refStorage =  storage.ref('/samar_images').child("images");
  }
  Future Pickimage() async {
    try{
      final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)
      {
        return;
      }
      setState(() {
        this.imagge=File(image.path);
        print(imagge?.path);
      }

      );
    }on PlatformException catch(e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("failed ")));
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ِAdd Rooms"),
      ),
      body: Container(
        child: Container(
          color: Colors.blue.shade800,
          child: ListView(

            children: [

              Center(
                child:Text("ِAdd Room Data",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
                ,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: TextField(
                  controller: bednocon,
                    decoration: new InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      hintText: 'Enter Room bed No',
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'Room bed No',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      prefixIcon: const Icon(
                        Icons.ac_unit_outlined,
                        color: Colors.white,
                      ),
                      //prefixText: ' ',
                      //suffixText: 'USD',
                      //suffixStyle: const TextStyle(color: Colors.green)),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: TextField(
                  controller: nightpricecon,
                    decoration: new InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      hintText: 'Enter night price',
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'night price',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      prefixIcon: const Icon(
                        Icons.money,
                        color: Colors.white,
                      ),
                      //prefixText: ' ',
                      //suffixText: 'USD',
                      //suffixStyle: const TextStyle(color: Colors.green)),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: TextField(
                  controller: roomtypecon,
                    decoration: new InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      hintText: 'Enter Room type',
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'Room Type',
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      prefixIcon: const Icon(
                        Icons.eighteen_mp_rounded,
                        color: Colors.white,
                      ),
                      //prefixText: ' ',
                      //suffixText: 'USD',
                      //suffixStyle: const TextStyle(color: Colors.green)),
                    )),
              ),


              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child:ElevatedButton.icon(onPressed: () async{
                       await Pickimage();
                  }
                  ,
                    label: Text("pick image"),
                    icon:Icon(Icons.image) ,




                  )
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child:

                  Image.file(
                    imagge
                        ?? File("")
                    ,errorBuilder:(context, error, stackTrace) =>
                      Icon(Icons.supervised_user_circle),
                  )
                  ,

                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child:ElevatedButton(onPressed: () {
                    if(bednocon.text==""||roomtypecon.text==""||nightpricecon.text==""||imagge==null){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Please Enter the data ")));
                      return;

                    }else
                    {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text('Loading....'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),

                          );
                        },
                      );
                    refStorage.child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(imagge!).then((p0) async {
                      String imgUrl = await p0.ref.getDownloadURL();
                      String HotelId =widget.text.toString();
                      String bedno =bednocon.text.trim() ;
                      String nightprice = nightpricecon.text.trim();
                      String RoomId = mainprovider.base.push().key;
                      String roomtype =roomtypecon.text.trim() ;
                      Room rooms=Room(
                          bedNo: bedno,
                          nightPrice: nightprice,
                          roomType: roomtype,
                          roomId:RoomId,
                          hotelId: HotelId,
                          roomImage: imgUrl
                        // rate: ratingEnd
                      );
                      mainprovider.base.push().set(rooms.toJson()).whenComplete(() {
                        setState(() {
                          imagge=null;
                        });

                        bednocon.text="";
                        nightpricecon.text="";
                        roomtypecon.text="";
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("success ")));
                      });
                    });
                        }





                  },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text("Add Room",style: TextStyle(color: Colors.white),),
                  )


              ),
            ],
          ),
        ),),

    );
  }
}
