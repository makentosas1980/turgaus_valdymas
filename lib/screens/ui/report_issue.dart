import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/modules/save_issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  const Item(this.name);
  final String name;
}

String _message = '';

class ReportIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextInputWidget(),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  Item _pavilion;
  List<Item> _pavilions = <Item>[
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
  TextEditingController _text = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _id.dispose();
    _text.dispose();
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
                    height: 88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[300],
                      ),
                    ),
                    child: DropdownButtonFormField<Item>(
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Laukas negali būti tuščias';
                        } else {
                          return null;
                        }
                      },
                      // underline:
                      //     DropdownButtonHideUnderline(child: Container()),
                      hint: Text("Paviljonas"),
                      value: _pavilion,
                      onChanged: (Item value) {
                        setState(
                          () {
                            _pavilion = value;
                            print(value.name);
                          },
                        );
                      },
                      items: _pavilions.map(
                        (Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Text(
                              user.name,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                      ).toList(),
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
                    controller: _text,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "žinutė",
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
                                setState(
                                  () {
                                    isButtonDisabled = true;
                                  },
                                );
                                _message = await createIssue(
                                  marketPlaceName,
                                  _pavilion.name,
                                  _id.text,
                                  _text.text,
                                );
                                if ((_message) == AuthMessage.addIssueMessage) {
                                  _showSnackbar(
                                    _message,
                                  );
                                  _id.clear();
                                  _text.clear();
                                } else {
                                  _showSnackbar(
                                    _message,
                                  );
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
