import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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

  _createPdf() async {
    final pdf = pw.Document();
    var nameText = nameController.text;
    var contactText = contactNoController.text;
    var reasonText = reasonController.text;
    final image =
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
    pdf.addPage(
      pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                  // mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Image(
                      pw.MemoryImage(image),
                      width: MediaQuery.of(this.context).size.width,
                      alignment: pw.Alignment.center,
                      // height: 200,
                      fit: pw.BoxFit.fill,
                    ),
                    pw.Text(
                      'Avitech Nutrition',
                    ),
                    pw.SizedBox(height: 20.0),
                    pw.SizedBox(height: 20.0),
                    pw.SizedBox(height: 1.0),
                    pw.TableHelper.fromTextArray(
                      cellPadding: const pw.EdgeInsets.all(8.0),
                      context: context,
                      data: <List<String>>[
                        <String>[
                          'Name',
                          'Contact No',
                          'Reason',
                          'Department',
                          'Person'
                        ],
                        <String>[
                          nameText,
                          contactText,
                          reasonText,
                          '$_selectDepartment',
                          '$_selectPerson'
                        ],
                      ],
                    ),
                  ]),
            );
          },
          pageFormat: PdfPageFormat.a4),
    );
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$nameText.pdf');
    file.writeAsBytesSync(await pdf.save());
    OpenFile.open('$path/$nameText.pdf');
  }

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

  void addData() {
    Map<String, String> dataSave = {
      'Name': nameController.text,
      'Contact No': contactNoController.text.toString(),
      'Reason': reasonController.text,
      'Department': _selectDepartment,
      'Person': _selectPerson
    };

    FirebaseFirestore.instance.collection('user_data').add(dataSave);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
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
                      height: 50.0,
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
                      height: 20.0,
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
                                      print(department[val]);
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
                    const SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // addData();
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
}
