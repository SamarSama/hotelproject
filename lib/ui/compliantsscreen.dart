import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/provoder/CompliantsProvider.dart';
import 'package:provider/provider.dart';

class CompliantsScreen extends StatefulWidget {
  const CompliantsScreen({Key? key}) : super(key: key);

  @override
  _CompliantsScreenState createState() => _CompliantsScreenState();
}

class _CompliantsScreenState extends State<CompliantsScreen> {
  late CompliantsProvider compliantsProvider;
  @override

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    compliantsProvider=Provider.of<CompliantsProvider>(context,listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Compliants"),
        backgroundColor: Colors.green.shade500,
      ),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 30.r),
              child: Center(child: Text("Add Compliant data",style: TextStyle(fontFamily: "Arial",fontSize: 40),))
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: TextField(
                style: TextStyle(
                    fontFamily: "Arial"

                ),
                controller:compliantsProvider.compliantscon,
                keyboardType: TextInputType.text,
                maxLines: 10,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  hintText: 'Enter Your Compliant',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Compliant',
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
            padding: const EdgeInsets.only(right: 40,left: 40),
            child: ElevatedButton.icon(
              style:  ElevatedButton.styleFrom(
                primary: Colors.green
              ),
                onPressed: (){
                compliantsProvider.addcompliants(compliantsProvider.compliantscon.text, FirebaseAuth.instance.currentUser!.uid, context);

                },
                icon: Icon(Icons.save),
                label: Text("save compliant")
            ),
          ),
        ],
      ),

    );
  }
}
