import 'package:avinutri/screens/main_page.dart';
import 'package:avinutri/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.purple,
              // Colors.indigo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.001, 20, 0),
            child: Column(
              children: [
                logoWidget("assets/images/logo.png"),
                const SizedBox(
                  height: 20,
                ),
                reText("Username", Icons.person_2_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 30,
                ),
                reText("Password", Icons.lock_outline_rounded, true,
                    _passTextController),
               const SizedBox(
                  height: 40,
                ),
                reButton(context, true, (){}),
                reButton(context, false, (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                }),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
