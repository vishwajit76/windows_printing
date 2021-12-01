import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windows_printing/windows_printing.dart';

void main() {
  const MethodChannel channel = MethodChannel('windows_printing');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('printersList', () async {
    expect(await WindowsPrinting.printersList, '42');
  });
}
