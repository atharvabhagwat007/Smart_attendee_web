import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/add_employee_screen.dart';
import 'package:smart_attendee/admin_console/edit_employee.dart';
import 'package:smart_attendee/admin_console/providers/get_all_employees.dart';
import 'package:smart_attendee/admin_console/widgets/submit_button.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole({super.key});

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  @override
  void initState() {
    context.read<GetAllEmployeeProvider>().getAllEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    "Good Morning ",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded)
                Row(
                  children: [
                    _getCountsContainer("Total Employees ",
                        "${Provider.of<GetAllEmployeeProvider>(context).employeeCount}"),
                    const SizedBox(
                      width: 20,
                    ),
                    _getCountsContainer("Total Clients", "30"),
                    const SizedBox(
                      width: 20,
                    ),
                    _getCountsContainer("Average attendece ", "30"),
                    const SizedBox(
                      width: 20,
                    ),
                    _getCountsContainer("Average overtime ", "20"),
                  ],
                ),
              const SizedBox(
                height: 40,
              ),
              if (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "All employees",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              if (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded)
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5,
                      )
                    ],
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: Provider.of<GetAllEmployeeProvider>(context)
                          .employeeList
                          .map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: SizedBox(
                            child: ListView(
                              reverse: true,
                              shrinkWrap: true,
                              children: [
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                  trailing: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    EditEmployeeScreen(
                                                      employee: e,
                                                    )));
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
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    "assets/images/profile_image.png"),
                                            e.empPhotourl)
                                        .image,
                                  ),
                                  title: Text(
                                    e.empName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    e.empMail,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              if (Provider.of<GetAllEmployeeProvider>(context)
                      .isEmployeeLoaded ==
                  false)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (Provider.of<GetAllEmployeeProvider>(context)
                      .isEmployeeLoaded ==
                  true)
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => AddEmployeeScreen()));
                    },
                    child: SubmitButton(title: "Add Employee"))
            ],
          ),
        ),
      ),
    ));
  }

  _getCountsContainer(String title, String count) {
    return Expanded(
      child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    count,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
