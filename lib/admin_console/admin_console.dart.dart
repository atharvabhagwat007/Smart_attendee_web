import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/add_employee.dart';
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
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              if (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded)
                ...Provider.of<GetAllEmployeeProvider>(context)
                    .employeeList
                    .map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: SubmitButton(
                        isEditbutton: false,
                        title: "Edit",
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        backgroundImage: Image.network(
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                        "assets/images/profile_image.png"),
                                e.empPhotourl)
                            .image,
                      ),
                      title: Text(
                        e.empName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        e.empMail,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                }),
              if (Provider.of<GetAllEmployeeProvider>(context)
                      .isEmployeeLoaded ==
                  false)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) => AddEmployee()));
                  },
                  child: SubmitButton(title: "Add Employee"))
            ],
          ),
        ));
  }
}
