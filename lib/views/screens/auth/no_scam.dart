import 'package:flutter/material.dart';

class NoScam extends StatelessWidget {
  const NoScam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_money_rounded, size: 64, color: Colors.amberAccent,),
              Text(
                "Pay the Developers to unlock the app.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
