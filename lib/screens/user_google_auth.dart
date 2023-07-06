import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistration();
}

class _UserRegistration extends State<UserRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 90,
            child: TextFormField(
              // validator: ,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail_lock_outlined),
                labelText: "EmailL Address",
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            )),
      ),
    );
  }
}
