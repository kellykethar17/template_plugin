package com.example.template_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.ArrayList


/** PluginCodelabPlugin  */
class TemplatePlugin : FlutterPlugin, MethodCallHandler {
  private var channel: MethodChannel? = null
  private var synth: Synth? = null
  @Override
  fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPluginBinding) {
    setup(this, flutterPluginBinding.getBinaryMessenger())
  }

  @Override
  fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE)
    } else if (call.method.equals("onKeyDown")) {
      try {
        val arguments: ArrayList = call.arguments as ArrayList
        val numKeysDown: Int = synth.keyDown(arguments.get(0) as Integer)
        result.success(numKeysDown)
      } catch (ex: Exception) {
        result.error("1", ex.getMessage(), ex.getStackTrace())
      }
    } else if (call.method.equals("onKeyUp")) {
      try {
        val arguments: ArrayList = call.arguments as ArrayList
        val numKeysDown: Int = synth.keyUp(arguments.get(0) as Integer)
        result.success(numKeysDown)
      } catch (ex: Exception) {
        result.error("1", ex.getMessage(), ex.getStackTrace())
      }
    } else {
      result.notImplemented()
    }
  }

  @Override
  fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding?) {
    channel.setMethodCallHandler(null)
  }

  companion object {
    private const val channelName = "plugin_codelab"
    private fun setup(plugin: TemplatePlugin, binaryMessenger: BinaryMessenger) {
      plugin.channel = MethodChannel(binaryMessenger, channelName)
      plugin.channel.setMethodCallHandler(plugin)
      plugin.synth = Synth()
      plugin.synth.start()
    }
  }
}
