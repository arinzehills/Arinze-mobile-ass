import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/modules/addemployee/presentation/add_employee_screen.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';
import 'package:mobile_assessment/modules/login/presentation/profile_screen.dart';
import 'package:mobile_assessment/modules/widgets/drawer/desktop_nav_provider.dart';
import 'package:provider/provider.dart';

class DesktopDrawer extends StatefulWidget {
  DesktopDrawer({super.key});

  @override
  State<DesktopDrawer> createState() => _DesktopDrawerState();
}

class _DesktopDrawerState extends State<DesktopDrawer> {
  bool isExpandedDrawer = true;
  List drawerItems = [
    {
      'text': 'Home Page',
      'leading': IconlyBold.chart,
      // 'widget': HomeScreenMobile()
      'widget': HomeScreen()
    },
    {
      'text': 'Add Employee',
      'leading': IconlyBold.add_user,
      'widget': AddEmployeeScreen()
    },
    {
      'text': 'Admin Profile ',
      'leading': IconlyBold.profile,
      'widget': ProfileScreen()
    },
  ];

  @override
  initState() {
    Provider.of<DesktopNavProvider>(context, listen: false)
        .selectWiget(drawerItems[0]);
    super.initState();
  }

  handleButtonToggle() {
    setState(() => {isExpandedDrawer = !isExpandedDrawer});
  }

  @override
  Widget build(BuildContext context) {
    var drawerProvider = Provider.of<DesktopNavProvider>(context);
    return AnimatedContainer(
      color: Colors.grey[100],
      curve: Curves.bounceInOut,
      duration: Duration(milliseconds: 300),
      width: isExpandedDrawer ? 300 : 70,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  handleButtonToggle();
                },
                icon: Icon(IconlyBold.filter)),
          ),
          SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          for (var item in drawerItems) ...[
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 20),
              child: ListTile(
                onTap: () {
                  Provider.of<DesktopNavProvider>(context, listen: false)
                      .selectWiget(item);
                },
                leading: Icon(
                  item['leading'] ?? IconlyBold.activity,
                  color: drawerProvider.selectedWiget!['text'] == item['text']
                      ? AppColors.orange
                      : null,
                ),
                title: Container(
                  // width: isExpandedDrawer ? 150 : 5,
                  // height: 50,
                  child: Text(
                    item["text"],
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontWeight: drawerProvider.selectedWiget!['text'] ==
                                item['text']
                            ? FontWeight.bold
                            : null,
                        fontSize: 23,
                        color: drawerProvider.selectedWiget!['text'] ==
                                item['text']
                            ? AppColors.orange
                            : null),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
