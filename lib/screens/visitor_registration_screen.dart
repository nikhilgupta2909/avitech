// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'package:avinutri/widgets/drawer.dart';
import 'package:avinutri/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class VisitorRegistration extends StatefulWidget {
  const VisitorRegistration({super.key});

  @override
  State<VisitorRegistration> createState() => _VisitorRegistrationState();
}

class _VisitorRegistrationState extends State<VisitorRegistration> {
  
  var name = "";
  var contactNo = "";

  final formKey = GlobalKey<FormState>();

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  final nameController = TextEditingController();
  final contactNoController = TextEditingController();
  final reasonController = TextEditingController();
  final currentTimeController = TextEditingController();
  final currentDateController = TextEditingController();

  // ignore: recursive_getters
  DateTime get time => time;

  //

  File? image;

  Future pickImage(source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this.image = imageTemp;
    });
  }

  var _selectDepartment;
  var department = {
    'IT': 'I.T.',
    'Laboratory': 'Lab',
    'Administrator': 'Admin',
    'Production': 'Prod.',
    'CEO': 'C.E.O',
    'Marketing': 'Marketing',
    'HR': 'H.R.'
  };

  var _selectPerson;
  var person = {
    'Mr. Arjun Vohra': 'C.E.O',
    'Mr. Nirmalaya Sinha': 'H.R.',
    'Mr. Praveen Gaur': 'H.R.',
    'Mrs. Heena Sharma': 'H.R.',
    'Mr. Narendra Singh Chhikara': 'Admin',
    'Mr. Bhupinder Singh': 'Admin',
    'Mr. Dhananjay Kumar Singh': 'I.T.',
    'Mr. Nikhil Kumar Gupta': 'I.T.'
  };

  List _person = [];
  personDropdown(personName) {
    person.forEach((key, value) {
      if (personName == value) {
        _person.add(key);
      }
    });
  }

  final List _departments = [];
  departmentDropdown() {
    department.forEach((key, value) {
      _departments.add(key);
    });
  }

  @override
  void initState() {
    super.initState();
    departmentDropdown();
  }

  void clearText() {
    setState(() {
      // This is how we can reset the value of dropdown button....
      _selectDepartment = null;
      _selectPerson = null;
      // _selectedDepartment = null;
      nameController.clear();
      contactNoController.clear();
      reasonController.clear();
      image = null;
    });
  }

  void uploadImageToFirebase()
  {
    
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        drawer: const MyDrawer(),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.purple,
                ],
              ),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 1.0,
                        top: 15.0,
                      ),
                      child: ClipOval(
                        child: image != null
                            ? Image.file(image!,
                                width: 150, height: 150, fit: BoxFit.cover)
                            : Image.network(
                                'https://img.freepik.com/free-photo/abstract-luxury-blur-grey-color-gradient-used-as-background-studio-wall-display-your-products_1258-52609.jpg',
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      child: const Text(
                        "Add Photo",
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? 'Please Enter the name'
                          : (value.contains(nameRegExp)
                              ? null
                              : 'Enter a Valid Name'),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        labelText: "Name",
                        fillColor: Colors.white.withOpacity(0.6),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: contactNoController,
                      validator: (value) => value == null
                          ? 'Please enter the Contact No'
                          : value.length > 10
                              ? 'Contact no should only contain 10 digits'
                              : null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        labelText: "Contact No",
                        fillColor: Colors.white.withOpacity(0.6),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: reasonController,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        labelText: "Reason",
                        fillColor: Colors.white.withOpacity(0.6),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    Padding(
                      // padding: EdgeInsets.only(left: 15.0, top: 25.0),
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 1.15,
                            margin: const EdgeInsets.only(top: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                isDense: true,
                                hint: const Text("Select Department"),
                                menuMaxHeight: 150.0,
                                // itemHeight: 50.0,
                                // value: selectedDepartment,
                                value: _selectDepartment,
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                items: _departments
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      ),
                                    )
                                    .toList(),
                                // value: 'Select Department ',
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _person = [];
                                      personDropdown(department[val]);
                                      _selectDepartment = val! as String;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 1.15,
                            margin: const EdgeInsets.only(top: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text("Select Person "),
                                isExpanded: true,
                                isDense: true,
                                // value: selectedDepartment,
                                value: _selectPerson,
                                dropdownColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                items: _person
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString()),
                                      ),
                                    )
                                    .toList(),
                                // value: 'Select Department ',
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _selectPerson = val! as String;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: TextField(
                        controller: currentTimeController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: DateFormat('Hm').format(time)),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: TextField(
                        controller: currentDateController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: DateFormat('yMMMMd').format(time)),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              addData();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Data Saved Succesfully..."),
                                ),
                              );
                            }
                          },
                          child: const Text("Save Data"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            clearText();
                          },
                          child: const Text("Reset Data"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addData() {
    Map<String, String> saveData = {
      'Name': nameController.text,
      'Contact No': contactNoController.text.toString(),
      'Reason': reasonController.text,
      'Date': DateFormat('yMMMMd').format(time),
      'Time': DateFormat('Hm').format(time),
      'Department': _selectDepartment,
      'Person': _selectPerson,
    };

    FirebaseFirestore.instance.collection('user_data').add(saveData);
  }
}
