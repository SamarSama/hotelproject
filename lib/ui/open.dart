import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelproject/main.dart';
import 'package:hotelproject/provoder/open_provider.dart';
import 'package:provider/provider.dart';

import 'adminanduserlogin.dart';
import 'hotel_Login.dart';

class open extends StatefulWidget {
  open({Key? key}) : super(key: key);

  @override
  State<open> createState() => _openState();


}

class _openState extends State<open> {
  late OpenProvider openProvider;


  @override
  void initState() {
    super.initState();
    openProvider = Provider.of<OpenProvider>(myContext, listen: false);
    openProvider.loginCache();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Padding(

        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3,right:  MediaQuery.of(context).size.width/3,),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Selector<OpenProvider, int>(
                selector: (p0, p1) {
                  return p1.i;
                },
                builder: (context, x_value, child) {
                  return Text(
                    x_value.toString(),
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
              Selector<OpenProvider, int>(
                selector: (p0, p1) {
                  return p1.y;
                },
                builder: (context, yValue, child) {
                  return Text(
                    yValue.toString(),
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => hotelhotel(),
                      ));
                },
                child: Text("دخول الفنادق"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String textToSend = "User";
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          adminanduserlogin(
                            text: textToSend,
                          ),
                    ));
              },
              child: Text("دخول المستخدمين"),
            ),
            ElevatedButton(
              onPressed: () {
                String textToSend = "Admin";
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          adminanduserlogin(
                            text: textToSend,
                          ),
                    ));
              },
              child: Text("دخول المدير"),
            ),
            DropdownButton<String>(
              items: <String>['English', 'Arabic'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openProvider.increaseI();
        },
      ),
    );
  }


}

