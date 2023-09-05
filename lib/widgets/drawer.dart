import 'package:avinutri/constants/constants.dart';
import 'package:avinutri/screens/login_screen.dart';
import 'package:avinutri/screens/visitor_registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                    const ListTile(
                      title: Text("Vidya Vana"),
                    ),
                    const ListTile(
                      title: Text("Binola"),
                    ),
                    const ListTile(
                      title: Text("Jhajjar"),
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
                const ListTile(
                  title: Text("Log-Out"),
                  leading: Icon(Icons.logout),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
