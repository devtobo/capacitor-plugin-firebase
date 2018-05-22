#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(CAPFirebasePlugin, "Firebase",
           CAP_PLUGIN_METHOD(logEvent, CAPPluginReturnNone);
           
           CAP_PLUGIN_METHOD(sendJavascriptError, CAPPluginReturnNone);
           
           CAP_PLUGIN_METHOD(registerForRemoteNotifications, CAPPluginReturnNone);
)
