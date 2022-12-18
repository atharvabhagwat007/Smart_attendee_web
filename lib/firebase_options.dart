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
        return macos;
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
    apiKey: 'AIzaSyBoqBkqmVdb_I8iKLxS8mGiKb75AJe7FD4',
    appId: '1:1066328693183:web:1a50a554c28f11d96f290a',
    messagingSenderId: '1066328693183',
    projectId: 'tusharproject-740b6',
    authDomain: 'tusharproject-740b6.firebaseapp.com',
    storageBucket: 'tusharproject-740b6.appspot.com',
    measurementId: 'G-LZLXW0EXXG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFPNStr76RGTRR2xDua9CT7XChse03lyM',
    appId: '1:1066328693183:android:0d3adcb50349cdb56f290a',
    messagingSenderId: '1066328693183',
    projectId: 'tusharproject-740b6',
    storageBucket: 'tusharproject-740b6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4BCOlnIHuY7zGQrnVMtZ_6HJPmdYgsyA',
    appId: '1:1066328693183:ios:60e99b73ad16aea96f290a',
    messagingSenderId: '1066328693183',
    projectId: 'tusharproject-740b6',
    storageBucket: 'tusharproject-740b6.appspot.com',
    androidClientId: '1066328693183-6virk0oq3jpg13n81gmt5ndafs985qfb.apps.googleusercontent.com',
    iosClientId: '1066328693183-d2921t28j00ogvli93dpfpb580kj72o5.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartAttendee',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4BCOlnIHuY7zGQrnVMtZ_6HJPmdYgsyA',
    appId: '1:1066328693183:ios:60e99b73ad16aea96f290a',
    messagingSenderId: '1066328693183',
    projectId: 'tusharproject-740b6',
    storageBucket: 'tusharproject-740b6.appspot.com',
    androidClientId: '1066328693183-6virk0oq3jpg13n81gmt5ndafs985qfb.apps.googleusercontent.com',
    iosClientId: '1066328693183-d2921t28j00ogvli93dpfpb580kj72o5.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartAttendee',
  );
}
