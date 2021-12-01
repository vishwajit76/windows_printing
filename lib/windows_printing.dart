import 'dart:async';

import 'package:flutter/services.dart';

class WindowsPrinting {
  static const MethodChannel _channel = const MethodChannel('windows_printing');

  /// get printers name list
  /// Result: [["Printer 1","Printer 2"]]
  static Future<List<String>> get printersList async {
    final String list = await _channel.invokeMethod('getPrintersList');
    return list.split(';');
  }

  /// print PDF file
  /// Result: "1" success else failed
  static Future<String> printPdf(String filePath, String printerName,
      {String pageNumber = "ALL_PAGES", bool landscape = false}) async {
    final String res =
        await _channel.invokeMethod('printPdf', <String, dynamic>{
      'path': filePath,
      'printer': printerName,
      'number': pageNumber,
      'orientation': landscape ? "LANDSCAPE_PAGE" : "PORTRAIT",
    });
    return res;
  }
}
