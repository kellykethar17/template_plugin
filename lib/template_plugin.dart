
import 'dart:async';

import 'package:flutter/services.dart';

class TemplatePlugin {
  static const MethodChannel _channel = MethodChannel('template_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int?> onKeyDown(int key) async {
    final int? numNotesOn = await _channel.invokeMethod('onKeyDown', [key]);
    return numNotesOn;
  }

  static Future<int?> onKeyUp(int key) async {
    final int? numNotesOn = await _channel.invokeMethod('onKeyUp', [key]);
    return numNotesOn;
  }
}
