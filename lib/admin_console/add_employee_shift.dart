import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/providers/get_all_clients.dart';
import 'package:smart_attendee/admin_console/widgets/drop_down.dart';
import 'package:smart_attendee/models/employee_model.dart';
import 'package:smart_attendee/routing/routes.dart';

import '../models/client_model.dart';
import 'providers/get_all_employees.dart';

class AddEmployeeShift extends StatefulWidget {
  const AddEmployeeShift({super.key});

  @override
  State<AddEmployeeShift> createState() => _AddEmployeeShiftState();
}

class _AddEmployeeShiftState extends State<AddEmployeeShift> {
  String? selectedClient;
  List<EmployeeModel>? filteredList;

  void clientSelected(String? value, List<EmployeeModel> employees) {
    selectedClient = value;
    if (selectedClient != null) {
      filteredList = employees
          .where((element) => element.clientName == selectedClient)
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    context.read<GetAllEmployeeProvider>().getAllEmployees();
    context.read<GetAllClientProvider>().getAllClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded) &&
                    (Provider.of<GetAllClientProvider>(context).isClientLoaded)
                ? getEmployeeList()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    ));
  }

  Widget getEmployeeList() {
    return LayoutBuilder(builder: (context, constraints) {
      final employeeList =
          Provider.of<GetAllEmployeeProvider>(context).employeeList;
      final clientList = Provider.of<GetAllClientProvider>(context).clientList;
      return SizedBox(
        height: constraints.maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Employees List',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            filterSection(
                clients: clientList,
                context: context,
                onChanged: (value) {
                  clientSelected(value, employeeList);
                },
                selectedClient: selectedClient),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: selectedClient == null
                    ? employeeList.length
                    : filteredList!.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                itemBuilder: (context, index) {
                  EmployeeModel employee;
                  if (selectedClient == null) {
                    employee = employeeList[index];
                  } else {
                    employee = filteredList![index];
                  }
                  return Card(
                    child: ListTile(
                      trailing: InkWell(
                          onTap: () {
                            context.goNamed(RouterPaths.editEmployee, params: {
                              'empId': employee.empId,
                              'tab': 'add_shift'
                            });
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        backgroundImage: Image.network(
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                        "assets/images/profile_image.png"),
                                employee.empPhotourl)
                            .image,
                      ),
                      title: Text(
                        employee.empName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        employee.empMail,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Widget filterSection(
      {required BuildContext context,
      required Function(String?) onChanged,
      required List<Client> clients,
      required String? selectedClient}) {
    final clientNames = clients.map((client) => client.name).toList();
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropDown(
              hint: 'Select Client',
              dropdownItems: clientNames,
              onChanged: onChanged,
              value: selectedClient),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                setState(() {
                  this.selectedClient = null;
                });
              },
              icon: const Icon(
                Icons.clear_rounded,
                color: Colors.red,
              )),
        )
      ],
    );
  }
}
