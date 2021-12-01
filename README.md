# windows_printing

Windows PDF Printing plugin.

## Example

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:windows_printing/windows_printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _printerList = [];

  @override
  void initState() {
    super.initState();
    getPrinterList();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getPrinterList() async {
    List<String> printerList;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      printerList = await WindowsPrinting.printersList;
    } on PlatformException {
      printerList = [];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _printerList = printerList;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> printPdfFile(String filePath, String printerName) async {
    // Platform messages may fail, so we use a try/catch.
    try {
      String result = await WindowsPrinting.printPdf(filePath, printerName,landscape: true,pageNumber: 1);
      debugPrint("printPdfFile: " + result);
    } catch (err) {
      debugPrint("printPdfFile Error: " + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                color: Colors.black,
                child: Text(
                  'Printer List',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              for (String printerName in _printerList)
                FlatButton(
                  onPressed: () {
                    printPdfFile("sample.pdf", printerName);
                  },
                  child: Text('$printerName\n'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
```


