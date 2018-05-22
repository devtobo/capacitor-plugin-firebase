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

## For Android

TBD

# API

Exemple usage:

`Capacitor.Plugins.Firebase.logEvent({name: "my_event", parameters: { foo: "bar", one: 1 }})`
