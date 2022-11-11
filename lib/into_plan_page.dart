import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_something/firebase_auth_controller.dart';
import 'package:do_something/gustos_page.dart';
import 'package:do_something/place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class ColorController extends GetxController {
  var normalBlanco = 0xFFFFFCF6.obs; //blanco
  var normalPurpura = 0xFF301744.obs; //purpura
}

class dentroPlan extends GetWidget<AuthController> {
  final nombre;
  final rating;
  final precio;
  final categoria;
  final abierto;
  final fotos;
  final latitud;
  final longitud;
  final id;

  dentroPlan(
      {Key? key,
      this.nombre,
      this.rating,
      this.precio,
      this.categoria,
      this.abierto,
      this.fotos,
      this.latitud,
      this.longitud,
      this.id})
      : super(key: key);

  Future cargaDatos() async {
    //var profileImage;
    String photoUrl =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=' +
            fotos[0]['width'].toString() +
            '&maxheight=' +
            fotos[0]['height'].toString() +
            '&photo_reference=' +
            fotos[0]['photo_reference'] +
            '&key=API_KEY_HERE';

    String proxy =
        "https://us-central1-dosomething-f63e2.cloudfunctions.net/helloWorld";

    /*Response res = await post(Uri.parse(proxy), body: {'link': photoUrl});
    if (res.statusCode == 200) {
      image image2 = Image.memory(res.bodyBytes).image;
      image = image2;
    }*/
  }

  ColorController cc = ColorController();

  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return Obx(
        () => MaterialApp(
          theme: ThemeData(
            backgroundColor: Color(cc.normalBlanco.value),
            fontFamily: 'Lexend',
          ),
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor: Color(cc.normalBlanco.value),
                foregroundColor: Color(cc.normalBlanco.value),
                elevation: 0.0,
                bottomOpacity: 0.0,
                centerTitle: true,
                title: Text(
                  "Today's Plan!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(cc.normalPurpura.value),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Color(cc.normalPurpura.value)),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
            backgroundColor: Color(cc.normalBlanco.value),
            body: FutureBuilder(
                future: cargaColores(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Scaffold(
                      backgroundColor: Color(cc.normalBlanco.value),
                      body: Container(
                        height: 100.vh,
                        width: 100.vw,
                        decoration: BoxDecoration(border: Border.all()),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.vh,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _getFoto(fotos),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 3,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          categoria,
                                          style: TextStyle(
                                            color:
                                                Color(cc.normalPurpura.value),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          _getNombre(nombre),
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color:
                                                  Color(cc.normalPurpura.value),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //SizedBox(width: 200,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _botonLike(),
                                    _botonDL(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    _precioString(precio.toString()),
                                    style: TextStyle(
                                      color: Color(cc.normalPurpura.value),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  DecoratedBox(
                                    child: Text(
                                      " " + abierto.toString().toUpperCase() + " ",
                                      style: TextStyle(
                                        color: Color(cc.normalPurpura.value),
                                        fontSize: 16,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 15.0,
                                          color: Color(0xFFC6FCAD)),
                                      color: Color(0xFFC6FCAD),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    rating.toString(),
                                    style: TextStyle(
                                        color: Color(cc.normalPurpura.value),
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FloatingActionButton.extended(
                              backgroundColor: Color(cc.normalPurpura.value),
                              onPressed: _launchURL,
                              label: Text(
                                'LET\'S GO',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(cc.normalBlanco.value)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
      );
    });
  }

  /*
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

              if (await canLaunch(googleMapsUrl)) {
                await launch(googleMapsUrl);
              }
              if (await canLaunch(appleMapsUrl)) {
                await launch(appleMapsUrl, forceSafariVC: false);
     */

  void _launchURL() async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=' +
            latitud.toString() +
            '%2C' +
            longitud.toString() +
            '&query_place_id=' +
            id.toString();
    /*
    final String appleMapsUrl = 'https://maps.apple.com/?q='+ latitud.toString() + '%2C' + longitud.toString();
   if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }

    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
    */
    await canLaunch(googleMapsUrl)
        ? await launch(googleMapsUrl)
        : throw 'Could not launch $googleMapsUrl';
  }

  String _precioString(String string) {
    String res = '';
    if (string == '0.0') {
      res = 'Free';
    } else if (string == '1.0') {
      res = '€';
    } else if (string == '2.0') {
      res = '€€';
    } else if (string == '3.0') {
      res = '€€€';
    } else if (string == '4.0') {
      res = '€€€€';
    }
    return res;
  }

  String _getNombre(nombre) {
    String res = nombre.toString();
    int tam = 20 - nombre.toString().length;
    if (nombre.toString().length > 20) {
      res = nombre.toString().substring(0, 17) + "...";
    } else if (nombre.toString().length < 20) {
      for (int i = 0; i < tam; i++) {
        res += " ";
      }
    }
    return res;
  }

  _getFoto(List<dynamic> fotos) {
    if (fotos.isEmpty) {
      return AssetImage("assets/image-not-found.png");
    } else {
      return NetworkImage(
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=' +
            fotos[0]['width'].toString() +
            '&maxheight=' +
            fotos[0]['height'].toString() +
            '&photo_reference=' +
            fotos[0]['photo_reference'] +
            '&key=API_KEY_HERE',
      );
    }
  }

  void dislike() {
    final CollectionReference _path = controller.path();
    _path.add({
      'category': this.categoria.toString(),
      'score': false,
      'namePlace': this.nombre.toString(),
    });
  }

  void like() {
    final CollectionReference _path = controller.path();
    _path.add({
      'category': this.categoria.toString(),
      'score': true,
      'namePlace': this.nombre.toString(),
    });
  }

  _botonDL() {
    if (!controller.firebaseUser.value!.isAnonymous) {
      return IconButton(
          onPressed: () {
            dislike();
            Get.snackbar("Plan Disliked!", "🙁",
                backgroundColor: Color(controller.naranja),
                colorText: Color(controller.purpura),
                snackPosition: SnackPosition.BOTTOM);
          },
          icon: Icon(
            Icons.thumb_down_off_alt,
            color: Color(cc.normalPurpura.value),
          ));
    } else
      return SizedBox(
        width: 1,
      );
  }

  _botonLike() {
    if (!controller.firebaseUser.value!.isAnonymous) {
      return IconButton(
          onPressed: () {
            like();
            Get.snackbar("Plan Liked!", "😁",
                backgroundColor: Color(controller.verde),
                colorText: Color(controller.purpura),
                snackPosition: SnackPosition.BOTTOM);
          },
          icon: Icon(
            Icons.thumb_up_outlined,
            color: Color(cc.normalPurpura.value),
          ));
    } else
      return SizedBox(
        width: 1,
      );
  }

  Future cargaColores() async {
    await Future.delayed(const Duration(milliseconds: 1));
    if (controller.estado.value == 'Mystery') {
      cc.normalBlanco.value = 0xFF301744;
      cc.normalPurpura.value = 0xFFFFFCF6;
    }
    if (controller.estado.value == 'Normal') {
      cc.normalBlanco.value = 0xFFFFFCF6;
      cc.normalPurpura.value = 0xFF301744;
    }
  }
}
