Pod::Spec.new do |s|
  s.name = 'CapacitorPluginFirebase'
  s.version = '0.0.1'
  s.summary = 'Test Firebase plugin'
  s.license = 'MIT'
  s.homepage = 'none'
  s.author = 'Thomas Brian'
  s.source = { :git => '', :tag => s.version.to_s }
  s.source_files = 'ios/Plugin/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.public_header_files = 'ios/Plugin/Plugin/*.h'

  s.vendored_frameworks = 'ios/FirebaseSDK/Analytics/FirebaseCore.framework', 'ios/FirebaseSDK/Analytics/FirebaseAnalytics.framework', 'ios/FirebaseSDK/Analytics/FirebaseCoreDiagnostics.framework', 'ios/FirebaseSDK/Analytics/FirebaseInstanceID.framework', 'ios/FirebaseSDK/Analytics/FirebaseNanoPB.framework', 'ios/FirebaseSDK/Analytics/GoogleToolboxForMac.framework', 'ios/FirebaseSDK/Analytics/nanopb.framework', 'ios/FirebaseSDK/Crashlytics/Crashlytics.framework', 'ios/FirebaseSDK/Crashlytics/Fabric.framework', 'ios/FirebaseSDK/Messaging/FirebaseMessaging.framework', 'ios/FirebaseSDK/Messaging/Protobuf.framework'

  s.ios.deployment_target  = '10.0'
  s.dependency 'Capacitor'

  s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => "${PODS_TARGET_SRCROOT}/ios/FirebaseSDK/Analytics ${PODS_TARGET_SRCROOT}/ios/FirebaseSDK/Crashlytics", 
    'OTHER_LDFLAGS' => '-ObjC -lc++'
  }

end
