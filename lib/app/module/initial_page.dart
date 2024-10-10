import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              Modular.to.pushNamed('/home');
            },
            child: const Text('Começar!'),
          ),
        ),
      ),
    );
  }
}
