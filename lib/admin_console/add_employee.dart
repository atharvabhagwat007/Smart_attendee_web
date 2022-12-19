import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/admin_console.dart.dart';
import 'package:smart_attendee/admin_console/providers/add_employee_provider.dart';
import 'package:smart_attendee/admin_console/providers/get_all_employees.dart';
import 'package:smart_attendee/admin_console/widgets/custom_text_field.dart';
import 'package:smart_attendee/admin_console/widgets/submit_button.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  List<String> shiftList = ["Morning", "Evening"];
  final TextEditingController _firstNameController = TextEditingController();
  File _file = File("zz");
  Uint8List webImage = Uint8List(10);
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _empEmailController = TextEditingController();
  final TextEditingController _empPasswordController = TextEditingController();
  final TextEditingController _empIdController = TextEditingController();
  String dropdownValue = "Morning";
  String photoUploadUrl = "";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEmployeeProvider(),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white12,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getTitle(context),
                  const Divider(
                    thickness: 1,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          _pickImage();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _file.path == "zz"
                              ? Image.asset(
                                  "assets/images/profile_image.png",
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ).image
                              : Image.memory(webImage).image,
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Please upload employee image",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _getNameForms(),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      title: "Enter employee Id*",
                      labelText: "Employee Id",
                      textEditingController: _empIdController,
                      width: 300),
                  const SizedBox(
                    height: 20,
                  ),
                  _getEmailPassForms(),
                  const SizedBox(
                    height: 20,
                  ),
                  _getShiftDropDown(),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_firstNameController.text.isEmpty ||
                          _lastNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: SizedBox(
                              height: 20,
                              child: Center(
                                  child: Text("Please enter all fields")),
                            ),
                          ),
                        );
                      } else {
                        context
                            .read<AddEmployeeProvider>()
                            .addEmoplyee(
                                empId: _empIdController.text,
                                empMail: _empEmailController.text,
                                empPassword: _empPasswordController.text,
                                webImage: webImage,
                                context: context,
                                empPhotoUrl:
                                    "https://firebasestorage.googleapis.com/v0/b/tusharproject-740b6.appspot.com/o/gfg.jpg?alt=media&token=cb42a4a6-a167-41c9-a716-11d020ffed12",
                                empName:
                                    "${_firstNameController.text} ${_lastNameController.text}",
                                empShift: dropdownValue)
                            .then((value) {
                          if (value == "true") {
                            // Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                          create: (context) =>
                                              GetAllEmployeeProvider(),
                                          child: AdminConsole(),
                                        )),
                                (route) => false);
                          }
                        });
                      }
                    },
                    child: SubmitButton(
                      title: "Submit",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getShiftDropDown() {
    return Row(
      children: [
        const Text(
          "Enter employee's shift:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 18,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          underline: Container(
            height: 2,
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: shiftList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  _getNameForms() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              title: "First Name*",
              labelText: "First Name",
              textEditingController: _firstNameController),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: CustomTextField(
              title: "Last Name*",
              labelText: "Last Name",
              textEditingController: _lastNameController),
        ),
      ],
    );
  }

  _getEmailPassForms() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              title: "Employee Email*",
              labelText: "Emp email",
              textEditingController: _empEmailController),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: CustomTextField(
              title: "Enter a password for employee*",
              labelText: "Password",
              textEditingController: _empPasswordController),
        ),
      ],
    );
  }

  _getTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Add Employee",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 30),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
    );
  }

  _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        _file = File("a");
        webImage = f;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: SizedBox(height: 20, child: Text('No file selected'))));
    }
  }
}
