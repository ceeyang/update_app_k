import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:update_app_k/update_app.dart';

void main() {
  const MethodChannel channel = MethodChannel('update_app');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await UpdateApp.platformVersion, '42');
  });
}
