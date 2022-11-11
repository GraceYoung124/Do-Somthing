import 'package:do_something/http_service.dart';
import 'package:do_something/place_model.dart';
import 'package:do_something/plan_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('Check that the isOpen filter works properly', () async {
    String lat = "39.4738173587449";
    String lon = "-0.37700377783188216";
    String rad = "5000";
    List<Place> listaVacia = [];
    String keyw = "";
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.4738173587449%2C-0.37700377783188216&radius=5000&type=restaurant&key=API_KEY_HERE";
    final HttpService httpService = HttpService();
    List <Place> lista = await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);



    //Open Filter

    lista = openFilter(lista);

    bool filterOpenCorrect = true;
    for (int i = 0; i < lista.length; i++) {
      if(lista[i].openOrNot != "Open"){
        filterOpenCorrect = false;
      }
    }


    expect(filterOpenCorrect, true);
  });
}