# Install

`npm install --save github:devtobo/capacitor-plugin-firebase`

## For iOS

Download your GoogleService-Info.plist from Firebase and add it to the App folder in your Xcode project.

For Crashlytics, add this to the application Podfile (my-app/ios/App/Podfile) inside the "target App" block

```
# Firebase Crashlytics requires this script build-phase
script_phase :name => 'Firebase Crashlytics', :script => '"${PODS_ROOT}/../../../node_modules/capacitor-plugin-firebase/ios/FirebaseSDK/Crashlytics/Fabric.framework/run"'
```

For Push notifications, add your Auth Key to Firebase.
Open your project in Xcode and enable the "Push Notifications" Capability (select App in project navigator > TARGETS : App > Capabilities)

In AppDelegate.swift, add these two methods:

```
  // Inside the method > func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  // Add this line:
    CAPFirebasePlugin.instance()?.applicationDidFinishLaunchingWithOptions(launchOptions: launchOptions)
    
  // Add this method:
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    CAPFirebasePlugin.instance()?.applicationDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: deviceToken)
  }
```



## For Android

TBD

# API

Exemple usage:

### Analytics

`Capacitor.Plugins.Firebase.logEvent({name: "my_event", parameters: { foo: "bar", one: 1 }})`


### Messaging

```
Capacitor.Plugins.Firebase.registerForRemoteNotifications()
    .then((result) => {
        console.log("registerForRemoteNotifications result: ", result)
    })
    .catch((error) => {
        console.error("registerForRemoteNotifications error: ", error)
    })
```

### Crashlytics

```
var reportError = function (error) {
    // fileName is supported on some platforms but not all
    var fileName = error.fileName

    try {
        var stack = ErrorStackParser.parse(error)
        var stackJsonObj = stack.map(function (frame) {
            return {
                functionName: frame.functionName,
                fileName: frame.fileName,
                lineNumber: frame.lineNumber,
                columnNumber: frame.columnNumber,
            };
        })

        Firebase.sendJavascriptError({ message: error.message, stackTrace: stackJsonObj })
    } catch (error) {
        console.error('Caught an error in reportError handler: ', error)
    }
}

var errorHandler = function (errorEvent) {
    var error = errorEvent.error;
    reportError(error);
}

window.addEventListener('error', errorHandler);
```