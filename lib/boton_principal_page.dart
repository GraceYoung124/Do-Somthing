import 'dart:ui';
import 'package:do_something/select_friends.dart';
import 'package:do_something/help.dart';
import 'package:lottie/lottie.dart';
import 'package:do_something/com_plan_page.dart';
import 'package:do_something/firebase_auth_controller.dart';
import 'package:do_something/friends_page.dart';
import 'package:do_something/perfil_page.dart';
import 'package:do_something/tutorial.dart';
import 'package:do_something/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_us.dart';
import 'mys_plan_page.dart';
import 'plan_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidersController extends GetxController {
  var _openValue = 0.0.obs;
  var _radiusValue = 2500.0.obs;
  var _ratingMinValue = 0.0.obs;
  var _ratingMaxValue = 5.0.obs;
  var _priceMinValue = 0.0.obs;
  var _priceMaxValue = 4.0.obs;
  var _isVisible = true.obs;
  var _isCompound = false.obs;
  var _nCompoundPlans = 2.0.obs;
  var _friendsValue = 0.0.obs;
}

class ButtonsOpenController extends GetxController {
  var _colorYesBackground = 0xFFFFFCF6.obs; //blanco
  var _borderYesBorder = 2.0.obs; //con borde
  var _colorYesText = 0xFF301744.obs; //purpura
  var _colorNoBackground = 0xFFED6134.obs; //naranja
  var _borderNoBorder = 0.0.obs; //sin borde
  var _colorNoText = 0xFFFFFCF6.obs; //blanco
}

class ButtonsFriendsController extends GetxController {
  var _colorYesBackground = 0xFFFFFCF6.obs; //blanco
  var _borderYesBorder = 2.0.obs; //con borde
  var _colorYesText = 0xFF301744.obs; //purpura
  var _colorNoBackground = 0xFFED6134.obs; //naranja
  var _borderNoBorder = 0.0.obs; //sin borde
  var _colorNoText = 0xFFFFFCF6.obs; //blanco
}

class ButtonsStopsController extends GetxController {
  var _color0Background = 0xFFED6134.obs; //naranja
  var _border0Border = 0.0.obs; //sin borde
  var _color0Text = 0xFFFFFCF6.obs; //blanco

  var _color2Background = 0xFFFFFCF6.obs; //blanco
  var _border2Border = 2.0.obs; //con borde
  var _color2Text = 0xFF301744.obs; //purpura
  var _color3Background = 0xFFFFFCF6.obs; //blanco
  var _border3Border = 2.0.obs; //con borde
  var _color3Text = 0xFF301744.obs; //purpura
  var _color4Background = 0xFFFFFCF6.obs; //blanco
  var _border4Border = 2.0.obs; //con borde
  var _color4Text = 0xFF301744.obs; //purpura
  var _color5Background = 0xFFFFFCF6.obs; //blanco
  var _border5Border = 2.0.obs; //con borde
  var _color5Text = 0xFF301744.obs; //purpura
}

class DropDownButtonController extends GetxController {
  var dropDownValue = "Normal".obs;
  var normalBlanco = 0xFFFFFCF6.obs; //blanco
  var normalPurpura = 0xFF301744.obs; //purpura
  var fondoDrawer = "fondo_drawer_blanco.png".obs;
  var botonDireccion = "assets/botonNormal.zip".obs;
  var botonVisible = true.obs;
  var friendAnonimousFilter = true.obs;
}

class BotonPrincipal extends GetWidget<AuthController> {
  TextEditingController keywordController = TextEditingController();
  TextEditingController killometersDistance = TextEditingController();
  SlidersController sliderController = SlidersController();
  ButtonsOpenController boc = ButtonsOpenController();
  ButtonsStopsController bsc = ButtonsStopsController();
  ButtonsFriendsController bfc = ButtonsFriendsController();
  PanelController pc = PanelController();
  DropDownButtonController ddbc = DropDownButtonController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late UserModel userFirestore;

  @override
  Widget build(BuildContext context) {
    // final panelHeightClosed = MediaQuery.of(context).size.height * 0.00;
    // final panelHeightOpen = MediaQuery.of(context).size.height * 0.65;

    return FutureBuilder(
        future: espera(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center();
          } else {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Obx(
                () => Scaffold(
                  key: _drawerKey,
                  appBar: AppBar(
                    backgroundColor: Color(ddbc.normalBlanco.value),
                    centerTitle: true,
                    title: Obx(
                      () => DropdownButton<String>(
                        dropdownColor: Color(ddbc.normalBlanco.value),
                        value: controller.estado.value,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            color: Color(ddbc.normalPurpura.value)),
                        underline: Container(
                          height: 2,
                          color: Color(ddbc.normalPurpura.value),
                        ),
                        onChanged: (String? newValue) {
                          controller.estado.value = newValue!;
                          actualizacionColores(newValue);
                        },
                        items: <String>[
                          'Normal',
                          'Mystery',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.menu,
                          color: Color(ddbc.normalPurpura.value)),
                      onPressed: () => _drawerKey.currentState!.openDrawer(),
                    ),
                    elevation: 0,
                  ),
                  drawer: Drawer(
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(ddbc.normalPurpura.value),
                          image: DecorationImage(
                            alignment: Alignment.topLeft,
                            image:
                                AssetImage("assets/" + ddbc.fondoDrawer.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: //ListView(
                            Column(
                          //shrinkWrap: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          //padding: const EdgeInsets.all(20.0),
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.only(top: 20),
                              leading: GestureDetector(
                                onTap: () {
                                  if (userFirestore.serviceLogin == "2") {
                                    Get.snackbar("Guest User",
                                        "You must be logged in to view your Profile",
                                        backgroundColor:
                                            Color(controller.amarillo),
                                        colorText: Color(controller.purpura),
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    Get.to(() => PerfilPage());
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(ddbc.normalPurpura.value),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(ddbc.normalPurpura.value),
                                      width: 2,
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(userFirestore.urlPhoto),
                                      //AssetImage('assets/unknown.png',),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Hi ' + userFirestore.name + '!',
                                style: TextStyle(
                                  color: Color(ddbc.normalPurpura.value),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: TextButton(
                                onPressed: () {
                                  if (userFirestore.serviceLogin == "2") {
                                    Get.snackbar("Guest User",
                                        "You must be logged in to view your Profile",
                                        backgroundColor:
                                        Color(controller.amarillo),
                                        colorText:
                                        Color(controller.purpura),
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    Get.to(() => PerfilPage());
                                  }
                                },
                                child: Text(
                                  'Account',
                                  style: TextStyle(
                                    color: Color(ddbc.normalPurpura.value),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 60),
                            ),
                            ListTile(
                              leading: TextButton(
                                onPressed: () {
                                  if (userFirestore.serviceLogin == "2") {
                                    Get.snackbar("Guest User",
                                        "You must be logged in to add Friends",
                                        backgroundColor:
                                        Color(controller.amarillo),
                                        colorText:
                                        Color(controller.purpura),
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    Get.to(() => FriendsPage());
                                  }
                                },
                                child: Text(
                                  'Friends',
                                  style: TextStyle(
                                    color: Color(ddbc.normalPurpura.value),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: TextButton(
                                onPressed: () {Get.to(()=>Help());},
                                child: Text(
                                  'Help    ',
                                  style: TextStyle(
                                    color: Color(ddbc.normalPurpura.value),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: TextButton(
                                onPressed: () {
                                  Get.to(() => AboutUs());
                                },
                                child: Text(
                                  'About Us',
                                  style: TextStyle(
                                    color: Color(ddbc.normalPurpura.value),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            ListTile(
                              //contentPadding: EdgeInsets.only(top: 50000),
                              minVerticalPadding: 20,
                              leading: TextButton(
                                onPressed: () {
                                  controller.logOut();
                                },
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    color: Color(controller.naranja),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => Visibility(
                          visible: sliderController._isVisible.value,
                          child: FloatingActionButton(
                              heroTag: "Ajustes",
                              onPressed: () {
                                pc.open();
                                sliderController._isVisible.value = false;
                              },
                              child: Icon(
                                Icons.tune,
                                color: Color(ddbc.normalBlanco.value),
                              ),
                              backgroundColor: Color(controller.naranja)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Obx(
                        () => Visibility(
                          visible: sliderController._isVisible.value,
                          child: FloatingActionButton(
                              heroTag: "Ayuda",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tutorial()));
                              },
                              child: Icon(
                                Icons.help_outline_rounded,
                                color: Color(controller.naranja),
                              ),
                              backgroundColor: Color(ddbc.normalBlanco.value)),
                        ),
                      ),
                    ],
                  ),
                  body: SafeArea(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Scaffold(
                            backgroundColor: Color(ddbc.normalBlanco.value),
                            body: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 450,
                                    height: 500,
                                    alignment: Alignment.center,
                                    /*
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(controller.blanco),
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              */
                                    child: GestureDetector(
                                      onTap: () {
                                        String keyword;
                                        if (keywordController.text.isNotEmpty) {
                                          keyword = keywordController.text;
                                        } else {
                                          keyword = "";
                                        }
                                        if (controller.estado.value ==
                                            'Normal') {
                                          if (!sliderController
                                              ._isCompound.value) {
                                            if (sliderController._friendsValue
                                                .value == 0.0) {
                                              List<String> friends = [];
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlanPage(
                                                            sliderController
                                                                ._radiusValue
                                                                .value
                                                                .toString(),
                                                            sliderController
                                                                ._ratingMinValue
                                                                .value
                                                                .toDouble(),
                                                            sliderController
                                                                ._ratingMaxValue
                                                                .value,
                                                            sliderController
                                                                ._priceMinValue
                                                                .value,
                                                            sliderController
                                                                ._priceMaxValue
                                                                .value,
                                                            sliderController
                                                                ._openValue
                                                                .value,
                                                            keywordController
                                                                .text,
                                                            friends)),
                                              );
                                            }
                                            else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectFriends(
                                                            sliderController
                                                                ._radiusValue
                                                                .value
                                                                .toString(),
                                                            sliderController
                                                                ._ratingMinValue
                                                                .value
                                                                .toDouble(),
                                                            sliderController
                                                                ._ratingMaxValue
                                                                .value,
                                                            sliderController
                                                                ._priceMinValue
                                                                .value,
                                                            sliderController
                                                                ._priceMaxValue
                                                                .value,
                                                            sliderController
                                                                ._openValue
                                                                .value,
                                                            keywordController
                                                                .text,
                                                            0,
                                                        0.0),
                                                  )
                                              );
                                            }
                                          } else {
                                            if (sliderController._friendsValue
                                                .value == 0.0) {
                                              List<String> friends = [];
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlanComPage(
                                                            sliderController
                                                                ._radiusValue
                                                                .value
                                                                .toString(),
                                                            sliderController
                                                                ._ratingMinValue
                                                                .value,
                                                            sliderController
                                                                ._ratingMaxValue
                                                                .value,
                                                            sliderController
                                                                ._priceMinValue
                                                                .value,
                                                            sliderController
                                                                ._priceMaxValue
                                                                .value,
                                                            sliderController
                                                                ._openValue
                                                                .value,
                                                            keywordController
                                                                .text,
                                                            sliderController
                                                                ._nCompoundPlans
                                                                .value,
                                                            friends)),
                                              );
                                            }
                                            else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectFriends(
                                                            sliderController
                                                                ._radiusValue
                                                                .value
                                                                .toString(),
                                                            sliderController
                                                                ._ratingMinValue
                                                                .value
                                                                .toDouble(),
                                                            sliderController
                                                                ._ratingMaxValue
                                                                .value,
                                                            sliderController
                                                                ._priceMinValue
                                                                .value,
                                                            sliderController
                                                                ._priceMaxValue
                                                                .value,
                                                            sliderController
                                                                ._openValue
                                                                .value,
                                                            keywordController
                                                                .text,
                                                            1,
                                                          sliderController._nCompoundPlans
                                                              .value), //Compound
                                                  ));
                                            }
                                          }
                                        } else if (controller.estado.value ==
                                            'Mystery') {
                                          if (sliderController._friendsValue
                                              .value == 0.0) {
                                            List<String> friends = [];
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanMysPage(
                                                          sliderController
                                                              ._radiusValue
                                                              .value
                                                              .toString(),
                                                          sliderController
                                                              ._ratingMinValue
                                                              .value,
                                                          sliderController
                                                              ._ratingMaxValue
                                                              .value,
                                                          sliderController
                                                              ._priceMinValue
                                                              .value,
                                                          sliderController
                                                              ._priceMaxValue
                                                              .value,
                                                          sliderController
                                                              ._openValue.value,
                                                          keywordController
                                                              .text, friends)),
                                            );
                                          }
                                          else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectFriends(
                                                          sliderController
                                                              ._radiusValue
                                                              .value
                                                              .toString(),
                                                          sliderController
                                                              ._ratingMinValue
                                                              .value
                                                              .toDouble(),
                                                          sliderController
                                                              ._ratingMaxValue
                                                              .value,
                                                          sliderController
                                                              ._priceMinValue
                                                              .value,
                                                          sliderController
                                                              ._priceMaxValue
                                                              .value,
                                                          sliderController
                                                              ._openValue.value,
                                                          keywordController
                                                              .text,
                                                          2,
                                                      0.0), //Mystery
                                                ));
                                          }
                                        }
                                      }, // handle your image tap here
                                      child: Lottie.asset(
                                          ddbc.botonDireccion.value),
                                      /*
                                      Image.asset(
                                        ddbc.botonDireccion.value,
                                        fit: BoxFit.cover, //
                                      ),
                                      */
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Let's do\nsomething\ngreat today!",
                                          style: TextStyle(
                                            color:
                                                Color(ddbc.normalPurpura.value),
                                            fontSize: 34,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SlidingUpPanel(
                          color: Color(ddbc.normalBlanco.value),
                          controller: pc,
                          slideDirection: SlideDirection.UP,
                          minHeight: 0,
                          maxHeight: MediaQuery.of(context).size.height * 0.73,
                          //backdropOpacity: 0.5,
                          //backdropColor: Colors.red,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(55)),
                          padding: const EdgeInsets.all(4.0),
                          onPanelOpened: () {
                            sliderController._isVisible.value = false;
                          },
                          onPanelClosed: () {
                            sliderController._isVisible.value = true;
                          },
                          panel: SafeArea(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                  ),
                                  Center(
                                    child: Container(
                                      width: 50,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  //FILTERS

                                  Text(
                                    '\nFilters',
                                    style: TextStyle(
                                      color: Color(ddbc.normalPurpura.value),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                  //KEYWORD
                                  TextFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color(ddbc.normalPurpura.value),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color(ddbc.normalPurpura.value),
                                        ),
                                      ),
                                      labelText: 'Keyword',
                                      labelStyle: TextStyle(
                                        color: Color(ddbc.normalPurpura.value),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Color(ddbc.normalPurpura.value),
                                    ),
                                    controller: keywordController,
                                  ),
                                  //DISTANCE
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Distance',
                                        style: TextStyle(
                                          color:
                                              Color(ddbc.normalPurpura.value),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          ((sliderController._radiusValue
                                                                  .toDouble() /
                                                              100)
                                                          .round() /
                                                      10)
                                                  .toString() +
                                              'km',
                                          style: TextStyle(
                                            color:
                                                Color(ddbc.normalPurpura.value),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor:
                                            Color(ddbc.normalPurpura.value),
                                        inactiveTrackColor: Colors.grey,
                                        trackHeight: 3.0,
                                        thumbColor: Color(controller.naranja),
                                        overlayColor:
                                            Colors.purple.withAlpha(32),
                                      ),
                                      child: Slider(
                                        value: sliderController._radiusValue
                                            .toDouble(),
                                        min: 1,
                                        max: 20000,
                                        divisions: 1000,
                                        onChanged: (double value) {
                                          sliderController._radiusValue.value =
                                              value;
                                        },
                                      ),
                                    ),
                                  ),
                                  //RATING
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rating',
                                        style: TextStyle(
                                          color:
                                              Color(ddbc.normalPurpura.value),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          sliderController._ratingMinValue.value
                                                  .round()
                                                  .toString() +
                                              '-' +
                                              sliderController
                                                  ._ratingMaxValue.value
                                                  .round()
                                                  .toString() +
                                              ' stars',
                                          style: TextStyle(
                                            color:
                                                Color(ddbc.normalPurpura.value),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor:
                                            Color(ddbc.normalPurpura.value),
                                        inactiveTrackColor: Colors.grey,
                                        trackHeight: 3.0,
                                        thumbColor: Color(controller.naranja),
                                        overlayColor:
                                            Colors.purple.withAlpha(32),
                                      ),
                                      child: RangeSlider(
                                        values: RangeValues(
                                            sliderController
                                                ._ratingMinValue.value
                                                .toDouble(),
                                            sliderController
                                                ._ratingMaxValue.value
                                                .toDouble()),
                                        min: 0,
                                        max: 5,
                                        divisions: 5,
                                        onChanged: (RangeValues values) {
                                          sliderController._ratingMinValue
                                              .value = values.start;
                                          sliderController._ratingMaxValue
                                              .value = values.end;
                                        },
                                      ),
                                    ),
                                  ),

                                  //Price
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          color:
                                              Color(ddbc.normalPurpura.value),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          getPrice(sliderController
                                                  ._priceMinValue.value
                                                  .round()) +
                                              '-' +
                                              getPrice(sliderController
                                                  ._priceMaxValue
                                                  .round()),
                                          style: TextStyle(
                                            color:
                                                Color(ddbc.normalPurpura.value),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor:
                                            Color(ddbc.normalPurpura.value),
                                        inactiveTrackColor: Colors.grey,
                                        trackHeight: 3.0,
                                        thumbColor: Color(controller.naranja),
                                        overlayColor:
                                            Colors.purple.withAlpha(32),
                                      ),
                                      child: RangeSlider(
                                        values: RangeValues(
                                            sliderController
                                                ._priceMinValue.value
                                                .toDouble(),
                                            sliderController
                                                ._priceMaxValue.value
                                                .toDouble()),
                                        min: 0,
                                        max: 4,
                                        divisions: 4,
                                        onChanged: (RangeValues values) {
                                          sliderController._priceMinValue
                                              .value = values.start;
                                          sliderController._priceMaxValue
                                              .value = values.end;
                                        },
                                      ),
                                    ),
                                  ),
                                  //Open now
                                  Text(
                                    'Hours',
                                    style: TextStyle(
                                      color: Color(ddbc.normalPurpura.value),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Obx(
                                        () => OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            backgroundColor: Color(
                                                boc._colorNoBackground.value),
                                            side: BorderSide(
                                              width: boc._borderNoBorder.value,
                                              color: Color(
                                                  ddbc.normalPurpura.value),
                                            ),
                                          ),
                                          onPressed: () {
                                            boc._colorNoBackground.value =
                                                controller.naranja;
                                            boc._colorNoText.value =
                                                controller.blanco;
                                            boc._borderNoBorder.value = 0.0;

                                            boc._colorYesBackground.value =
                                                ddbc.normalBlanco.value;
                                            boc._colorYesText.value =
                                                ddbc.normalPurpura.value;
                                            boc._borderYesBorder.value = 2.0;

                                            sliderController._openValue.value =
                                                0.0;
                                          },
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                              color:
                                                  Color(boc._colorNoText.value),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                      ),
                                      Obx(
                                        () => OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            backgroundColor: Color(
                                                boc._colorYesBackground.value),
                                            side: BorderSide(
                                              width: boc._borderYesBorder.value,
                                              color: Color(
                                                  ddbc.normalPurpura.value),
                                            ),
                                          ),
                                          onPressed: () {
                                            boc._colorYesBackground.value =
                                                controller.naranja;
                                            boc._colorYesText.value =
                                                controller.blanco;
                                            boc._borderYesBorder.value = 0.0;

                                            boc._colorNoBackground.value =
                                                ddbc.normalBlanco.value;
                                            boc._colorNoText.value =
                                                ddbc.normalPurpura.value;
                                            boc._borderNoBorder.value = 2.0;

                                            sliderController._openValue.value =
                                                1.0;
                                          },
                                          child: Text(
                                            'Open Now',
                                            style: TextStyle(
                                              color: Color(
                                                  boc._colorYesText.value),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: ddbc.botonVisible.value,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Composite Plan',
                                          style: TextStyle(
                                            color:
                                                Color(ddbc.normalPurpura.value),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //0
                                            Obx(
                                              () => OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(bsc
                                                      ._color0Background.value),
                                                  side: BorderSide(
                                                    width: bsc
                                                        ._border0Border.value,
                                                    color: Color(ddbc
                                                        .normalPurpura.value),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bsc._color0Background.value =
                                                      controller.naranja;
                                                  bsc._border0Border.value =
                                                      0.0;
                                                  bsc._color0Text.value =
                                                      controller.blanco;

                                                  bsc._color2Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border2Border.value =
                                                      2.0;
                                                  bsc._color2Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color3Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border3Border.value =
                                                      2.0;
                                                  bsc._color3Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color4Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border4Border.value =
                                                      2.0;
                                                  bsc._color4Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color5Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border5Border.value =
                                                      2.0;

                                                  bsc._color5Text.value =
                                                      ddbc.normalPurpura.value;
                                                  sliderController._isCompound
                                                      .value = false;
                                                },
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    color: Color(
                                                        bsc._color0Text.value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //2
                                            Obx(
                                              () => OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(bsc
                                                      ._color2Background.value),
                                                  side: BorderSide(
                                                    width: bsc
                                                        ._border2Border.value,
                                                    color: Color(ddbc
                                                        .normalPurpura.value),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bsc._color2Background.value =
                                                      controller.naranja;
                                                  bsc._border2Border.value =
                                                      0.0;
                                                  bsc._color2Text.value =
                                                      controller.blanco;

                                                  bsc._color0Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border0Border.value =
                                                      2.0;
                                                  bsc._color0Text.value =
                                                      ddbc.normalPurpura.value;

                                                  bsc._color3Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border3Border.value =
                                                      2.0;
                                                  bsc._color3Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color4Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border4Border.value =
                                                      2.0;
                                                  bsc._color4Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color5Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border5Border.value =
                                                      2.0;
                                                  bsc._color5Text.value =
                                                      ddbc.normalPurpura.value;

                                                  sliderController
                                                      ._isCompound.value = true;
                                                  sliderController
                                                      ._nCompoundPlans
                                                      .value = 2;
                                                },
                                                child: Text(
                                                  '2',
                                                  style: TextStyle(
                                                    color: Color(
                                                        bsc._color2Text.value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //3
                                            Obx(
                                              () => OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(bsc
                                                      ._color3Background.value),
                                                  side: BorderSide(
                                                    width: bsc
                                                        ._border3Border.value,
                                                    color: Color(ddbc
                                                        .normalPurpura.value),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bsc._color3Background.value =
                                                      controller.naranja;
                                                  bsc._border3Border.value =
                                                      0.0;
                                                  bsc._color3Text.value =
                                                      controller.blanco;

                                                  bsc._color2Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border2Border.value =
                                                      2.0;
                                                  bsc._color2Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color0Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border0Border.value =
                                                      2.0;
                                                  bsc._color0Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color4Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border4Border.value =
                                                      2.0;
                                                  bsc._color4Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color5Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border5Border.value =
                                                      2.0;
                                                  bsc._color5Text.value =
                                                      ddbc.normalPurpura.value;

                                                  sliderController
                                                      ._isCompound.value = true;
                                                  sliderController
                                                      ._nCompoundPlans
                                                      .value = 3;
                                                },
                                                child: Text(
                                                  '3',
                                                  style: TextStyle(
                                                    color: Color(
                                                        bsc._color3Text.value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //4
                                            Obx(
                                              () => OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(bsc
                                                      ._color4Background.value),
                                                  side: BorderSide(
                                                    width: bsc
                                                        ._border4Border.value,
                                                    color: Color(ddbc
                                                        .normalPurpura.value),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bsc._color4Background.value =
                                                      controller.naranja;
                                                  bsc._border4Border.value =
                                                      0.0;
                                                  bsc._color4Text.value =
                                                      controller.blanco;

                                                  bsc._color2Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border2Border.value =
                                                      2.0;
                                                  bsc._color2Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color3Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border3Border.value =
                                                      2.0;
                                                  bsc._color3Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color0Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border0Border.value =
                                                      2.0;
                                                  bsc._color0Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color5Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border5Border.value =
                                                      2.0;
                                                  bsc._color5Text.value =
                                                      ddbc.normalPurpura.value;

                                                  sliderController
                                                      ._isCompound.value = true;
                                                  sliderController
                                                      ._nCompoundPlans
                                                      .value = 4;
                                                },
                                                child: Text(
                                                  '4',
                                                  style: TextStyle(
                                                    color: Color(
                                                        bsc._color4Text.value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //5
                                            Obx(
                                              () => OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(bsc
                                                      ._color5Background.value),
                                                  side: BorderSide(
                                                    width: bsc
                                                        ._border5Border.value,
                                                    color: Color(ddbc
                                                        .normalPurpura.value),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bsc._color5Background.value =
                                                      controller.naranja;
                                                  bsc._border5Border.value =
                                                      0.0;
                                                  bsc._color5Text.value =
                                                      controller.blanco;

                                                  bsc._color2Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border2Border.value =
                                                      2.0;
                                                  bsc._color2Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color3Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border3Border.value =
                                                      2.0;
                                                  bsc._color3Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color4Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border4Border.value =
                                                      2.0;
                                                  bsc._color4Text.value =
                                                      ddbc.normalPurpura.value;
                                                  bsc._color0Background.value =
                                                      ddbc.normalBlanco.value;
                                                  bsc._border0Border.value =
                                                      2.0;
                                                  bsc._color0Text.value =
                                                      ddbc.normalPurpura.value;

                                                  sliderController
                                                      ._isCompound.value = true;
                                                  sliderController
                                                      ._nCompoundPlans
                                                      .value = 5;
                                                },
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                    color: Color(
                                                        bsc._color5Text.value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                              Visibility(
                                    visible: ddbc.friendAnonimousFilter.value,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Friends',
                                          style: TextStyle(
                                            color: Color(ddbc.normalPurpura.value),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(
                                                      bfc._colorNoBackground.value),
                                                  side: BorderSide(
                                                    width: bfc._borderNoBorder.value,
                                                    color: Color(
                                                        ddbc.normalPurpura.value),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bfc._colorNoBackground.value =
                                                      controller.naranja;
                                                  bfc._colorNoText.value =
                                                      controller.blanco;
                                                  bfc._borderNoBorder.value = 0.0;

                                                  bfc._colorYesBackground.value =
                                                      ddbc.normalBlanco.value;
                                                  bfc._colorYesText.value =
                                                      ddbc.normalPurpura.value;
                                                  bfc._borderYesBorder.value = 2.0;

                                          sliderController._friendsValue.value =
                                              0.0;
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color:
                                                Color(bfc._colorNoText.value),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                    ),
                                    Obx(
                                      () => OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Color(
                                              bfc._colorYesBackground.value),
                                          side: BorderSide(
                                            width: bfc._borderYesBorder.value,
                                            color:
                                                Color(ddbc.normalPurpura.value),
                                          ),
                                        ),
                                        onPressed: () {
                                          bfc._colorYesBackground.value =
                                              controller.naranja;
                                          bfc._colorYesText.value =
                                              controller.blanco;
                                          bfc._borderYesBorder.value = 0.0;

                                                  bfc._colorNoBackground.value =
                                                      ddbc.normalBlanco.value;
                                                  bfc._colorNoText.value =
                                                      ddbc.normalPurpura.value;
                                                  bfc._borderNoBorder.value = 2.0;

                                          sliderController._friendsValue.value =
                                              1.0;
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            color:
                                                Color(bfc._colorYesText.value),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                              ),
                      ),
                      /*Scaffold(

                    body: FloatingActionButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: const Icon(Icons.navigation),
                      backgroundColor: Colors.green,
                    ),
                    floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                  ),*/
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

  String getPrice(int p) {
    String aux = '';
    if (p == 0) {
      return 'Free';
    }

    for (int i = 0; i < p; i++) {
      aux += '€';
    }
    return aux;
  }

  Future espera(BuildContext context) async {
    userFirestore = await controller.getFireStoreUser();
    if(userFirestore.serviceLogin == "2"){ddbc.friendAnonimousFilter.value = false;}
    actualizacionColores(controller.estado.value);
  }

  actualizacionColores(String estado) {

    if (estado == 'Normal') {
      ddbc.botonVisible.value = true;
      ddbc.normalBlanco.value = controller.blanco;
      ddbc.normalPurpura.value = controller.purpura;
      ddbc.fondoDrawer.value = "fondo_drawer_blanco.png";
      ddbc.botonDireccion.value = 'assets/botonNormal.zip';
    }
    if (estado == 'Mystery') {
      ddbc.botonVisible.value = false;
      ddbc.botonDireccion.value = 'assets/botonMistery.zip';
      ddbc.normalBlanco.value = controller.purpura;
      ddbc.normalPurpura.value = controller.blanco;
      ddbc.fondoDrawer.value = "fondo_drawer_purpura.png";
    }
    if (boc._colorYesBackground.value == controller.naranja) {
      boc._colorNoBackground.value = ddbc.normalBlanco.value;
      boc._colorNoText.value = ddbc.normalPurpura.value;
    }
    if (boc._colorNoBackground.value == controller.naranja) {
      boc._colorYesBackground.value = ddbc.normalBlanco.value;
      boc._colorYesText.value = ddbc.normalPurpura.value;
    }
    if (bfc._colorYesBackground.value == controller.naranja) {
      bfc._colorNoBackground.value = ddbc.normalBlanco.value;
      bfc._colorNoText.value = ddbc.normalPurpura.value;
    }
    if (bfc._colorNoBackground.value == controller.naranja) {
      bfc._colorYesBackground.value = ddbc.normalBlanco.value;
      bfc._colorYesText.value = ddbc.normalPurpura.value;
    }
    if (bsc._color0Background.value == controller.naranja) {
      bsc._color2Background.value = ddbc.normalBlanco.value;
      bsc._color2Text.value = ddbc.normalPurpura.value;
      bsc._color3Background.value = ddbc.normalBlanco.value;
      bsc._color3Text.value = ddbc.normalPurpura.value;
      bsc._color4Background.value = ddbc.normalBlanco.value;
      bsc._color4Text.value = ddbc.normalPurpura.value;
      bsc._color5Background.value = ddbc.normalBlanco.value;
      bsc._color5Text.value = ddbc.normalPurpura.value;
    }
    if (bsc._color2Background.value == controller.naranja) {
      bsc._color0Background.value = ddbc.normalBlanco.value;
      bsc._color0Text.value = ddbc.normalPurpura.value;
      bsc._color3Background.value = ddbc.normalBlanco.value;
      bsc._color3Text.value = ddbc.normalPurpura.value;
      bsc._color4Background.value = ddbc.normalBlanco.value;
      bsc._color4Text.value = ddbc.normalPurpura.value;
      bsc._color5Background.value = ddbc.normalBlanco.value;
      bsc._color5Text.value = ddbc.normalPurpura.value;
    }
    if (bsc._color3Background.value == controller.naranja) {
      bsc._color0Background.value = ddbc.normalBlanco.value;
      bsc._color0Text.value = ddbc.normalPurpura.value;
      bsc._color2Background.value = ddbc.normalBlanco.value;
      bsc._color2Text.value = ddbc.normalPurpura.value;
      bsc._color4Background.value = ddbc.normalBlanco.value;
      bsc._color4Text.value = ddbc.normalPurpura.value;
      bsc._color5Background.value = ddbc.normalBlanco.value;
      bsc._color5Text.value = ddbc.normalPurpura.value;
    }
    if (bsc._color4Background.value == controller.naranja) {
      bsc._color0Background.value = ddbc.normalBlanco.value;
      bsc._color0Text.value = ddbc.normalPurpura.value;
      bsc._color2Background.value = ddbc.normalBlanco.value;
      bsc._color2Text.value = ddbc.normalPurpura.value;
      bsc._color3Background.value = ddbc.normalBlanco.value;
      bsc._color3Text.value = ddbc.normalPurpura.value;
      bsc._color5Background.value = ddbc.normalBlanco.value;
      bsc._color5Text.value = ddbc.normalPurpura.value;
    }
    if (bsc._color5Background.value == controller.naranja) {
      bsc._color0Background.value = ddbc.normalBlanco.value;
      bsc._color0Text.value = ddbc.normalPurpura.value;
      bsc._color2Background.value = ddbc.normalBlanco.value;
      bsc._color2Text.value = ddbc.normalPurpura.value;
      bsc._color3Background.value = ddbc.normalBlanco.value;
      bsc._color3Text.value = ddbc.normalPurpura.value;
      bsc._color4Background.value = ddbc.normalBlanco.value;
      bsc._color4Text.value = ddbc.normalPurpura.value;
    }
  }
}

/*if (_formKey.currentState!.validate()) {
// Process data.
}*/
