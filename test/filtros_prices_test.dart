import 'package:do_something/http_service.dart';
import 'package:do_something/place_model.dart';
import 'package:do_something/plan_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('Check that the prices filter works properly', () async {
    String lat = "39.4738173587449";
    String lon = "-0.37700377783188216";
    String rad = "5000";
    List<Place> listaVacia = [];
    String keyw = "";
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.4738173587449%2C-0.37700377783188216&radius=5000&type=restaurant&key=API_KEY_HERE";
    final HttpService httpService = HttpService();
    List <Place> lista = await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);



    //Price Filter
    double minPri = 1;
    double maxPri = 3;
    lista = priceFilter(lista, minPri, maxPri);

    bool filterPricesCorrect = true;
    for (int i = 0; i < lista.length; i++) {
      if(!(lista[i].price > minPri || lista[i].price < maxPri)){
        filterPricesCorrect = false;
      }
    }


    expect(filterPricesCorrect, true);
  });
}