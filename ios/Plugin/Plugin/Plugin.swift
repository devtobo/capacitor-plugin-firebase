import Foundation
import Capacitor

import FirebaseCore
import FirebaseAnalytics
import Crashlytics


typealias JSObject = [String:Any]

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(CAPFirebasePlugin)
public class CAPFirebasePlugin: CAPPlugin {
    
    public override func load() {
        FirebaseApp.configure()
    }
    
    @objc func logEvent(_ call: CAPPluginCall) {
        let name = call.getString("name") ?? nil
        let params = call.getObject("parameters") ?? nil
        
        if let eventName = name {
            print("LogEvent: name=", eventName, " params=", params!)
            Analytics.logEvent(eventName, parameters: params)
        }
        else {
            NSLog("Cannot call logEvent without event name")
        }
        
    }
    
    @objc func sendJavascriptError(_ call: CAPPluginCall) {
        
        let message = call.getString("message", "__no_message__")
        let stackTrace = call.getArray("stackTrace", JSObject.self, [])
        
        var stackFrames: [CLSStackFrame] = []
        
        for trace in stackTrace! {
            let sf = CLSStackFrame.init(symbol: trace["functionName"] as! String)
            sf.fileName = trace["fileName"] as? String ?? ""
            sf.lineNumber = trace["lineNumber"] as? UInt32 ?? 0
            sf.offset = trace["columnNumber"] as? UInt64 ?? 0
            stackFrames.append(sf)
        }
        
        Crashlytics.sharedInstance().recordCustomExceptionName("JavascriptError", reason: message, frameArray: stackFrames)
    }
}
