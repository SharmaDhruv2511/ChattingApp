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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzNkiUeFopA-v-5Ib2Z24PdDFWhqDxlLY',
    appId: '1:346449445292:android:1a20059f83451d3aefba09',
    messagingSenderId: '346449445292',
    projectId: 'puchat-4cf71',
    storageBucket: 'puchat-4cf71.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBItSE6HJWjF-zVZ8N4D-UmBTNdIgY6Zh8',
    appId: '1:346449445292:ios:6d41de2974d7c7c1efba09',
    messagingSenderId: '346449445292',
    projectId: 'puchat-4cf71',
    storageBucket: 'puchat-4cf71.appspot.com',
    androidClientId: '346449445292-ocb790k0pg5m989avci3ebo2714nep98.apps.googleusercontent.com',
    iosClientId: '346449445292-5v4qu8qasireneqsa38ra5uog9l0aph6.apps.googleusercontent.com',
    iosBundleId: 'com.example.messageapp',
  );
}
