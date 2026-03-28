import 'package:bdm/controllers/auth_controller.dart';
import 'package:bdm/views/screens/app.dart';
import 'package:bdm/views/screens/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    verifyToken();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 120, end: 160).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: _animation.value,
              width: _animation.value,
            ),
            const SizedBox(height: 12),
            Text(
              "BDM",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: (28 * (_animation.value / 120)).toDouble(),
                height: 36 / 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyToken() async {
    final time = Stopwatch();
    time.start();
    bool isVerified = await Get.find<AuthController>().previouslyLoggedIn();

    if (time.elapsed < Duration(seconds: 2)) {
      await Future.delayed(Duration(seconds: 2) - time.elapsed);
    }

    if (isVerified) {
      Get.offAll(() => App(key: appKey));
    } else {
      Get.to(() => Welcome());
    }
  }
}
