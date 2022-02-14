import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelproject/models/room.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hotelproject/provoder/main_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddRoomProvider extends ChangeNotifier{
  File ?imagge;
  TextEditingController bednocon=TextEditingController();
  TextEditingController roomnumbercon=TextEditingController();
  TextEditingController contentcon=TextEditingController();

  String text="NO";

  void changeWord(){
    text="yes";
    notifyListeners();
  }

  TextEditingController nightpricecon=TextEditingController();
  TextEditingController roomtypecon=TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference refStorage ;
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
 Future<void>addrooms(String bednocon,String roomtypecon,String nightpricecon,imagge,cc,String text ,String roomno,String roomcontient)async{

    if(bednocon==""||roomtypecon==""||nightpricecon==""||roomno==""||roomcontient==""||imagge==null){
      ScaffoldMessenger.of(cc)
          .showSnackBar(SnackBar(content: Text("Please Enter the data ")));
      return;

    }else
    {
      this.imagge=imagge;
      showDialog<void>(
        context: cc,
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
      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base = database.reference().child("rooms").child(text);
      refStorage =  storage.ref('/samar_images').child("images");
      refStorage.child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(imagge!).then((p0) async {
        String imgUrl = await p0.ref.getDownloadURL();
        String HotelId =text;
        String bedno =bednocon.trim() ;
        String nightprice = nightpricecon.trim();
        String RoomId = base.push().key;
        String roomtype =roomtypecon.trim() ;
        String roomnum=roomno;
        String roomcontientt=roomcontient;
        Room rooms=Room(
            bedNo: bedno,
            nightPrice: nightprice,
            roomType: roomtype,
            roomId:RoomId,
            hotelId: HotelId,
            roomImage: imgUrl,
          roomnumber: roomnum,
          content: roomcontientt
          // rate: ratingEnd
        );
        base.push().set(rooms.toJson()).whenComplete(() {


          this.bednocon.text="";
            this.nightpricecon.text="";
            this.roomtypecon.text="";
            this.roomnumbercon.text="";
            this.contentcon.text="";
            this.imagge=null;
          Navigator.of(cc).pop();
          ScaffoldMessenger.of(cc)
              .showSnackBar(SnackBar(content: Text("success ")));
            notifyListeners(

            );
        });
      });
    }

  }
  Future Pickimage() async {

      final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)
      {
        return;
      }

     this.imagge=File(image.path);
      notifyListeners();



  }

}