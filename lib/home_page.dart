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
    serviceAuth.initBiometrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(onPressed: () async => {}, child: const Text("Biometric")),
      ElevatedButton(onPressed: () async => {}, child: const Text("Biometric")),
      ElevatedButton(onPressed: () async => serviceAuth.authFast(context), child: const Text("Biometric"))
    ])));
  }
}
