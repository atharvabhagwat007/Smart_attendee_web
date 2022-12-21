import 'package:flutter/material.dart';
import 'package:smart_attendee/admin_console/admin_console.dart.dart';
import 'package:smart_attendee/desktop_nav/models/nav_option.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final List<NavOption> _navigationDestinations = <NavOption>[
    const NavOption(
        textLabel: 'Employee List', menuIcon: Icons.list_alt_rounded),
    const NavOption(
        textLabel: 'Add Employee', menuIcon: Icons.add_reaction_rounded),
  ];
  @override
  Widget build(BuildContext context) {
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
                        selectedIndex: 0,
                        onDestinationSelected: (index) {},
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          const Expanded(
            child: Center(
              child: AdminConsole(),
            ),
          ),
        ],
      ),
    );
  }
}
