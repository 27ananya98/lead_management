import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lead_management/screen/lead_screen.dart';

import 'auth/auth_controller.dart';
import 'auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authController = Get.put(AuthController());
  await authController.loadLoginStatus();

  runApp(GetMaterialApp(
    title: "Leads Management",
    debugShowCheckedModeBanner: false,
    home: Obx(() => authController.isLoggedIn.value ? LeadScreen() : LoginScreen()),
  ));

}



