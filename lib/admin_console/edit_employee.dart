import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_attendee/admin_console/widgets/custom_text_field.dart';
import 'package:smart_attendee/admin_console/widgets/submit_button.dart';
import 'package:smart_attendee/models/employee_model.dart';
import 'package:smart_attendee/routing/routes.dart';

class EditEmployeeScreen extends StatefulWidget {
  EditEmployeeScreen({super.key, required this.employee});

  final EmployeeModel employee;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  File file = File("zz");
  late TextEditingController employeeNameController = TextEditingController();
  late TextEditingController employeeEmailController = TextEditingController();
  late TextEditingController employeePasswordController =
      TextEditingController();
  late EmployeeModel employee;
  late List<EmployeeShift> employeeShift;
  @override
  void initState() {
    employeeNameController.text = widget.employee.empName;
    employeeEmailController.text = widget.employee.empMail;
    employeePasswordController.text = widget.employee.empPwd;
    employee = widget.employee;
    employeeShift = employee.empShift;
    super.initState();
  }

  Uint8List webImage = Uint8List(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(context),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  _pickImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                  backgroundImage: file.path == "zz"
                      ? Image.network(
                          widget.employee.empPhotourl,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ).image
                      : Image.memory(webImage).image,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Edit Employee Photo",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: "Name",
                    textEditingController: employeeNameController,
                    title: "Employee Name",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: "Email",
                    textEditingController: employeeEmailController,
                    title: "Employee Email",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              width: MediaQuery.of(context).size.width / 2.5,
              labelText: "Password",
              textEditingController: employeePasswordController,
              title: "Employee Password",
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Shifts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: employeeShift.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          final shift = employeeShift[index];
                          return Card(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('Date:'),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(shift.date)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('From: ${shift.shiftFrom}'),
                                      Text('To: ${shift.shiftTo}')
                                    ],
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      employeeShift.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ));
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: employeeShift.length)
                    : const Center(
                        child: Text('No Shift Added'),
                      )),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      context.pushNamed(RouterPaths.addShift,
                          params: {'empId': employee.empId, 'tab': 'add_shift'},
                          extra: () {
                        setState(() {});
                      });
                    },
                    child: SubmitButton(title: "Add Shift")),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: SubmitButton(title: "Update Changes")),
              ],
            )
          ],
        ),
      ),
    );
  }

  _getTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Edit Employee",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 30),
        )
      ],
    );
  }

  _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        file = File("a");
        webImage = f;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: SizedBox(height: 20, child: Text('No file selected'))));
    }
  }
}
