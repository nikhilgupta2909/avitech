import 'package:avinutri/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

class VisitorRegistration extends StatefulWidget {
  const VisitorRegistration({super.key});

  @override
  State<VisitorRegistration> createState() => _VisitorRegistrationState();
}

class _VisitorRegistrationState extends State<VisitorRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                cursorColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
