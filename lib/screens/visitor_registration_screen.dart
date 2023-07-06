// import 'package:avinutri/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';

class VisitorRegistration extends StatefulWidget {
  const VisitorRegistration({super.key});

  @override
  State<VisitorRegistration> createState() => _VisitorRegistrationState();
}

class _VisitorRegistrationState extends State<VisitorRegistration> {
  // final TextEditingController _nameController = TextEditingController();

  // List<dynamic> department = [];

  // String? deptId;

  // @override
  // void initState() {
  //   super.initState();

  //   department.add({"id": 1, "name": "C.E.O"});
  //   department.add({"id": 2, "name": "I.T"});
  //   department.add({"id": 3, "name": "Admin"});
  //   department.add({"id": 4, "name": "H.R."});
  //   department.add({"id": 5, "name": "Lab"});
  //   department.add({"id": 6, "name": "Marketing"});
  //   department.add({"id": 7, "name": "Production"});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.purple,
                ],
              ),
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
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
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: "Contact No",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     FormHelper.dropDownWidget(
                  //       context,
                  //       "Select Department",
                  //       deptId,
                  //       department,
                  //       (onChanged) {
                  //         deptId = onChanged;
                  //       },
                  //       (onValidate) {
                  //         if (onValidate == null) {
                  //           return 'Please Select Department';
                  //         } else {
                  //           return null;
                  //         }
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
