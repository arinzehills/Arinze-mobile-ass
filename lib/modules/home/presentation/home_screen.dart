import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/home/presentation/home_viewmodel.dart';
import 'package:mobile_assessment/modules/home/presentation/widgets/employee_card.dart';
import 'package:mobile_assessment/modules/home/presentation/widgets/employee_filter_widget.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mobile_assessment/modules/widgets/noitems/no_items_widget.dart';
import 'package:mobile_assessment/routes/app_routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = size(context).width > 600;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Employee List",
        ),
        actions: isTablet
            ? null
            : [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.add_employee);
                    },
                    icon: Icon(IconlyBold.add_user)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.admin_profile);
                    },
                    icon: Icon(IconlyBold.profile))
              ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: Loading());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0).copyWith(
                    top: 0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          onChanged: (value) {
                            // setState(() => _searchQuery = value);
                            viewModel.filterEmployees(value!);
                          },
                          hintText: 'Search Employee',
                          labelText: 'Search by name, level or designation...',
                          suffixIcon: Icon(IconlyBold.search),
                          // decoration: InputDecoration(
                          //   labelText: 'Search',
                          // ),
                        ),
                      ),
                      EmployeeFilterWidget(
                        onApplyFilter: (Map<String, List<String>> filterData) {
                          print('Filters Applied:');
                          filterData.forEach((key, value) {
                            print('$key: ${value.join(', ')}');
                          });

                          viewModel.applyFilters(filterData);
                        },
                      ),
                    ],
                  ),
                ),
                viewModel.filteredEmployees.isEmpty
                    ? Align(alignment: Alignment.center, child: NoItemsWidget())
                    : Expanded(
                        child: ListView.builder(
                        itemCount: viewModel.filteredEmployees.length,
                        itemBuilder: (context, index) {
                          final employee = viewModel.filteredEmployees.reversed
                              .toList()[index];
                          return EmployeeCard(employee: employee);
                        },
                      )),
              ],
            );
          }
        },
      ),
    );
  }
}
