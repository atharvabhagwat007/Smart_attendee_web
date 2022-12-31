import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/providers/edit_employee_provider.dart';
import 'package:smart_attendee/admin_console/widgets/custom_text_field.dart';
import 'package:smart_attendee/admin_console/widgets/submit_button.dart';
import 'package:smart_attendee/models/employee_model.dart';

import 'providers/get_employee_provider.dart';
import 'widgets/add_shift.dart';

class EditEmployeeScreen extends StatefulWidget {
  EditEmployeeScreen({super.key, required this.employeeId});

  final String employeeId;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  File file = File("zz");
  late TextEditingController employeeNameController = TextEditingController();
  late TextEditingController employeeEmailController = TextEditingController();
  late TextEditingController employeePasswordController =
      TextEditingController();
  late List<Attendance> employeeShift;
  @override
  void initState() {
    context
        .read<GetEmployeeProvider>()
        .getEmployee(employeeId: widget.employeeId);
    super.initState();
  }

  Uint8List webImage = Uint8List(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: Provider.of<GetEmployeeProvider>(context).isEmployeeLoaded
                  ? editEmployeeView(context)
                  : reloadView(),
            )
          ],
        ),
      ),
    );
  }

  Center reloadView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget editEmployeeView(BuildContext context) {
    final employee = Provider.of<GetEmployeeProvider>(context).employee;
    employeeNameController.text = employee.empName;
    employeeEmailController.text = employee.empMail;
    employeePasswordController.text = employee.empPwd;
    employeeShift = employee.attendance;
    return ChangeNotifierProvider(
      create: (context) => EditEmployeeProvider(),
      builder: (context, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        employee.empPhotourl,
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
                  ? SizedBox(
                      width: 450,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final shift = employeeShift[index];
                            return shiftCard(context, shift, index);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 8,
                              ),
                          itemCount: employeeShift.length),
                    )
                  : const Center(
                      child: Text('No Shift Added'),
                    )),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    showDialog<Widget>(
                        context: context,
                        builder: (BuildContext context) {
                          return AddShift(
                              employeeId: employee.empId,
                              callback: () {
                                setState(() {
                                  context
                                      .read<GetEmployeeProvider>()
                                      .getEmployee(
                                          employeeId: widget.employeeId);
                                });
                              });
                        });
                  },
                  child: SubmitButton(title: "Add Shift")),
              const Spacer(),
              TextButton(
                  onPressed: () async {
                    final employeeName = employeeNameController.text;
                    final employeeMail = employeeEmailController.text;
                    final employeePassword = employeePasswordController.text;
                    if (employeeName.isNotEmpty &&
                        employeeMail.isNotEmpty &&
                        employeePassword.isNotEmpty) {
                      await context
                          .read<EditEmployeeProvider>()
                          .uploadPhoto(
                            webImage,
                            widget.employeeId,
                            context,
                          )
                          .whenComplete(() {
                        context
                            .read<EditEmployeeProvider>()
                            .editEmployee(
                              webImage: webImage,
                              employeeId: widget.employeeId,
                              json: {
                                "emp_name": employeeNameController.text,
                                "emp_mail": employeeEmailController.text,
                                "emp_pwd": employeePasswordController.text,
                                "emp_photourl":
                                    Provider.of<EditEmployeeProvider>(context,
                                            listen: false)
                                        .photoUrl,
                              },
                              context: context,
                            )
                            .then((value) {
                          if (value) {
                            if (value) {
                              setState(() {
                                context
                                    .read<GetEmployeeProvider>()
                                    .getEmployee(employeeId: widget.employeeId);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: SizedBox(
                                    height: 20,
                                    child: Text('Succesfully Update the User'),
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: SizedBox(
                                    height: 20,
                                    child: Text(
                                        'Some Error occured. Please try again'),
                                  ),
                                ),
                              );
                            }
                          }
                        });
                      });
                    }
                  },
                  child: SubmitButton(title: "Update Changes")),
            ],
          ),
        ],
      ),
    );
  }

  Widget shiftCard(BuildContext context, Attendance shift, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Date:'),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(shift.date!)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('From: ${shift.shiftFrom}'),
                      const SizedBox(
                        width: 12,
                      ),
                      Text('To: ${shift.shiftTo}')
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                employeeShift.removeAt(index);

                context
                    .read<EditEmployeeProvider>()
                    .editEmployee(
                      webImage: webImage,
                      employeeId: widget.employeeId,
                      json: {
                        "attendance": List<dynamic>.from(
                            employeeShift.map((x) => x.toJson()))
                      },
                      context: context,
                    )
                    .then((value) {
                  if (value) {
                    if (value) {
                      setState(() {
                        context
                            .read<GetEmployeeProvider>()
                            .getEmployee(employeeId: widget.employeeId);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: SizedBox(
                            height: 20,
                            child: Text('Succesfully Update the User'),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: SizedBox(
                            height: 20,
                            child: Text('Some Error occured. Please try again'),
                          ),
                        ),
                      );
                    }
                  }
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
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
