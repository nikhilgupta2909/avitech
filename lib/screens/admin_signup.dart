import 'package:flutter/material.dart';
//This package is used for formatting the date
import 'package:intl/intl.dart'; 


class AdminSignUpScreen extends StatefulWidget {
  const AdminSignUpScreen({super.key});

  @override
  State<AdminSignUpScreen> createState() => _AdminSignUpScreen();
}

class _AdminSignUpScreen extends State<AdminSignUpScreen> {  
  @override
  Widget build(BuildContext context) {
      var time = DateTime.now();

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Current Date is :\n ${DateFormat('yMMMMd').format(time)}",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                 Text(
                  "Current Time is :\n ${DateFormat('jms').format(time)}",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                 Text(
                  "Current Date is :\n ${DateFormat('yMMMMd').format(time)}",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Get  Current Date and Time"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
