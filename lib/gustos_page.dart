import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_something/boton_principal_page.dart';
import 'package:do_something/tutorial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'firebase_auth_controller.dart';
import 'dart:math' as math;
//import 'login_controller.dart';

class CheckboxController extends GetxController {
  var _naturaleza = false.obs;
  var _comida = false.obs;
  var _historia = false.obs;
  var _salud = false.obs;
  var _viaje = false.obs;
  var _entretenimiento = false.obs;
  var _religion = false.obs;
  var _tecno = false.obs;
  var _compras = false.obs;
  var _deporte = false.obs;
  var _motor = false.obs;
  var _arte = false.obs;
  var _artesania = false.obs;
}

class coloresController extends GetxController {
  var _naturalezaBack = Color(0xFFC6FCAD).obs;
  var _naturalezaFont = Color(0xFF301744).obs;
  var _comidaBack = Color(0xFFC6FCAD).obs;
  var _comidaFont = Color(0xFF301744).obs;
  var _historiaBack = Color(0xFFC6FCAD).obs;
  var _historiaFont = Color(0xFF301744).obs;
  var _saludBack = Color(0xFFC6FCAD).obs;
  var _saludFont = Color(0xFF301744).obs;
  var _viajeBack = Color(0xFFC6FCAD).obs;
  var _viajeFont = Color(0xFF301744).obs;
  var _entretenimientoBack = Color(0xFFC6FCAD).obs;
  var _entretenimientoFont = Color(0xFF301744).obs;
  var _religionBack = Color(0xFFC6FCAD).obs;
  var _religionFont = Color(0xFF301744).obs;
  var _tecnoBack = Color(0xFFC6FCAD).obs;
  var _tecnoFont = Color(0xFF301744).obs;
  var _comprasBack = Color(0xFFC6FCAD).obs;
  var _comprasFont = Color(0xFF301744).obs;
  var _deporteBack = Color(0xFFC6FCAD).obs;
  var _deporteFont = Color(0xFF301744).obs;
  var _motorBack = Color(0xFFC6FCAD).obs;
  var _motorFont = Color(0xFF301744).obs;
  var _arteBack = Color(0xFFC6FCAD).obs;
  var _arteFont = Color(0xFF301744).obs;
  var _artesaniaBack = Color(0xFFC6FCAD).obs;
  var _artesaniaFont = Color(0xFF301744).obs;
}

class GustosPage extends GetWidget<AuthController> {
  final CheckboxController _ctrl = Get.put(CheckboxController());
  final coloresController _colores = Get.put(coloresController());
  var _contador = 3.obs;
  var _icono = Icons.close.obs;
  var _textoBoton = 'Select 3 categories more'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(controller.blanco),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Container(
          child: Obx(
            () => Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('What would\nyou like to do?',
                        style: TextStyle(
                            color: Color.fromRGBO(48, 23, 68, 1.0),
                            fontWeight: FontWeight.w500,
                            fontSize: 30)),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      child: const Text('Nature'),
                      height: 105,
                      minWidth: 105,
                      textColor: _colores._naturalezaFont.value,
                      shape: const CircleBorder(),
                      color: _colores._naturalezaBack.value,
                      onPressed: () {
                        _ctrl._naturaleza.value = !_ctrl._naturaleza.value;
                        if (_ctrl._naturaleza.value == false) {
                          _colores._naturalezaBack.value =
                              Color(controller.verde);
                          _colores._naturalezaFont.value =
                              Color(controller.purpura);
                          _contador.value++;
                        } else {
                          _contador.value--;
                          _colores._naturalezaBack.value =
                              Color(controller.naranja);
                          _colores._naturalezaFont.value =
                              Color(controller.blanco);
                        }
                        cambiarBoton();
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Transform.rotate(
                          angle: 6.11 * math.pi / 180,
                          child: MaterialButton(
                            child: const Text('Religion'),
                            textColor: _colores._religionFont.value,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: _colores._religionBack.value,
                            onPressed: () {
                              _ctrl._religion.value = !_ctrl._religion.value;
                              if (_ctrl._religion.value == false) {
                                _colores._religionBack.value =
                                    Color(controller.verde);
                                _colores._religionFont.value =
                                    Color(controller.purpura);
                                _contador.value++;
                              } else {
                                _contador.value--;
                                _colores._religionBack.value =
                                    Color(controller.naranja);
                                _colores._religionFont.value =
                                    Color(controller.blanco);
                              }
                              cambiarBoton();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              height: 86,
                              minWidth: 86,
                              child: const Text('History'),
                              textColor: _colores._historiaFont.value,
                              shape: const CircleBorder(),
                              color: _colores._historiaBack.value,
                              onPressed: () {
                                _ctrl._historia.value = !_ctrl._historia.value;
                                if (_ctrl._historia.value == false) {
                                  _colores._historiaBack.value =
                                      Color(controller.verde);
                                  _colores._historiaFont.value =
                                      Color(controller.purpura);
                                  _contador.value++;
                                } else {
                                  _contador.value--;
                                  _colores._historiaBack.value =
                                      Color(controller.naranja);
                                  _colores._historiaFont.value =
                                      Color(controller.blanco);
                                }
                                cambiarBoton();
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 115,
                                  minWidth: 115,
                                  child: const Text('Food'),
                                  textColor: _colores._comidaFont.value,
                                  shape: const CircleBorder(),
                                  color: _colores._comidaBack.value,
                                  onPressed: () {
                                    _ctrl._comida.value = !_ctrl._comida.value;
                                    if (_ctrl._comida.value == false) {
                                      _colores._comidaBack.value =
                                          Color(controller.verde);
                                      _colores._comidaFont.value =
                                          Color(controller.purpura);
                                      _contador.value++;
                                    } else {
                                      _contador.value--;
                                      _colores._comidaBack.value =
                                          Color(controller.naranja);
                                      _colores._comidaFont.value =
                                          Color(controller.blanco);
                                    }
                                    cambiarBoton();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                    ),
                    Transform.rotate(
                      angle: 6.11 * math.pi / 180,
                      child: MaterialButton(
                        child: const Text('Motoring'),
                        textColor: _colores._motorFont.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: _colores._motorBack.value,
                        onPressed: () {
                          _ctrl._motor.value = !_ctrl._motor.value;
                          if (_ctrl._motor.value == false) {
                            _colores._motorBack.value = Color(controller.verde);
                            _colores._motorFont.value =
                                Color(controller.purpura);
                            _contador.value++;
                          } else {
                            _contador.value--;
                            _colores._motorBack.value =
                                Color(controller.naranja);
                            _colores._motorFont.value =
                                Color(controller.blanco);
                          }
                          cambiarBoton();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      height: 105,
                      minWidth: 105,
                      child: const Text('Travel'),
                      textColor: _colores._viajeFont.value,
                      shape: const CircleBorder(),
                      color: _colores._viajeBack.value,
                      onPressed: () {
                        _ctrl._viaje.value = !_ctrl._viaje.value;
                        if (_ctrl._viaje.value == false) {
                          _colores._viajeBack.value = Color(controller.verde);
                          _colores._viajeFont.value = Color(controller.purpura);
                          _contador.value++;
                        } else {
                          _contador.value--;
                          _colores._viajeBack.value = Color(controller.naranja);
                          _colores._viajeFont.value = Color(controller.blanco);
                        }
                        cambiarBoton();
                      },
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            Transform.rotate(
                              angle: 1 * math.pi / 180,
                              child: MaterialButton(
                                child: const Text('Health & Beauty'),
                                textColor: _colores._saludFont.value,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: _colores._saludBack.value,
                                onPressed: () {
                                  _ctrl._salud.value = !_ctrl._salud.value;
                                  if (_ctrl._salud.value == false) {
                                    _colores._saludBack.value =
                                        Color(controller.verde);
                                    _colores._saludFont.value =
                                        Color(controller.purpura);
                                    _contador.value++;
                                  } else {
                                    _contador.value--;
                                    _colores._saludBack.value =
                                        Color(controller.naranja);
                                    _colores._saludFont.value =
                                        Color(controller.blanco);
                                  }
                                  cambiarBoton();
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: 5.52 * math.pi / 180,
                              child: MaterialButton(
                                child: const Text('Tech & Science'),
                                textColor: _colores._tecnoFont.value,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: _colores._tecnoBack.value,
                                onPressed: () {
                                  _ctrl._tecno.value = !_ctrl._tecno.value;
                                  if (_ctrl._tecno.value == false) {
                                    _colores._tecnoBack.value =
                                        Color(controller.verde);
                                    _colores._tecnoFont.value =
                                        Color(controller.purpura);
                                    _contador.value++;
                                  } else {
                                    _contador.value--;
                                    _colores._tecnoBack.value =
                                        Color(controller.naranja);
                                    _colores._tecnoFont.value =
                                        Color(controller.blanco);
                                  }
                                  cambiarBoton();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Transform.rotate(
                              angle: -4.87 * math.pi / 180,
                              child: MaterialButton(
                                child: const Text('Entertainment'),
                                textColor: _colores._entretenimientoFont.value,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: _colores._entretenimientoBack.value,
                                onPressed: () {
                                  _ctrl._entretenimiento.value =
                                      !_ctrl._entretenimiento.value;
                                  if (_ctrl._entretenimiento.value == false) {
                                    _colores._entretenimientoBack.value =
                                        Color(controller.verde);
                                    _colores._entretenimientoFont.value =
                                        Color(controller.purpura);
                                    _contador.value++;
                                  } else {
                                    _contador.value--;
                                    _colores._entretenimientoBack.value =
                                        Color(controller.naranja);
                                    _colores._entretenimientoFont.value =
                                        Color(controller.blanco);
                                  }
                                  cambiarBoton();
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 160,
                            ),
                            MaterialButton(
                              height: 67,
                              minWidth: 67,
                              child: const Text('Crafts'),
                              textColor: _colores._artesaniaFont.value,
                              shape: const CircleBorder(),
                              color: _colores._artesaniaBack.value,
                              onPressed: () {
                                _ctrl._artesania.value =
                                    !_ctrl._artesania.value;
                                if (_ctrl._artesania.value == false) {
                                  _colores._artesaniaBack.value =
                                      Color(controller.verde);
                                  _colores._artesaniaFont.value =
                                      Color(controller.purpura);
                                  _contador.value++;
                                } else {
                                  _contador.value--;
                                  _colores._artesaniaBack.value =
                                      Color(controller.naranja);
                                  _colores._artesaniaFont.value =
                                      Color(controller.blanco);
                                }
                                cambiarBoton();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    MaterialButton(
                      height: 110,
                      minWidth: 110,
                      child: const Text('Shopping'),
                      textColor: _colores._comprasFont.value,
                      shape: const CircleBorder(),
                      color: _colores._comprasBack.value,
                      onPressed: () {
                        _ctrl._compras.value = !_ctrl._compras.value;
                        if (_ctrl._compras.value == false) {
                          _colores._comprasBack.value = Color(controller.verde);
                          _colores._comprasFont.value =
                              Color(controller.purpura);
                          _contador.value++;
                        } else {
                          _contador.value--;
                          _colores._comprasBack.value =
                              Color(controller.naranja);
                          _colores._comprasFont.value =
                              Color(controller.blanco);
                        }
                        cambiarBoton();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        MaterialButton(
                          height: 78,
                          minWidth: 78,
                          child: const Text('Sports'),
                          textColor: _colores._deporteFont.value,
                          shape: const CircleBorder(),
                          color: _colores._deporteBack.value,
                          onPressed: () {
                            _ctrl._deporte.value = !_ctrl._deporte.value;
                            if (_ctrl._deporte.value == false) {
                              _colores._deporteBack.value =
                                  Color(controller.verde);
                              _colores._deporteFont.value =
                                  Color(controller.purpura);
                              _contador.value++;
                            } else {
                              _contador.value--;
                              _colores._deporteBack.value =
                                  Color(controller.naranja);
                              _colores._deporteFont.value =
                                  Color(controller.blanco);
                            }
                            cambiarBoton();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Transform.rotate(
                      angle: 4.15 * math.pi / 180,
                      child: MaterialButton(
                        child: const Text('Art & Culture'),
                        textColor: _colores._arteFont.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: _colores._arteBack.value,
                        onPressed: () {
                          _ctrl._arte.value = !_ctrl._arte.value;
                          if (_ctrl._arte.value == false) {
                            _colores._arteBack.value = Color(controller.verde);
                            _colores._arteFont.value =
                                Color(controller.purpura);
                            _contador.value++;
                          } else {
                            _contador.value--;
                            _colores._arteBack.value =
                                Color(controller.naranja);
                            _colores._arteFont.value = Color(controller.blanco);
                          }
                          cambiarBoton();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (_contador.value < 1) {
                                createEntry();
                                Get.to(() => Tutorial());
                              }
                            },
                            child: Text(
                              _textoBoton.value,
                              style: TextStyle(
                                  color: Color(controller.purpura),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                          Icon(
                            _icono.value,
                            color: Color(controller.purpura),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cambiarBoton() {
    if (_contador.value > 1) {
      _textoBoton.value =
          'Select ' + _contador.value.toString() + ' more categories';
      _icono.value = Icons.close;
    }
    if (_contador.value == 1) {
      _textoBoton.value =
          'Select ' + _contador.value.toString() + ' more category';
      _icono.value = Icons.close;
    }
    if (_contador.value < 1) {
      _textoBoton.value = 'DONE';
      _icono.value = Icons.check;
    }
  }

  void createEntry() {
    final CollectionReference _path = controller.path();

    // print("adios");
    if (_ctrl._naturaleza.value) {
      _path.add({
        'category': "Park",
        'score': true,
        'namePlace': "Park",
      });
      _path.add({
        'category': "Hiking area",
        'score': true,
        'namePlace': "Hiking area",
      });
      _path.add({
        'category': "National park",
        'score': true,
        'namePlace': "National park",
      });
    }
    if (_ctrl._comida.value) {
      _path.add({
        'category': "Restaurant",
        'score': true,
        'namePlace': "Restaurant",
      });
      _path.add({
        'category': "Market",
        'score': true,
        'namePlace': "Market",
      });
      _path.add({
        'category': "Cafe",
        'score': true,
        'namePlace': "Cafe",
      });
    }
    if (_ctrl._historia.value) {
      _path.add({
        'category': "Historical landmark",
        'score': true,
        'namePlace': "Historical landmark",
      });
      _path.add({
        'category': "Cathedral",
        'score': true,
        'namePlace': "Cathedral",
      });
      _path.add({
        'category': "Castle",
        'score': true,
        'namePlace': "Castle",
      });
    }
    if (_ctrl._salud.value) {
      _path.add({
        'category': "Hair salon",
        'score': true,
        'namePlace': "Hair salon",
      });
      _path.add({
        'category': "Nail salon",
        'score': true,
        'namePlace': "Nail salon",
      });
      _path.add({
        'category': "Spa",
        'score': true,
        'namePlace': "Spa",
      });
    }
    if (_ctrl._viaje.value) {
      _path.add({
        'category': "Hotel",
        'score': true,
        'namePlace': "Hotel",
      });
      _path.add({
        'category': "Travel agency",
        'score': true,
        'namePlace': "Travel agency",
      });
      _path.add({
        'category': "Resort",
        'score': true,
        'namePlace': "Resort",
      });
    }
    if (_ctrl._entretenimiento.value) {
      _path.add({
        'category': "Disco club",
        'score': true,
        'namePlace': "Disco club",
      });
      _path.add({
        'category': "Movie theater",
        'score': true,
        'namePlace': "Movie theater",
      });
      _path.add({
        'category': "Pub",
        'score': true,
        'namePlace': "Pub ",
      });
    }
    if (_ctrl._religion.value) {
      _path.add({
        'category': "Church",
        'score': true,
        'namePlace': "Church",
      });
      _path.add({
        'category': "Mosque",
        'score': true,
        'namePlace': "Mosque",
      });
      _path.add({
        'category': "Synagogue",
        'score': true,
        'namePlace': "Synagogue",
      });
    }
    if (_ctrl._tecno.value) {
      _path.add({
        'category': "Internet cafe",
        'score': true,
        'namePlace': "Internet cafe",
      });
      _path.add({
        'category': "Electronics store",
        'score': true,
        'namePlace': "Electronics store",
      });
      _path.add({
        'category': "Video game store",
        'score': true,
        'namePlace': "Video game store",
      });
    }
    if (_ctrl._compras.value) {
      _path.add({
        'category': "Shopping mall",
        'score': true,
        'namePlace': "Shopping mall",
      });
      _path.add({
        'category': "Outlet store",
        'score': true,
        'namePlace': "Outlet store",
      });
      _path.add({
        'category': "Clothing store",
        'score': true,
        'namePlace': "Clothing store",
      });
    }
    if (_ctrl._motor.value) {
      _path.add({
        'category': "Car accessories store",
        'score': true,
        'namePlace': "Car accessories store",
      });
      _path.add({
        'category': "Car wash",
        'score': true,
        'namePlace': "Car wash",
      });
      _path.add({
        'category': "Car racing track",
        'score': true,
        'namePlace': "Car racing track",
      });
    }
    if (_ctrl._artesania.value) {
      _path.add({
        'category': "Painting studio",
        'score': true,
        'namePlace': "Painting studio",
      });
      _path.add({
        'category': "Handicraft",
        'score': true,
        'namePlace': "Handicraft",
      });
      _path.add({
        'category': "Woodworker",
        'score': true,
        'namePlace': "Woodworker",
      });
    }
    if (_ctrl._deporte.value) {
      _path.add({
        'category': "Stadium",
        'score': true,
        'namePlace': "Stadium",
      });
      _path.add({
        'category': "Gym",
        'score': true,
        'namePlace': "Gym",
      });
      _path.add({
        'category': "Gymnastics center",
        'score': true,
        'namePlace': "Gymnastics center",
      });
    }
    if (_ctrl._arte.value) {
      _path.add({
        'category': "Museum",
        'score': true,
        'namePlace': "Museum",
      });
      _path.add({
        'category': "Theatre",
        'score': true,
        'namePlace': "Theatre",
      });
      _path.add({
        'category': "Library",
        'score': true,
        'namePlace': "Library",
      });
    }
  }
}
