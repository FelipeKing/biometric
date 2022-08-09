import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class ServiceAuth {
  verifySupport() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool isBiometricSupported = await auth.isDeviceSupported();
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isAuthenticated = false;
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await auth.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
              biometricOnly: true,
              sensitiveTransaction: true,
              useErrorDialogs: false,
              stickyAuth: true,
            ));
      } on PlatformException catch (e) {
        print('Segue o Erro => ${e}');
      }
    }
    return isAuthenticated;
  }

  verifyCanLocalAuth() {
    final LocalAuthentication auth = LocalAuthentication();
    auth.canCheckBiometrics.then((value) => print("suporte biometria: $value"));
    auth.isDeviceSupported().then((value) => print("suporte PIN/Senha: $value"));
  }
}
