import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'boton_principal_page.dart';
import 'firebase_auth_controller.dart';

class ControllerButton extends GetxController {
  RxInt pIndex = 0.obs;
  var aux = 0xFFB9ACF1.obs;
}

class Tutorial extends GetWidget<AuthController> {
  PageController _viewController = PageController(initialPage: 0);
  PageController _control2 = PageController(initialPage: 0);
  ControllerButton ctrl = ControllerButton();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lexend',
        primaryColor: const Color(0xFF010101),
      ),
      home: Obx(()=>
         Scaffold(
          backgroundColor: Color(ctrl.aux.value),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageIndicatorContainer(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _viewController,
                      children: <Widget>[
                        Container(
                          color: Color(controller.morado),
                          child: Stack(
                            children: [
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.24,
                                left: MediaQuery.of(context).size.width * 0.25,
                                child: Row(
                                  children: [
                                    Text(" It's ",
                                        style: TextStyle(
                                            color: Color(controller.purpura),
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600)),
                                    DecoratedBox(
                                      child: Text(
                                        " time ",
                                        //style: TextStyle(fontWeight: FontWeight.bold)),
                                        style: TextStyle(
                                            color: Color(controller.naranja),
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      decoration: BoxDecoration(

                                        border: Border.all(
                                            width: 15.0,
                                            color: Color(controller.amarillo)),
                                        color: Color(controller.amarillo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                    Text(" to ",
                                        style: TextStyle(
                                            color: Color(controller.purpura),
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.31,
                                left: MediaQuery.of(context).size.width * 0.27,
                                child: DecoratedBox(
                                  child: Text(
                                    " discover ",
                                    //style: TextStyle(fontWeight: FontWeight.bold)),
                                    style: TextStyle(
                                        color: Color(controller.purpura),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 15.0,
                                        color: Color(controller.verde)),
                                    color: Color(controller.verde),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), //page1
                        Container(
                          color: Color(controller.naranja),
                          child: Stack(
                            children: [
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.1,
                                left: MediaQuery.of(context).size.width * 0.1,
                                child:
                                    const Text("I get",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32)),
                                  ),

                                   const Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height * 0.16,
                                    left: MediaQuery.of(context).size.width * 0.09,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 15.0,
                                            color: Color(controller.purpura)),
                                        color: Color(controller.purpura),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),

                                      child: Text(
                                        " smarter ",
                                          //textAlign: TextAlign.justify,
                                          style: TextStyle(
                                          color: Color(controller.morado),
                                          fontSize: 32,
                                        ),
                                      ),
                                    ),
                                  ),


                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.25,
                                left: MediaQuery.of(context).size.width * 0.65,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height: MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Image.asset("assets/caratriste.png"),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.35,
                                left: MediaQuery.of(context).size.width * 0.45,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height: MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Image.asset("assets/carafeliz.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), //page2
                        Container(
                          color: Color(controller.purpura),
                          child: Stack(
                            children: [
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.35,
                                left: MediaQuery.of(context).size.width * 0.2,
                                child: Column(children: [
                                   Text("Try the",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                          color: Color(controller.verde),
                                      )),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 15.0,
                                          color: Color(controller.morado)),
                                      color: Color(controller.morado),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Text(
                                      " mystery mode ",
                                      style: TextStyle(
                                        color: Color(controller.purpura),
                                        fontSize: 32,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.1,
                                left: MediaQuery.of(context).size.width * 0.6,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Center(
                                    child: Image.asset("assets/rayito.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), //page3
                      ],
                      //controller: controller,
                    ),
                    align: IndicatorAlign.bottom,
                    length: 3,
                    indicatorSpace: 20.0,
                    padding: const EdgeInsets.all(10),
                    indicatorColor: Color(controller.blanco),
                    indicatorSelectorColor: Color(controller.verde),
                    shape: IndicatorShape.circle(size: 12)),
                // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
                // shape: IndicatorShape.oval(size: Size(12, 8)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlidingUpPanel(
                  color: Color(controller.blanco),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  backdropColor: Color(controller.purpura),
                  backdropEnabled: false,
                  isDraggable: false,
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  panel: Container(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          alignment: Alignment.center,
                          child: Center(
                            child: PageView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _control2,
                                children:  <Widget>[
                                  const Center(
                                      child: Text(
                                    "Tired of being at home? It's time to\nDo Something today!",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF301744),
                                    ),
                                  )),
                                  Center(
                                    child: Column(
                                      children:  [
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                                        const Text(
                                          "I am smart. Everytime you like or\ndislike something, I get to know you\nbetter!",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF301744),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 40),
                                        ),
                                        Text(
                                          "Be patient! \nIt might take me some time to learn!",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(controller.morado),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "We will guide you to a secret place!\nBe careful and have fun!",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF301744),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                Obx(
                                () => Container(
                            child: botonIzquierda(context),
                )
              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color(controller.purpura),
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(() => BotonPrincipal());
                                },
                                child: const Text(
                                  'SKIP',
                                  style: TextStyle(
                                    color: Color(0xFFB9ACF1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  child: botonDerecha(context),

                                ),
                              ),
                            ]))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget botonIzquierda(BuildContext context) {
    if (ctrl.pIndex.value > 0) {
      return IconButton(
        icon: Icon(
          Icons.arrow_back_outlined,
          size: 35,
          color: Color(controller.purpura),
        ),
        onPressed: () async {
          int colorPantalla = 0;
          if(ctrl.aux.value == controller.morado){
            colorPantalla = 1;
          }
          else if(ctrl.aux.value == controller.naranja){
            colorPantalla = 2;
          }
          ctrl.aux.value = controller.blanco;

          if(ctrl.pIndex.value > 0) {
            ctrl.pIndex.value--;
            await _viewController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
            _control2.jumpToPage(ctrl.pIndex.value);
          }
          if(colorPantalla == 0){
            ctrl.aux.value = controller.naranja;
          }
          else if(colorPantalla == 1){
            ctrl.aux.value = controller.purpura;
          }
          else if(colorPantalla == 2){
            ctrl.aux.value = controller.morado;
          }

        },
        iconSize: 50,
      );
    } else {
      return SizedBox(width: MediaQuery.of(context).size.width * 0.108);
    }
  }

  Widget botonDerecha(BuildContext context) {
    if (ctrl.pIndex.value < 2) {
      return IconButton(
        icon: Icon(
          Icons.arrow_forward_outlined,
          size: 35,
          color: Color(controller.purpura),
        ),
        onPressed: () async {
          int colorPantalla = 0;
          if(ctrl.aux.value == controller.morado){
            colorPantalla = 1;
          }
          else if(ctrl.aux.value == controller.naranja){
            colorPantalla = 2;
          }
          ctrl.aux.value = controller.blanco;

          ctrl.pIndex.value++;
          await _viewController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
          //await Future.delayed(Duration(milliseconds: 1000));
          if(colorPantalla == 0){
            ctrl.aux.value = controller.morado;
          }
          else if(colorPantalla == 1){
            ctrl.aux.value = controller.naranja;
          }
          else if(colorPantalla == 2){
            ctrl.aux.value = controller.purpura;
          }
          _control2.jumpToPage(ctrl.pIndex.value);
        },
        iconSize: 50,
      );
    } else {
      return TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Get.to(() => BotonPrincipal());
        },
        child: const Text(
          'DONE',
          style: TextStyle(
            color: Color(0xFF301744),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }
  }
}
