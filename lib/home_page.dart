import 'package:biometric/security_page.dart';
import 'package:biometric/serviceAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ServiceAuth serviceAuth = ServiceAuth();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    serviceAuth.autheticate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
          onPressed: () async {
            await serviceAuth.autheticate(context);
          },
          child: const Text("Biometric"))
    ])));
  }
}

// void authenticate() async {
// final LocalAuthentication auth = LocalAuthentication();
// List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
//
// auth.canCheckBiometrics.then((value) => print("suporte biometria: $value"));
// auth.isDeviceSupported().then((value) => print("suporte PIN/Senha: $value"));
//
// setState(() {
//   var isAuthenticated = auth.authenticate(
//       localizedReason: 'Please complete the biometrics to proceed.',
//       options: const AuthenticationOptions(stickyAuth: true));
//
//   isAuthenticated
//       .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage())));
// });
// }
