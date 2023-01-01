import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                Provider.of<AddClientProvider>(
                  context,
                  listen: true,
                ).isClientAdded
                    ? InkWell(
                        onTap: () async {
                          _validatingAndAddingClient();
                        },
                        child: SubmitButton(
                          title: "Submit",
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validatingAndAddingClient() async {
    if (_clientIdController.text.isEmpty ||
        _clientLocationController.text.isEmpty ||
        _clientNameController.text.isEmpty ||
        _clientSubLocationController.text.isEmpty ||
        Provider.of<AddClientProvider>(context, listen: false)
            .selectedEmployee
            .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SizedBox(
            height: 20,
            child: Center(
              child: Text("Please enter all fields"),
            ),
          ),
        ),
      );
    } else {
      try {
        final currentPosition =
            await Provider.of<AddClientProvider>(context, listen: false)
                .determinePosition();

        if (!mounted) return;
        Provider.of<AddClientProvider>(context, listen: false)
            .addClient(
                context: context,
                adminId: "tTG47D04arQ3tdlq8MY5", //TODO KEPT IT HARDCODED
                clientCity: _clientSubLocationController.text,
                clientCountry: _clientLocationController.text,
                clientId: _clientIdController.text,
                clientName: _clientNameController.text,
                latitude: currentPosition.latitude.toInt(),
                longitude: currentPosition.longitude.toInt(),
                employeeList:
                    Provider.of<AddClientProvider>(context, listen: false)
                        .selectedEmployee)
            .then((value) {
          if (value == "true") {
            // Navigator.pop(context);
            _clearingData();
            print("added");
          }
        });
      } catch (_) {}
    }
  }

  _clearingData() {
    _clientIdController.clear();
    _clientLocationController.clear();
    _clientNameController.clear();
    _clientSubLocationController.clear();
    Provider.of<AddClientProvider>(context, listen: false).selectedEmployee =
        [];
  }

  Widget _getLocationForms() {
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
      children: const [
        Text(
          "Add Client",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 30),
        ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Provider.of<AddClientProvider>(context).selectedEmployee.isEmpty
                  ? Text("Add Employees")
                  : Text("Employees Added"),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Material(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Material(
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Select from the following employees",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Provider.of<GetAllEmployeeProvider>(context)
                                        .isEmployeeLoaded
                                    ? _getAllEmployeesList(value)
                                    : const Material(
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(30.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                Material(
                                  child: Padding(
                                    padding: const EdgeInsets.all(50.0),
                                    child: ElevatedButton(
                                      child: const Text("Done"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  _getAllEmployeesList(value) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: Provider.of<GetAllEmployeeProvider>(context).employeeCount,
        itemBuilder: (context, index) {
          List<EmployeeModel> employeeList =
              Provider.of<GetAllEmployeeProvider>(context).employeeList;
          return Material(
            child: Container(
              color: employeeList[index].isSelected
                  ? Colors.green.shade200
                  : Colors.white,
              child: InkWell(
                onTap: () {
                  if (employeeList[index].isSelected) {
                    value.selectEmployee(employeeList[index]);
                    employeeList[index].isSelected = false;
                  } else {
                    value.selectEmployee(employeeList[index]);
                    employeeList[index].isSelected = true;
                  }
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 30,
                    backgroundImage: Image.network(
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/profile_image.png"),
                            employeeList[index].empPhotourl)
                        .image,
                  ),
                  title: Text(
                    employeeList[index].empName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
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
    );
  }
}
