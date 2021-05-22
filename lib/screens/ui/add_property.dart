import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/modules/save_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  const Item(this.name);
  final String name;
}

String _message = '';

class AddProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pridėti NT objektą'),
      ),
      body: TextInputWidget(),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
      'Žuvies',
    ),
    const Item(
      'Mėsos',
    ),
    const Item(
      'Vaisiai/Daržovės',
    ),
    const Item(
      'Drabužiai',
    ),
    const Item(
      'Sodo prekės',
    ),
    const Item(
      'Gyvūnai',
    ),
    const Item(
      'Maisto produktai',
    ),
  ];

  String value;
  bool isButtonDisabled = false;

  TextEditingController _id = TextEditingController();
  TextEditingController _ammount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _id.dispose();
    _ammount.dispose();
    super.dispose();
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(_message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  marketPlaceName,
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[300],
                        )),
                    child: DropdownButton<Item>(
                      isExpanded: true,
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      hint: Text("Paviljonas"),
                      value: selectedUser,
                      onChanged: (Item value) {
                        setState(() {
                          selectedUser = value;
                          print(value.name);
                        });
                      },
                      items: users.map((Item user) {
                        return DropdownMenuItem<Item>(
                          value: user,
                          child: Text(
                            user.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: TextFormField(
                    autofocus: true,
                    controller: _id,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'identifikamvimo numeris',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Laukas negali būti tuščias';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: TextFormField(
                    controller: _ammount,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "nuomos suma",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Laukas negali būti tuščias';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor:
                              MaterialStateProperty.all(Colors.blueAccent)),
                      //disabledColor: Colors.grey,
                      onPressed: isButtonDisabled
                          ? null
                          : () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isButtonDisabled = true;
                                });
                                _message = await createProperty(
                                  marketPlaceName,
                                  selectedUser.name,
                                  _id.text,
                                  _ammount.text,
                                );
                                if ((_message) ==
                                    AuthMessage.addPropertyMessage) {
                                  Navigator.pop(context, _message);
                                } else {
                                  _showSnackbar(_message);
                                }
                              }
                            },
                      child: Text('Sukurti'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
