// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBCLO_WcQmWYM0SToUHRQnUs1SltHadH1Q',
    appId: '1:496456317264:web:5b9ff62f8a62462a8a9455',
    messagingSenderId: '496456317264',
    projectId: 'ecom-cda48',
    authDomain: 'ecom-cda48.firebaseapp.com',
    databaseURL: 'https://ecom-cda48-default-rtdb.firebaseio.com',
    storageBucket: 'ecom-cda48.appspot.com',
    measurementId: 'G-E7GRJJPRBZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDs6Down_8jXmp6-nqXRcHELAH_7uzXNRM',
    appId: '1:496456317264:android:d5cff7290e0773038a9455',
    messagingSenderId: '496456317264',
    projectId: 'ecom-cda48',
    databaseURL: 'https://ecom-cda48-default-rtdb.firebaseio.com',
    storageBucket: 'ecom-cda48.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7OjdCb8Qs_wZm6LYwhvqkxT292IBZhVQ',
    appId: '1:496456317264:ios:88e796d97d70c0128a9455',
    messagingSenderId: '496456317264',
    projectId: 'ecom-cda48',
    databaseURL: 'https://ecom-cda48-default-rtdb.firebaseio.com',
    storageBucket: 'ecom-cda48.appspot.com',
    iosBundleId: 'com.example.gchat',
  );

}