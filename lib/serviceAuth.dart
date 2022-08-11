import 'package:biometric/security_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

final LocalAuthentication auth = LocalAuthentication();

class ServiceAuth {
  autheticate(context) async {
    await getListAuthenticateType();
    if (await verifySupport(context)) {
      await localAuthenticate(context);
    }
  }

  verifySupport(context) async {
    bool isBiometricSupported = await auth.isDeviceSupported();
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (isBiometricSupported && canCheckBiometrics) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getListAuthenticateType() async {
    List<BiometricType> listAuthenticateType = await auth.getAvailableBiometrics();
  }

  localAuthenticate(context) async {
    bool isAuthenticated = false;

    while (true) {
      try {
        isAuthenticated = await auth.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: authenticationOptions,
            authMessages: const [androidStrings, iosStrings]);
      } on PlatformException catch (e) {
        print('Segue o Erro => ${e}');
        return false;
      }

      if (isAuthenticated) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage()));
        break;
      }
    }
  }

  static const androidStrings = AndroidAuthMessages(
      signInTitle: "Authenticate for Login",
      cancelButton: 'Cancel',
      goToSettingsButton: 'Settings',
      goToSettingsDescription: 'Please register your Fingerprint');

  static const iosStrings = IOSAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      lockOut: 'Please reenable your Touch ID');

  static const authenticationOptions =
      AuthenticationOptions(biometricOnly: true, sensitiveTransaction: true, useErrorDialogs: false, stickyAuth: true);
}
