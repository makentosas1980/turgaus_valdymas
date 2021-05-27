import 'package:baigiamasis/screens/ui/preview_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:io' show Platform;

class PrintReceipt extends StatefulWidget {
  final String marketNametoPrint;
  final String pavilionToPrint;
  final String premiseNumberToPrint;
  final String ammountToPayToPrint;
  final String dateToPrint;

  const PrintReceipt({
    Key key,
    this.marketNametoPrint,
    this.pavilionToPrint,
    this.premiseNumberToPrint,
    this.ammountToPayToPrint,
    this.dateToPrint,
  }) : super(key: key);

  @override
  _PrintReceiptState createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  _PrintReceiptState();
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  // ignore: unused_field
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  void initPrinter() {
    print('init printer');
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen(
      (event) {
        if (!mounted) return;
        setState(() => _devices = event);

        if (_devices.isEmpty)
          setState(
            () {
              _devicesMsg = 'No devices';
            },
          );
      },
    );
  }

  @override
  void initState() {
    if (Platform.isIOS) {
      print("iOS");
      initPrinter();
    } else {
      print("Android");
      bluetoothManager.state.listen(
        (val) {
          print("state = $val");
          if (!mounted) return;
          if (val == 12) {
            print('on');
            initPrinter();
          } else if (val == 10) {
            print('off');
            setState(() {
              _devicesMsg = 'Please enable bluetooth to print';
            });
          }
          print('state is $val');
        },
      );
    }
    super.initState();
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final myTicket = await _ticket(PaperSize.mm58);
    final result = await _printerManager.printTicket(myTicket);
    print(result);
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    final ticket = Ticket(paper);
    ticket.text(widget.dateToPrint);
    ticket.text(widget.marketNametoPrint);
    ticket.text(widget.pavilionToPrint);
    ticket.text(widget.premiseNumberToPrint);
    ticket.text(widget.ammountToPayToPrint);

    ticket.cut();
    return ticket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pasirinkite prietaisą"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        //inAsyncCall: "showSpinner",
        child: _devices.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, position) => ListTile(
                  onTap: () {
                    _startPrint(_devices[position]);
                  },
                  leading: Icon(Icons.print),
                  title: Text(_devices[position].name),
                  subtitle: Text(_devices[position].address),
                ),
                itemCount: _devices.length,
              )
            : Center(
                child: PreviewReceipt(
                  marketNametoPrint: widget.marketNametoPrint,
                  pavilionToPrint: widget.pavilionToPrint,
                  premiseNumberToPrint: widget.premiseNumberToPrint,
                  ammountToPayToPrint: widget.ammountToPayToPrint,
                  dateToPrint: widget.dateToPrint,
                ),
                // child: Text(
                //   _devicesMsg ?? 'Nepavyko rasti spausdintuvo',
                //   style: TextStyle(fontSize: 24),
                // ),
              ),
      ),
    );
  }
}
