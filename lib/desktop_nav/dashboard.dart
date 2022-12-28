import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_attendee/admin_console/add_client_screen.dart';
import 'package:smart_attendee/admin_console/add_employee_shift.dart';
import 'package:smart_attendee/admin_console/admin_console.dart.dart';
import 'package:smart_attendee/desktop_nav/models/nav_option.dart';
import 'package:smart_attendee/routing/routes.dart';

import '../admin_console/add_employee_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    required this.tab,
  }) : super(key: key);

  final String tab;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  Widget _tabBody = const SizedBox();
  late int _selectedIndex;
  final List<NavOption> _navigationDestinations = <NavOption>[
    const NavOption(textLabel: 'Overview', menuIcon: Icons.dashboard),
    const NavOption(
        textLabel: 'Add Client',
        menuIcon: Icons.supervised_user_circle_rounded),
    const NavOption(
        textLabel: 'Add Employee', menuIcon: Icons.add_reaction_rounded),
    const NavOption(textLabel: 'Add Shift', menuIcon: Icons.timelapse_rounded),
    const NavOption(textLabel: 'Reports', menuIcon: Icons.report),
  ];

  int _indexFrom(String tab) {
    switch (tab) {
      case 'overview':
        return 0;
      case 'add_client':
        return 1;
      case 'add_employee':
        return 2;
      case 'add_shift':
        return 3;
      case 'reports':
        return 4;
      default:
        return 0;
    }
  }

  void _selectTab(int index) {
    if (index == 0) {
      _tabBody = const AdminConsole();
    } else if (index == 1) {
      _tabBody = const AddClientScreen();
    } else if (index == 2) {
      _tabBody = const AddEmployeeScreen();
    } else if (index == 3) {
      _tabBody = const AddEmployeeShift();
    } else if (index == 4) {
      _tabBody = const SizedBox();
    } else {
      _tabBody = const SizedBox();
    }
  }

  void _onDestinationSelected(int index) async {
    const userRoute = RouterPaths.dashboard;
    _selectedIndex = index;
    if (index == 0) {
      context.goNamed(userRoute, params: {'tab': 'overview'});
    } else if (index == 1) {
      context.goNamed(userRoute, params: {'tab': 'add_client'});
    } else if (index == 2) {
      context.goNamed(userRoute, params: {'tab': 'add_employee'});
    } else if (index == 3) {
      context.goNamed(userRoute, params: {'tab': 'add_shift'});
    } else if (index == 4) {
      context.goNamed(userRoute, params: {'tab': 'reports'});
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = _indexFrom(widget.tab);
    _selectTab(_selectedIndex);
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                color: Theme.of(context).navigationRailTheme.backgroundColor,
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 24, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.dashboard_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Admin DashBoard',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        destinations: [
                          for (var destination in _navigationDestinations)
                            NavigationRailDestination(
                              icon: Material(
                                key: ValueKey(
                                  'log-${destination.textLabel}',
                                ),
                                color: Colors.transparent,
                                child: Icon(destination.menuIcon),
                              ),
                              label: Text(destination.textLabel),
                            ),
                        ],
                        extended: true,
                        labelType: NavigationRailLabelType.none,
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: _onDestinationSelected,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: _tabBody,
            ),
          ),
        ],
      ),
    );
  }
}
