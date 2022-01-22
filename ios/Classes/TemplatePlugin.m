#import "TemplatePlugin.h"
#if __has_include(<template_plugin/template_plugin-Swift.h>)
#import <template_plugin/template_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "template_plugin-Swift.h"
#endif

@implementation TemplatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTemplatePlugin registerWithRegistrar:registrar];
}
@end
@implementation TemplatePlugin{
 int _numKeysDown;
  FLRSynthRef _synth;
}
- (instancetype)init {
  self = [super init];
  if (self) {
    _synth = FLRSynthCreate();
    FLRSynthStart(_synth);
  }
  return self;
}

- (void)dealloc {
  FLRSynthDestroy(_synth);
}
(void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS "
        stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"onKeyDown" isEqualToString:call.method]) {
    FLRSynthKeyDown(_synth, [call.arguments[0] intValue]);
    _numKeysDown += 1;
    result(@(_numKeysDown));
  } else if ([@"onKeyUp" isEqualToString:call.method]) {
    FLRSynthKeyUp(_synth, [call.arguments[0] intValue]);

    _numKeysDown -= 1;
    result(@(_numKeysDown));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

