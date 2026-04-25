import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'controllers/app_bindings.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialBinding: AppBindings(),
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
