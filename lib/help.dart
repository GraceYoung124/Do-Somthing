import 'package:do_something/firebase_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'boton_principal_page.dart';

class ColorController extends GetxController {
  var normalBlanco = Color(0xFFFFFCF6).obs; //blanco
  var normalPurpura = Color(0xFF301744).obs; //purpura
}

class Help extends GetWidget<AuthController> {
  ColorController cc = ColorController();

  Future cargaColores() async {
    await Future.delayed(const Duration(milliseconds: 1));
    if (controller.estado.value == 'Normal') {
      cc.normalBlanco.value = Color(0xFFFFFCF6);
      cc.normalPurpura.value = Color(0xFF301744);
    }
    if (controller.estado.value == 'Mystery') {
      cc.normalBlanco.value = Color(0xFF301744);
      cc.normalPurpura.value = Color(0xFFFFFCF6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: cc.normalBlanco.value,
            title: Text(
              'Help',
              style: TextStyle(
                  color: cc.normalPurpura.value,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Lexend'),
            ),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: cc.normalPurpura.value,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          backgroundColor: cc.normalBlanco.value,
          body: FutureBuilder(
            future: cargaColores(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center();
              } else {
                return Container(
                  alignment: Alignment.center,
                  color: cc.normalBlanco.value,
                  child: Text(
                    "If you need any help or\nwant to submit a bug report,\nplease contact us at:\ndosomethingxm03@gmail.com",textAlign: TextAlign.center,
                    style: TextStyle(

                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: cc.normalPurpura.value,
                      fontFamily: 'Lexend',
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
