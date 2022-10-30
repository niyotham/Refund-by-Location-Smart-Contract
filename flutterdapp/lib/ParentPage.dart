import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdapp/getMapLocation.dart';
import 'package:flutterdapp/parentModel.dart';
import 'package:provider/provider.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  final _fromKey_diag = GlobalKey<FormState>();
  String locationMessage = "No data yet";
  String lat_1 = "0.00";
  String lon_1 = "0.00";

  int itemCount = 0;

  late String _address;
  late int _latitude;
  late int _longitude;
  late int _maxRadius;
  late int _payAmount;
  late int _reqAmount;

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<parentModel>(context);
    listModel.getEmployees();
    List<dynamic> _employees = listModel.addresses;
    listModel.getEmployeeContractStatus(_employees);
    List _empStatusList = listModel.empStatusList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(169, 3, 3, 109),
        title: Text(
          "Employee List",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: IconButton(
              tooltip: 'Add',
              onPressed: () {
                cards();
              },
              icon: Icon(
                Icons.add,
                color: Color.fromARGB(255, 249, 161, 10),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (BuildContext context, int index) {
          var employee = _employees[index].toString();
          var empStatus = _empStatusList[index];

          return Ink(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(169, 3, 3, 109),
                  child: Text(
                    employee.substring(2, 4),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  employee,
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 220, 150, 11)),
                ),
                subtitle: Text(
                  "Radius: " +
                      empStatus[2].toString() +
                      ", Pay Amount: " +
                      empStatus[3].toString() +
                      ", Compliance Count: " +
                      empStatus[4].toString(),
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 121, 9, 108)),
                ),
                trailing: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          getMapLocation(
                              empStatus[0].toString(), empStatus[1].toString());
                        },
                        icon: Icon(
                          Icons.location_pin,
                          color: Colors.redAccent,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.edit_sharp),
                      // )
                    ]),
              ),
            ),
          );
          // ListTile(
          //   title: Text(employee),
          //   subtitle: IconButton(
          //     icon: Icon(Icons.location_pin),
          //     onPressed: () async {},
          //   ),
          // );
        },
      ),
    );
  }

  cards() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var listModel = Provider.of<parentModel>(context);
        return AlertDialog(
          title: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Register Employee',
              style: TextStyle(fontSize: 20),
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _fromKey_diag,
              child: ListBody(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    onChanged: (String value) {
                      _address = (value);
                    },
                    decoration: const InputDecoration(
                        // icon:
                        labelText: 'Address/Public Key'),
                    onSaved: (String? value) {
                      _address = (value!);
                    },
                    validator: (String? value) {
                      if (value != null && value.contains("@")) {
                        return 'Do not use the @ char';
                      }
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    onChanged: (String value) {
                      _longitude = int.parse(value);
                    },
                    decoration: const InputDecoration(
                        // icon: ImageIcon(),
                        labelText: 'Longitude'),
                    onSaved: (String? value) {
                      _longitude = int.parse(value!);
                    },
                    validator: (String? value) {
                      if (value != null && value.contains("@")) {
                        return 'Do not use the @ char';
                      }
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    onChanged: (String value) {
                      _latitude = int.parse(value);
                    },
                    decoration: const InputDecoration(
                        // icon:
                        labelText: 'Latitude'),
                    onSaved: (String? value) {
                      _latitude = int.parse(value!);
                    },
                    validator: (String? value) {
                      if (value != null && value.contains("@")) {
                        return 'Do not use the @ char';
                      }
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    onChanged: (String value) {
                      _maxRadius = int.parse(value);
                    },
                    decoration: const InputDecoration(
                        // icon:
                        labelText: 'Radius'),
                    onSaved: (String? value) {
                      _maxRadius = int.parse(value!);
                    },
                    validator: (String? value) {
                      if (value != null && value.contains("@")) {
                        return 'Do not use the @ char';
                      }
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    onChanged: (String value) {
                      _payAmount = int.parse(value);
                    },
                    decoration: const InputDecoration(
                        // icon:
                        labelText: 'Payment Amount'),
                    onSaved: (String? value) {
                      _payAmount = int.parse(value!);
                    },
                    validator: (String? value) {
                      if (value != null && value.contains("@")) {
                        return 'Do not use the @ char';
                      }
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    onChanged: (String value) {
                      _reqAmount = int.parse(value);
                    },
                    decoration: const InputDecoration(
                        // icon:
                        labelText: 'Request Amount'),
                    onSaved: (String? value) {
                      _reqAmount = int.parse(value!);
                    },
                    validator: (String? value) {
                      if (value != null && value.contains("@")) {
                        return 'Do not use the @ char';
                      }
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                )
              ]),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                listModel.setEmployee(
                  _address,
                  _latitude,
                  _longitude,
                  _maxRadius,
                  _payAmount,
                  _reqAmount,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
