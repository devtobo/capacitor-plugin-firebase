import Foundation
import Capacitor
import UserNotifications

import FirebaseCore
import FirebaseAnalytics
import Crashlytics
import FirebaseMessaging

typealias JSObject = [String:Any]

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(CAPFirebasePlugin)
public class CAPFirebasePlugin: CAPPlugin, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    public override func load() {
        FirebaseApp.configure()

        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
    }
    
    @objc func logEvent(_ call: CAPPluginCall) {
        let name = call.getString("name") ?? nil
        let params = call.getObject("parameters") ?? nil
        
        if let eventName = name {
//            print("LogEvent: name=", eventName, " params=", params!)
            Analytics.logEvent(eventName, parameters: params)
        }
        else {
            call.error("Must provide event name")
            return
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
    
    @objc func registerForRemoteNotifications(_ call: CAPPluginCall) {
        
        DispatchQueue.main.async {
            
            let application = UIApplication.shared
        
            if #available(iOS 10.0, *) {
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }

            application.registerForRemoteNotifications()
        }
    }
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        NSLog("Received registration token: ", fcmToken)
    }
    public func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        NSLog("Received remote message: ", remoteMessage)
    }
    
}
