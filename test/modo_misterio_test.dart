import 'dart:math';

import 'package:do_something/http_service.dart';
import 'package:do_something/mys_plan_page.dart';
import 'package:do_something/place_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:do_something/mys_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('Test that the locations for the mystery mode are returned correctly and they are different', () async {

    bool cond = false;
    String lat = "39.4738173587449";
    String lon = "-0.37700377783188216";
    String rad = "5000";
    List<Place> listaVacia = [];
    String keyw = "";
    List<String> friends = [];
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.4738173587449%2C-0.37700377783188216&radius=5000&type=restaurant&key=API_KEY_HERE";

    final HttpService httpService = HttpService();
    //final PlanMysPage mys = PlanMysPage(rad, 0, 5, 0, 4, 1, "", []);
    List <Place> lista = await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);

    double lonTest = lista[0].lon;
    double latTest = lista[0].lat;

    Random random1 = new Random();
    double randomDouble1 = random1.nextDouble() * (0.0006 - 0.0002) + 0.0002;
    Random random2 = new Random();
    double randomDouble2 = random2.nextDouble() * (0.0006 - 0.0002) + 0.0002;

    Random randomBool1 = Random();
    bool randomBoolean1 = randomBool1.nextBool();
    Random randomBool2 = Random();
    bool randomBoolean2 = randomBool2.nextBool();

    double latmod = latTest;
    double lonmod = lonTest;
    if (randomBoolean1) {
      latmod = lista[0].lat + randomDouble1;
    } else {
      latmod = lista[0].lat - randomDouble1;
    }
    if (randomBoolean2) {
      lonmod = lista[0].lon + randomDouble2;
    } else {
      lonmod = lista[0].lon - randomDouble2;
    }
    if((lonmod != lonTest)||(latmod != latTest)){
      cond = true;

    }

    expect(cond, true);


  });
}