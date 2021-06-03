import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/screens/ui/add_property.dart';
import 'package:baigiamasis/screens/ui/property_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Item {
  const Item(this.name);
  final String name;
}

class ShowProperties extends StatefulWidget {
  @override
  _ShowPropertiesState createState() => _ShowPropertiesState();
}

class _ShowPropertiesState extends State<ShowProperties> {
  Item pavilionName;
  bool isExecuted = false;
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

  final document = FirebaseFirestore.instance.collection(firestoreProperty);

  final currentMarketName =
      FirebaseFirestore.instance.collection(firestoreProperty);

  _ShowPropertiesState();

  void initState() {
    super.initState();
    isExecuted = false;
  }

  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(marketPlaceName),
        backgroundColor: Colors.blue,
        actions: [],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[300],
                  )),
              child: DropdownButton<Item>(
                isExpanded: true,
                underline: DropdownButtonHideUnderline(child: Container()),
                hint: Text("Išrušiuoti pagal"),
                value: pavilionName,
                onChanged: (Item value) {
                  setState(() {
                    pavilionName = value;
                    isExecuted = true;
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
          Container(
            color: Colors.blue[900],
            height: 52,
            child: ListTile(
              leading: Text(
                'ID',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                'Paviljonas',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          isExecuted
              ? Expanded(
                  child: StreamBuilder(
                    stream: document
                        .where('marketName', isEqualTo: marketPlaceName)
                        .where('pavilion', isEqualTo: pavilionName.name)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        List list = [];
                        for (var item in snapshot.data.docs) {
                          list.add(item);
                        }
                        //SORT ARRAY BY DATE
                        list.sort((a, b) {
                          return a['premiseNumber']
                              .toString()
                              .compareTo(b['premiseNumber'].toString());
                        });
                        return ListView.separated(
                          itemCount: list.length,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var property = list[index];
                            var _isRentPaid = '';
                            bool _isPaidStatus;
                            if (property['payments'].isEmpty) {
                              _isRentPaid = 'Nesumokėta';
                              _isPaidStatus = false;
                            }
                            for (var payment in property['payments']) {
                              if (currentDate == payment['date']) {
                                _isRentPaid = 'Sumokėta';
                                _isPaidStatus = true;
                              } else {
                                _isRentPaid = 'Nesumokėta';
                                _isPaidStatus = false;
                              }
                            }

                            return Dismissible(
                              background: Container(color: Colors.red),
                              key: ValueKey(list.elementAt(index)),
                              confirmDismiss: (direction) async {
                                try {
                                  await document
                                      .doc(list[index]['documentId'])
                                      .delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "NT objektas sėkmingai pašalintas."),
                                    ),
                                  );
                                  return true;
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Įvyko klaida, bandykite dar karta"),
                                    ),
                                  );
                                  return false;
                                }
                              },
                              child: _isPaidStatus
                                  ? ListTile(
                                      title: Text(list[index]['premiseNumber']),
                                      subtitle: Text(
                                        _isRentPaid,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(list[index]['pavilion']),
                                      onTap: () async {
                                        String documentId =
                                            list[index]['documentId'];
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyDetails(
                                                    documentId: documentId),
                                          ),
                                        );
                                      },
                                    )
                                  : ListTile(
                                      selected: false,
                                      tileColor: Colors.red[300],
                                      title: Text(list[index]['premiseNumber']),
                                      subtitle: Text(
                                        _isRentPaid,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(list[index]['pavilion']),
                                      onTap: () async {
                                        String documentId =
                                            list[index]['documentId'];
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyDetails(
                                                    documentId: documentId),
                                          ),
                                        );
                                      },
                                    ),
                            );
                          },
                        );
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              : Expanded(
                  child: StreamBuilder(
                    stream: document
                        .where('marketName', isEqualTo: marketPlaceName)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        List list = [];
                        for (var item in snapshot.data.docs) {
                          list.add(item);
                        }

                        return ListView.separated(
                          itemCount: list.length,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var property = list[index];
                            var _isRentPaid = '';
                            bool _isPaidStatus;
                            if (property['payments'].isEmpty) {
                              _isRentPaid = 'Nesumokėta';
                              _isPaidStatus = false;
                            }
                            for (var payment in property['payments']) {
                              if (currentDate == payment['date']) {
                                _isRentPaid = 'Sumokėta';
                                _isPaidStatus = true;
                              } else {
                                _isRentPaid = 'Nesumokėta';
                                _isPaidStatus = false;
                              }
                            }

                            return Dismissible(
                              background: Container(color: Colors.red),
                              key: ValueKey(list.elementAt(index)),
                              confirmDismiss: (direction) async {
                                try {
                                  setState(() {
                                    document
                                        .doc(list[index]['documentId'])
                                        .delete();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "NT objektas sėkmingai pašalintas."),
                                      ),
                                    );
                                  });

                                  return true;
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Įvyko klaida, bandykite dar karta"),
                                    ),
                                  );
                                  return false;
                                }
                              },
                              child: _isPaidStatus
                                  ? ListTile(
                                      title: Text(list[index]['premiseNumber']),
                                      subtitle: Text(
                                        _isRentPaid,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(list[index]['pavilion']),
                                      onTap: () async {
                                        String documentId =
                                            list[index]['documentId'];

                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyDetails(
                                                    documentId: documentId),
                                          ),
                                        );
                                      },
                                    )
                                  : ListTile(
                                      tileColor: Colors.red[300],
                                      title: Text(list[index]['premiseNumber']),
                                      subtitle: Text(
                                        _isRentPaid,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(list[index]['pavilion']),
                                      onTap: () async {
                                        String documentId =
                                            list[index]['documentId'];

                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyDetails(
                                                    documentId: documentId),
                                          ),
                                        );
                                      },
                                    ),
                            );
                          },
                        );
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProperty(),
            ),
          ).then((value) => ShowProperties());
        },
      ),
    );
  }
}
