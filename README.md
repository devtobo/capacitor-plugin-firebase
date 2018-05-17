# Install

`npm install --save github:devtobo/capacitor-plugin-firebase`

## For iOS

Download your GoogleService-Info.plist from Firebase and add it to the App folder in your Xcode project.

## For Android

TBD

# API

Exemple usage:

`Capacitor.Plugins.Firebase.logEvent({name: "my_event", parameters: { foo: "bar", one: 1 }})`
