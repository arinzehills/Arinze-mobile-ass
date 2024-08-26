import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';
import 'package:mobile_assessment/modules/widgets/drawer/desktop_drawer.dart';
import 'package:mobile_assessment/modules/widgets/drawer/desktop_nav_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({Key? key}) : super(key: key);

  @override
  State<HomeScreenDesktop> createState() => HomeScreenDesktopState();
}

class HomeScreenDesktopState extends State<HomeScreenDesktop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DesktopNavProvider>(
        builder: (context, selectedItemModel, child) {
      Map? selectedTab = selectedItemModel.selectedWiget;
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// First column
              DesktopDrawer(),

              /// Second Column
              Expanded(
                  child: selectedTab != null
                      ? selectedTab['widget']
                      : const Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: HomeScreen(),
                        ))
            ],
          ),
        ),
      );
    });
  }
}
