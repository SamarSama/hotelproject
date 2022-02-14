import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelproject/provoder/serviceprovider.dart';
import 'package:provider/provider.dart';

class AddServiceScreen extends StatefulWidget {
  final String hotelId;
  const AddServiceScreen({required this.hotelId,Key? key}) : super(key: key);

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  late ServiceProvider serviceProvider;
  @override

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    serviceProvider=Provider.of<ServiceProvider>(context,listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ِAdd Service"),
      ),
      body: Container(
        child: Container(
          color: Colors.blue.shade800,
          child: ListView(

            children: [

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child:Text("ِAdd Hotel Services",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.white),)
                  ,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 10.r),
                child: TextField(
                    style: TextStyle(
                        fontFamily: "Arial"
                    ),
                    controller: serviceProvider.servicetypecon,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      hintText: 'Enter Service Type',
                      hintStyle: TextStyle(color: Colors.white),
                      labelText: 'Service Type',
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
                padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 10.r),
                child: TextField(
                  style: TextStyle(
                    fontFamily: "Arial"
                  ),
                    controller: serviceProvider.servicecon,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                      hintText: 'Enter service',
                      hintStyle: TextStyle(
                          color: Colors.white

                      ),
                      labelText: 'service',
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
                  padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 10.r),
                  child:ElevatedButton(onPressed: () {
                  serviceProvider.addservice(serviceProvider.servicecon.text, serviceProvider.servicetypecon.text, widget.hotelId, context);


                  },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text("Add Service",style: TextStyle(color: Colors.white),),
                  )


              ),
            ],
          ),
        ),),
    );
  }
}
