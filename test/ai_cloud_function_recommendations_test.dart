
// Import the test package and Counter class
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:do_something/http_service.dart';
import 'package:do_something/place_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';


void main() {
  test('Test that the AI cloud function recommends differently for different users', () async {
    String lat = "39.4738173587449";
    String lon = "-0.37700377783188216";
    String rad = "5000";
    List<Place> listaVacia = [];
    String keyw = "";
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.4738173587449%2C-0.37700377783188216&radius=5000&type=restaurant&key=API_KEY_HERE";
    final HttpService httpService = HttpService();
    List <Place> lista = await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);

    List<String> catAux = [];
    for (var place in lista) {

      catAux.add(place.type);

    }
    String user = "115254712534831098290";
    String user2 = "101";

    Map data = new Map();
    data["user"] = user;
    data["locations"] = <Map<dynamic, dynamic>>[];

    List<String> listaCategorias = catAux.toSet().toList();
    for (String cat in listaCategorias) {
      data["locations"].add({"category":cat});

    }
    //Map data = {"user":user,"locations":[{"category":"Bar"},{"category":"Restaurant"}]};
    var body = json.encode(data);
    String link = "https://us-central1-do-something-329717.cloudfunctions.net/modelCors6";
    http.Response res = await http.post(Uri.parse(link),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    var listaSitios = [];
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      listaSitios = map.values.toList();
    }

    Map data2 = new Map();
    data2["user"] = user2;
    data2["locations"] = <Map<dynamic, dynamic>>[];

    List<String> listaCategorias2 = catAux.toSet().toList();
    for (String cat in listaCategorias2) {
      data2["locations"].add({"category":cat});

    }
    //Map data = {"user":user,"locations":[{"category":"Bar"},{"category":"Restaurant"}]};
    var body2 = json.encode(data2);
    String link2 = "https://us-central1-do-something-329717.cloudfunctions.net/modelCors6";
    http.Response res2 = await http.post(Uri.parse(link2),
        headers: {"Content-Type": "application/json"},
        body: body2
    );
    var listaSitios2 = [];
    if (res2.statusCode == 200) {
      Map<String, dynamic> map2 = json.decode(res2.body);
      listaSitios2 = map2.values.toList();
    }

    bool different = false;

    if(listaSitios.toString() != listaSitios2.toString()) {
      different = true;
    }

    expect(different, true);
  });
}