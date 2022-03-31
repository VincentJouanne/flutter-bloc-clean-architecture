import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbSd12X0a6bTFf6hq4uvUpdBDyc4QzZHI',
    appId: '1:535118340305:android:48c9e55f3cb857c77265f0',
    messagingSenderId: '535118340305',
    projectId: 'flutter-clean-architectu-fdaec',
    storageBucket: 'flutter-clean-architectu-fdaec.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8TFh9jRQqa5i0i_kFNPBiD4JRfPpdi1w',
    appId: '1:535118340305:ios:7a63e05713f799927265f0',
    messagingSenderId: '535118340305',
    projectId: 'flutter-clean-architectu-fdaec',
    storageBucket: 'flutter-clean-architectu-fdaec.appspot.com',
    iosClientId:
        '''535118340305-hh9rrssgmvvohbj2mt79th9br3goprtc.apps.googleusercontent.com''',
    iosBundleId: 'com.vincentj.fluttercleanarchitecture',
  );
}
