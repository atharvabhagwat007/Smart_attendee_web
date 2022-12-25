import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/admin_console.dart.dart';
import 'package:smart_attendee/admin_console/providers/add_client_provider.dart';

import 'package:smart_attendee/admin_console/providers/get_all_employees.dart';
import 'package:smart_attendee/admin_console/widgets/custom_text_field.dart';
import 'package:smart_attendee/admin_console/widgets/submit_button.dart';
import 'package:smart_attendee/models/employee_model.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  List<String> employeeList = [];

  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _clientLocationController =
      TextEditingController();
  final TextEditingController _clientSubLocationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                _getNameAndIdForms(),
                const SizedBox(
                  height: 20,
                ),
                _getLocationForms(),
                const SizedBox(
                  height: 20,
                ),
                _addEmployeeListButton(),
                const SizedBox(
                  height: 30,
                ),
                Consumer<AddClientProvider>(
                  builder: (context, value, child) => InkWell(
                    onTap: () {
                      if (_clientIdController.text.isEmpty ||
                          _clientLocationController.text.isEmpty ||
                          _clientNameController.text.isEmpty ||
                          _clientSubLocationController.text.isEmpty ||
                          value.selectedEmployee.isEmpty) {
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
                        value.addClient(
                            context: context,
                            adminId: "",
                            clientCity: _clientSubLocationController.text,
                            clientCountry: _clientLocationController.text,
                            clientId: _clientIdController.text,
                            clientName: _clientNameController.text,
                            employeeList: [] //TODO ADDING LIST FROM PROVIDER
                            ).then((value) {
                          if (value == "true") {
                            // Navigator.pop(context);
                            print("added");
                          }
                        });
                      }
                    },
                    child: SubmitButton(
                      title: "Submit",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getLocationForms() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            title: "Enter Client Country*",
            labelText: "Client Country",
            textEditingController: _clientLocationController,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: CustomTextField(
            title: "Enter Client City*",
            labelText: "Client City",
            textEditingController: _clientSubLocationController,
          ),
        ),
      ],
    );
  }

  _getNameAndIdForms() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            title: "Enter Client Name*",
            labelText: "Client Name",
            textEditingController: _clientNameController,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: CustomTextField(
            title: "Enter Client Id*",
            labelText: "Client Id",
            textEditingController: _clientIdController,
          ),
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
          "Add Client",
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

  _addEmployeeListButton() {
    return InkWell(
      onTap: () {
        _showAddEmployeeList();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(8)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text("Add Employees"),
        ),
      ),
    );
  }

  _showAddEmployeeList() {
    return showDialog(
        context: context,
        builder: (context) =>
            Consumer<AddClientProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(100.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.green.shade200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                Provider.of<GetAllEmployeeProvider>(context)
                                    .employeeCount,
                            itemBuilder: (context, index) {
                              List<EmployeeModel> employeeList =
                                  Provider.of<GetAllEmployeeProvider>(context)
                                      .employeeList;
                              return Material(
                                child: Container(
                                  color: employeeList[index].isSelected
                                      ? Colors.green.shade200
                                      : Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      if (employeeList[index].isSelected) {
                                        value.selectEmployee(
                                            employeeList[index]);
                                        employeeList[index].isSelected = false;
                                      } else {
                                        value.selectEmployee(
                                            employeeList[index]);
                                        employeeList[index].isSelected = true;
                                      }
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 30,
                                        backgroundImage: Image.network(
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                        "assets/images/profile_image.png"),
                                                employeeList[index].empPhotourl)
                                            .image,
                                      ),
                                      title: Text(
                                        employeeList[index].empName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        employeeList[index].empMail,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      trailing: employeeList[index].isSelected
                                          ? const Text(
                                              "Selected",
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
