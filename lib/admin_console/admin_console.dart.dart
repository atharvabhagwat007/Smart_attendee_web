import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/get_all_employees.dart';
import 'providers/get_all_clients.dart';

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
    context.read<GetAllClientProvider>().getAllClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded) &&
                (Provider.of<GetAllClientProvider>(context).isClientLoaded)
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Provider.of<GetAllEmployeeProvider>(context)
                        .isEmployeeLoaded)
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
                    Row(
                      children: [
                        _getCountsContainer("Total Employees ",
                            "${Provider.of<GetAllEmployeeProvider>(context).employeeCount}"),
                        const SizedBox(
                          width: 20,
                        ),
                        _getCountsContainer("Total Clients",
                            "${Provider.of<GetAllClientProvider>(context).clientCount}"),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Employees",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Clients",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: employeeListView(context),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: clientListView(context),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : reloadView());
  }

  Widget employeeListView(BuildContext context) {
    final employeeList =
        Provider.of<GetAllEmployeeProvider>(context).employeeList;
    return Container(
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
        child: ListView.separated(
          itemCount: employeeList.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemBuilder: (context, index) {
            var employee = employeeList[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30,
                  backgroundImage: Image.network(
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/images/profile_image.png"),
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
      ),
    );
  }

  Widget clientListView(BuildContext context) {
    final clientList = Provider.of<GetAllClientProvider>(context).clientList;
    return Container(
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
        child: ListView.separated(
          itemCount: clientList.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemBuilder: (context, index) {
            var client = clientList[index];

            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                ),
                title: Text(
                  client.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${client.subLocation} ${client.location}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Center reloadView() {
    return const Center(
      child: CircularProgressIndicator(),
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
