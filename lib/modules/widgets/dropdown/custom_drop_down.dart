import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

class CustomDropdown extends StatefulWidget {
  final String defaultText;
  final List<String> items;
  final Function(String) onSelected;
  const CustomDropdown(
      {Key? key,
      required this.defaultText,
      required this.items,
      required this.onSelected})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedItem = '';

  @override
  void initState() {
    super.initState();
    selectedItem = widget.defaultText;
  }

  void _showBottomSheet(BuildContext context) {
    bool isTablet = size(context).width > 600;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: widget.items.map((item) {
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    selectedItem = item;
                  });
                  widget.onSelected(selectedItem);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showAlertBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AppText(
                "Select Item",
                bold: true,
              ),
              ...widget.items.map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      selectedItem = item;
                    });
                    widget.onSelected(selectedItem);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = size(context).width > 600;
    return GestureDetector(
      onTap: () =>
          isTablet ? _showAlertBox(context) : _showBottomSheet(context),
      child: Container(
        height: isTablet ? 80 : 50,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedItem),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
