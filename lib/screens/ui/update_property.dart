import 'package:baigiamasis/modules/update_property_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  const Item(this.name);
  final String name;
}

class UpdateProperty extends StatefulWidget {
  final documentId;
  final pavilion;
  final premiseNumber;
  final ammountToPay;

  UpdateProperty({
    @required this.documentId,
    @required this.pavilion,
    @required this.premiseNumber,
    @required this.ammountToPay,
  });
  @override
  _UpdatePropertyState createState() => _UpdatePropertyState();
}

class _UpdatePropertyState extends State<UpdateProperty> {
  Item pavilionName;
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

  bool isDisabledButton = false;
  String documentId;
  String pavilion;
  String premiseNumber;
  String ammountToPay;

  _UpdatePropertyState();

  void initState() {
    super.initState();
    documentId = widget.documentId;
    pavilion = widget.pavilion;
    premiseNumber = widget.premiseNumber;
    ammountToPay = widget.ammountToPay;
  }

  bool isButtonDisabled = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redaguoti duomenis'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
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
                        hint: Text(pavilion),
                        value: pavilionName,
                        onChanged: (Item value) {
                          setState(() {
                            pavilionName = value;
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
                      initialValue: premiseNumber,
                      onChanged: (value) {
                        premiseNumber = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Patalpos nr.",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: TextFormField(
                      initialValue: ammountToPay,
                      onChanged: (value) {
                        ammountToPay = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Mokestis",
                      ),
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
                                setState(() {
                                  isButtonDisabled = true;
                                });
                                bool navigate = await updateProperty(
                                  documentId,
                                  pavilionName.name,
                                  premiseNumber,
                                  ammountToPay,
                                );
                                if (navigate) {
                                  Navigator.pop(context);
                                }
                              },
                        child: Text('Patvirtinti'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
