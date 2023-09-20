import 'package:avinutri/widgets/drawer.dart';
import 'package:flutter/material.dart';
//This package is used for formatting the date
// import 'package:intl/intl.dart';

var arrOffice = [
  "1. Admin",
  "2. Visitor Entry",
  "3. Binola",
  "4. Avitech H.O.",
  "5. Vidya Vana",
  "6. Jhajjar",
];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  // var officeName ;

  // void clearDropdown() {
  //   officeName = null;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   clearDropdown();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black87,
          title: const Text("Avitech"),
          centerTitle: true,
        ),
        drawer: const MyDrawer(),
        // body: Center(
        //   child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: MediaQuery.of(context).size.height,
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [ 
        //             Colors.white,
        //             Colors.deepPurple,
        //           ],
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //         ),
        //       ),
        //       child:
        //           Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //         Container(
        //             height: 50.0,
        //             width: MediaQuery.of(context).size.width,
        //             margin: const EdgeInsets.symmetric(
        //                 vertical: 30.0, horizontal: 100.0),
        //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //             decoration: BoxDecoration(
        //               border: Border.all(
        //                 color: Colors.black,
        //                 width: 1.2,
        //               ),
        //               borderRadius: BorderRadius.circular(15.0),
        //             ),
        //             child: DropdownButtonHideUnderline(
        //               child: DropdownButton(
        //                 value: officeName,
        //                 hint: const Text("Select Office"),
        //                 items: arrOffice
        //                     .map((e) => DropdownMenuItem(
        //                           value: e,
        //                           child: Text(e),
        //                         ))
        //                     .toList(),
        //                 onChanged: (value) {
        //                   setState(() {
        //                     officeName = value!;
        //                     // clearDropdown();
        //                   });
        //                   switch (value) {
        //                     case "1. Admin":
        //                       Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) => const LoginScreen()));
        //                       break;

        //                     case "2. Visitor Entry":
        //                       Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) =>
        //                                   const VisitorRegistration()));
        //                   }
        //                 },
        //               ),
        //             ))
        //       ])),
        // ),
      ),
    );
  }
}
