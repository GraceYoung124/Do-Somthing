import 'package:do_something/boton_principal_page.dart';
import 'package:do_something/firebase_auth_controller.dart';
import 'package:do_something/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
        if (Get.find<AuthController>().userFirebase != null) {
          return BotonPrincipal();
        } else {
          return Login();
        }
      },
    );
  }
}
