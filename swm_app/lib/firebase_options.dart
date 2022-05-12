// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyB2QPkkNhb0RmE_qGWnT_31LqZzxdG19gE',
    appId: '1:507564394822:web:3c63ad38c0aac47c1efd47',
    messagingSenderId: '507564394822',
    projectId: 'swm-app-de721',
    authDomain: 'swm-app-de721.firebaseapp.com',
    storageBucket: 'swm-app-de721.appspot.com',
    measurementId: 'G-P9HKH71P7P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOcLxur0GtACfVtWHyJPwpjkgvwGect-k',
    appId: '1:507564394822:android:e24c08be4637bbe91efd47',
    messagingSenderId: '507564394822',
    projectId: 'swm-app-de721',
    storageBucket: 'swm-app-de721.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKFoyP3SC0S5jNr537StPZPDyplLyRZC4',
    appId: '1:507564394822:ios:314f4a2fd7d185ab1efd47',
    messagingSenderId: '507564394822',
    projectId: 'swm-app-de721',
    storageBucket: 'swm-app-de721.appspot.com',
    iosClientId: '507564394822-rkufd8ln09ihitet0m207rgv7dbq8vpn.apps.googleusercontent.com',
    iosBundleId: 'com.example.swmApp',
  );
}
