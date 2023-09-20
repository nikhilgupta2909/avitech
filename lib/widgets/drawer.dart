import 'package:avinutri/constants/constants.dart';
import 'package:avinutri/screens/Auth_UI/login_screen.dart';
import 'package:avinutri/screens/main_page.dart';
import 'package:avinutri/screens/visitor_registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(  
        onWillPop: () async => false,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text("Admin"),
                    leading: const Icon(Icons.admin_panel_settings),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const LoginScreen())));
                    },
                  ),
                  ExpansionTile(
                    title: const Text("Visitor Entry"),
                    leading: const Icon(Icons.person),
                    childrenPadding: const EdgeInsets.only(left: 5.0),
                    // childrenPadding: EdgeInsets.only(left: 30.0, top: 5.0),
                    children: [
                      ListTile(
                        title: const Text("Avitech H.O"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const VisitorRegistration())));
                        },
                      ),
                      ListTile(
                          title: Text(
                        "Vidya Vana (Coming Soon)",
                        style: TextStyle(color: Colors.grey.shade400),
                      )),
                      ListTile(
                        title: Text(
                          "Binola (Coming Soon)",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Jhajjar (Coming Soon)",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Reports"),
                    leading: const Icon(Icons.edit_document),
                    childrenPadding: const EdgeInsets.only(left: 5.0),
                    children: [
                      ListTile(
                        title: const Text("Generate PDF"),
                        onTap: () async {
                          final QuerySnapshot snapshot = await FirebaseFirestore
                              .instance
                              .collection('user_data')
                              .get();
                          final data = snapshot.docs;
                          await generatePdf(data);
                        },
                      ),
                      const ListTile(
                        title: Text("Show Reports"),
                      ),
                    ],
                  ),
                  const ListTile(
                    title: Text("Admin"),
                    leading: Icon(Icons.admin_panel_settings),
                  ),
                  const SizedBox(
                    height: 90.0,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.1,
                  ),
                  const ListTile(
                    title: Text("Log-In"),
                    leading: Icon(Icons.login),
                  ),
                  ListTile(
                    title: const Text("Log-Out"),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      FirebaseAuth.instance
                          .signOut()
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              )));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
