import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/widgets/button/app_button.dart';
import 'package:mobile_assessment/modules/widgets/button/app_gradient_button.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

class EmployeeFilterWidget extends StatefulWidget {
  final Function(Map<String, List<String>>) onApplyFilter;

  const EmployeeFilterWidget({Key? key, required this.onApplyFilter})
      : super(key: key);

  @override
  _EmployeeFilterWidgetState createState() => _EmployeeFilterWidgetState();
}

class _EmployeeFilterWidgetState extends State<EmployeeFilterWidget> {
  // Selected Filters
  List<String> selectedLevels = [];
  List<String> selectedDesignations = [];
  String? nameQuery;

  // Expand state
  bool isLevelExpanded = false;
  bool isDesignationExpanded = false;
  bool isNameExpanded = false;

  // Options
  final List<String> levels = ['1', '2', '3', '4', '5'];
  final List<String> designations = [
    'Customer Relations',
    'Tech',
    'Legal',
    'Human Resources'
  ];

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                // height: size(context).height * 0.9,
                padding: EdgeInsets.only(bottom: size(context).height * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          AppGradientButton(
                            widthRatio: 0.4,
                            isOval: true,
                            onTap: () {
                              final filterData = <String, List<String>>{};

                              if (nameQuery != null && nameQuery!.isNotEmpty) {
                                filterData['name'] = [nameQuery!];
                              }
                              if (selectedLevels.isNotEmpty) {
                                filterData['level'] = selectedLevels;
                              }
                              if (selectedDesignations.isNotEmpty) {
                                filterData['designation'] =
                                    selectedDesignations;
                              }

                              widget.onApplyFilter(filterData);
                              Navigator.pop(context);
                            },
                            buttonText: 'Apply Filter',
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: AppText(
                        "Filter By",
                        bold: true,
                      ),
                    ),
                    _buildFilterItem(
                      context,
                      'Name',
                      isExpanded: isNameExpanded,
                      onToggle: () {
                        setState(() {
                          isNameExpanded = !isNameExpanded;
                        });
                      },
                      child: isNameExpanded
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter first or last name',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    nameQuery = value;
                                  });
                                },
                              ),
                            )
                          : Container(),
                    ),
                    _buildFilterItem(
                      context,
                      'Level',
                      isExpanded: isLevelExpanded,
                      onToggle: () {
                        setState(() {
                          isLevelExpanded = !isLevelExpanded;
                        });
                      },
                      child: isLevelExpanded
                          ? Column(
                              children: levels.map((level) {
                                return CheckboxListTile(
                                  title: Text('Level $level'),
                                  value: selectedLevels.contains(level),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedLevels.add(level);
                                      } else {
                                        selectedLevels.remove(level);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            )
                          : Container(),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: _buildFilterItem(
                        context,
                        'Designation',
                        isExpanded: isDesignationExpanded,
                        onToggle: () {
                          setState(() {
                            isDesignationExpanded = !isDesignationExpanded;
                          });
                        },
                        child: isDesignationExpanded
                            ? Column(
                                children: designations.map((designation) {
                                  return CheckboxListTile(
                                    title: Text(designation),
                                    value: selectedDesignations
                                        .contains(designation),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedDesignations.add(designation);
                                        } else {
                                          selectedDesignations
                                              .remove(designation);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterItem(BuildContext context, String title,
      {required bool isExpanded,
      required VoidCallback onToggle,
      required Widget child}) {
    return Column(
      children: [
        ListTile(
          title: Text("By " + title),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: onToggle,
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: child,
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.filter_list),
      label: Text('Filter'),
      onPressed: _showFilterMenu,
    );
  }
}
