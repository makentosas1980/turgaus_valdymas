import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/screens/ui/property_listing.dart';
import 'package:flutter/material.dart';

int selectedIndex = 0;

class ChooseMarketPage extends StatelessWidget {
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
  final _formKey = GlobalKey<FormState>();

  void onMarketChange(int index) {
    setState(() {
      selectedIndex = index;
      switch (selectedIndex) {
        case 0:
          marketPlaceName = sunMarket;
          break;
        case 1:
          marketPlaceName = winterMarket;
          break;
        case 2:
          marketPlaceName = freedomMarket;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  marketPlaceName,
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () {
                      marketPlaceName = sunMarket;
                      onMarketChange(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowProperties(
                              //pavilion: "Paieška",
                              ),
                        ),
                      );
                    },
                    child: Text(
                      'Saulės Turgus',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () {
                      marketPlaceName = winterMarket;
                      onMarketChange(1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowProperties(
                              //pavilion: "Paieška",
                              ),
                        ),
                      );
                    },
                    child: Text(
                      'Žiemos Turgus',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () {
                      marketPlaceName = freedomMarket;
                      onMarketChange(2);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowProperties(),
                        ),
                      );
                    },
                    child: Text(
                      'Laisvės Turgus',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
