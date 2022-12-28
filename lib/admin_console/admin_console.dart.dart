import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/providers/get_all_clients.dart';
import 'package:smart_attendee/admin_console/providers/get_all_employees.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole({super.key});

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  @override
  void initState() {
    context.read<GetAllEmployeeProvider>().getAllEmployees();
    context.read<GetAllClientProvider>().getAllClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Provider.of<GetAllEmployeeProvider>(context)
                .isEmployeeLoaded) ...[
              _getGreetingText(),
              _getCountOfEmployeeClientContainer(),
              const SizedBox(
                height: 40,
              ),
              ..._getAllEmployees(),
              ..._getAllClients(),
            ],
            if (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded ==
                false)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    ));
  }

  List _getAllEmployees() {
    return [
      _getTitle("All employees"),
      const SizedBox(
        height: 15,
      ),
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
                    shrinkWrap: true,
                    children: [
                      const Divider(
                        thickness: 2,
                      ),
                      ListTile(
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
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      )
    ];
  }

  Widget _getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      ),
    );
  }

  List _getAllClients() {
    return [
      _getTitle("All Clients"),
      const SizedBox(
        height: 15,
      ),
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
            children:
                Provider.of<GetAllClientProvider>(context).clientList.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        title: Text(
                          e.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          e.location,
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
      )
    ];
  }

  Widget _getCountOfEmployeeClientContainer() {
    return Row(
      children: [
        _getCountsContainer("Total Employees ",
            "${Provider.of<GetAllEmployeeProvider>(context).employeeCount}"),
        const SizedBox(
          width: 20,
        ),
        _getCountsContainer("Total Clients",
            "${Provider.of<GetAllClientProvider>(context, listen: false).clientList.length}"),
        const SizedBox(
          width: 20,
        ),
        _getCountsContainer("Average attendece ", "30"),
        const SizedBox(
          width: 20,
        ),
        _getCountsContainer("Average overtime ", "20"),
      ],
    );
  }

  Widget _getGreetingText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Text(
        "Good Morning ",
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _getCountsContainer(String title, String count) {
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
                  Provider.of<GetAllClientProvider>(context).isClientLoaded
                      ? Text(
                          count,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
            ),
          )),
    );
  }
}
