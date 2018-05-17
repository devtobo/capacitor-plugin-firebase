import Foundation
import Capacitor

import FirebaseCore
import FirebaseAnalytics

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
}
