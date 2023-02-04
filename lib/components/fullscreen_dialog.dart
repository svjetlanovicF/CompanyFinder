import 'package:company_finder_app/components/multi_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/company_techonology.dart';
import '../services/http_service.dart';
import 'package:numberpicker/numberpicker.dart';
import '../models/company_filter.dart';

class FullscreenDialog extends StatefulWidget {
  CompanyFilter? filter;

  FullscreenDialog({this.filter, super.key});

  @override
  State<FullscreenDialog> createState() => _FullscreenDialogState();
}

class _FullscreenDialogState extends State<FullscreenDialog> {
  // var filter = CompanyFilter();
  static const List<String> list = ['any', '1-10', '10-50', '50-200', '200-500', '500-1k', '1k-5k', '5k-10k', '10k'];
  int currentValueForPicker = 20;
  String? activity = 'inactive';
  RangeValues currentRangeValues = const RangeValues(20, 40);
  int _currentHorizontalIntValue = 5;
  String? dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(widget.filter);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Search filter',
                    style: TextStyle(
                      color: Colors.greenAccent.shade400,
                      fontSize: 30.0,
                    ),
                  ),
                  TextFormField(
                    cursorColor: Colors.greenAccent.shade400,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 230, 118),
                      ),
                      focusColor: Color.fromARGB(255, 0, 230, 118),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 230, 118))),
                      labelText: 'City',
                    ),
                    onChanged: (value) {
                      widget.filter!.city = value;
                    },
                  ),
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //     border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Column(
              children: [
                Text(
                  'Number of employees',
                  style: TextStyle(
                      color: Colors.greenAccent.shade400, fontSize: 20),
                ),
                // NumberPicker(
                //     value: currentValueForPicker,
                //     minValue: 1,
                //     maxValue: 50,
                //     step: 1,
                //     haptics: true,
                //     onChanged: (value) => setState(() {
                //           currentValueForPicker = value;
                //           widget.filter!.numberOfEmployees = currentValueForPicker;

                //         })),
                // RangeSlider(
                //   inactiveColor: Colors.green.shade50,
                //   activeColor: Colors.greenAccent.shade400,
                //   values: currentRangeValues,
                //   max: 50,
                //   divisions: 5,
                //   labels: RangeLabels(
                //     currentRangeValues.start.round().toString(),
                //     currentRangeValues.end.round().toString(),
                //   ),
                //   onChanged: (RangeValues values) {
                //     setState(() {
                //       currentRangeValues = values;
                //     });
                //   },
                // )
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                  underline: Container(
                    height: 3,
                    color: Colors.greenAccent.shade400,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                      widget.filter!.numberOfEmployees = dropdownValue;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Divider(color: Colors.greenAccent.shade400),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Limit of results',
                  style: TextStyle(
                      color: Colors.greenAccent.shade400, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                NumberPicker(
                  value: _currentHorizontalIntValue,
                  minValue: 1,
                  maxValue: 10,
                  step: 1,
                  selectedTextStyle: TextStyle(color: Colors.greenAccent.shade400, fontSize: 20),
                  // itemHeight: 100,
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    _currentHorizontalIntValue = value;
                    widget.filter!.limitOfResult = _currentHorizontalIntValue;
                  }),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
