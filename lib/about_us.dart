import 'package:do_something/firebase_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'boton_principal_page.dart';

class ColorController extends GetxController {
  var normalBlanco = Color(0xFFFFFCF6).obs; //blanco
  var normalPurpura = Color(0xFF301744).obs; //purpura
}

class AboutUs extends GetWidget<AuthController> {
  ColorController cc = ColorController();

  AboutUs({Key? key}) : super(key: key);

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
              'About Us',
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
                  alignment: Alignment.topCenter,
                  color: cc.normalBlanco.value,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "DEV TEAM",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/jorge.jpg"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Jorge Mena",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 1,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/selfa.jpg"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Alejandro Selfa",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 1,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/eric.jpg"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Eric Marti",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/ximo.jpg"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Joaquín García",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 1,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/grace.jpg"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Grace Young",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 1,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/nadal.jpg"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Nadal Coret",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "DESIGN TEAM",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/beck.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Begoña Cardo",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 1,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/kate.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Ekaterina Matveeva",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 1,
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.0,
                                        color: cc.normalPurpura.value),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/silvi.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Silvia Castillo",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cc.normalPurpura.value,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        Text(
                          "Do Something is the result of a collaboration between Computer Science and Design students at the Polytechnic University of Valencia.\nYou can contact us at dosomethingxm03@gmail.com",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: cc.normalPurpura.value,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
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
