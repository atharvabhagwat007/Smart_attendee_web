import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/routing/routes.dart';

import 'providers/get_all_employees.dart';

class AddEmployeeShift extends StatefulWidget {
  const AddEmployeeShift({super.key});

  @override
  State<AddEmployeeShift> createState() => _AddEmployeeShiftState();
}

class _AddEmployeeShiftState extends State<AddEmployeeShift> {
  @override
  void initState() {
    context.read<GetAllEmployeeProvider>().getAllEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: (Provider.of<GetAllEmployeeProvider>(context).isEmployeeLoaded)
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
            Row(
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'no client selected',
                          style: Theme.of(context).textTheme.button,
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: employeeList.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                itemBuilder: (context, index) {
                  final e = employeeList[index];
                  return Card(
                    child: ListTile(
                      trailing: InkWell(
                          onTap: () {
                            context.goNamed(RouterPaths.editEmployee,
                                params: {'empId': e.empId, 'tab': 'add_shift'}, extra: e);
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
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
