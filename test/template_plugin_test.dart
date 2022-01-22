import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template_plugin/template_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('template_plugin');

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
    expect(await TemplatePlugin.platformVersion, '42');
  });
}
