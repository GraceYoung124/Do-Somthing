import 'package:do_something/http_service.dart';
import 'package:do_something/place_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('Check that the keyword filter works properly', () async {
    String lat = "39.4738173587449";
    String lon = "-0.37700377783188216";
    String rad = "5000";
    List<Place> listaVacia = [];
    String keyw = "church";
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.4738173587449%2C-0.37700377783188216&radius=5000&type=restaurant&key=API_KEY_HERE";
    final HttpService httpService = HttpService();
    List <Place> lista = await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);



    //Open Filter

    List<Place> list4 = [];
    bool filtroKeyword = false;
    for (int i = 0; i < lista.length; i++) {
      if(lista[i].name.contains("church")){
        filtroKeyword = true;
      }
    }



    expect(filtroKeyword, true);
  });
}