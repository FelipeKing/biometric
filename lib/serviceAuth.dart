import 'package:biometric/security_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

final LocalAuthentication auth = LocalAuthentication();

class ServiceAuth {
  authFast(context) async {
    autheticate(context);
    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      print("biometry");
    }
    if (availableBiometrics.contains(BiometricType.strong)) {
      print("strong");
    }
  }

  autheticate(context) async {
    // await getListAuthenticateType();
    await verifySupport(context);
  }

  verifySupport(context) async {
    // bool isBiometricSupported = await auth.isDeviceSupported();
    // bool canCheckBiometrics = await auth.canCheckBiometrics;
    // if (isBiometricSupported && canCheckBiometrics)
    await localAuthenticate(context);
  }

  Future<List<BiometricType>> getListAuthenticateType() async {
    List<BiometricType> listAuthenticateType = await auth.getAvailableBiometrics();
    return listAuthenticateType;
  }

  localAuthenticate(context) async {
    late bool isAuthenticated;
    try {
      isAuthenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: authenticationOptions,
          authMessages: const [androidStrings, iosStrings]);
    } on PlatformException catch (e) {
      print('Segue o Erro => ${e.message}');
    }
    if (isAuthenticated) {
      goToSecurityPage(context);
    }
  }

  void goToSecurityPage(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage()));

  static const androidStrings = AndroidAuthMessages(
      biometricHint: "biometricHint",
      biometricRequiredTitle: "biometricRequiredTitle",
      biometricNotRecognized: "biometricNotRecognized",
      biometricSuccess: "biometricSuccess",
      deviceCredentialsRequiredTitle: "deviceCredentialsRequiredTitle",
      deviceCredentialsSetupDescription: "deviceCredentialsSetupDescription",
      signInTitle: "signInTitle",
      cancelButton: 'cancelButton',
      goToSettingsButton: 'goToSettingsButton',
      goToSettingsDescription: 'goToSettingsDescription');

  static const iosStrings = IOSAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      lockOut: 'Please reenable your Touch ID');

  static const authenticationOptions =
      AuthenticationOptions(biometricOnly: false, useErrorDialogs: true, sensitiveTransaction: true, stickyAuth: true);
}
