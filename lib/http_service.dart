import 'dart:convert';
import 'dart:developer';

import 'package:do_something/place_model.dart';
import 'package:do_something/response_model.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:universal_io/io.dart' as uio;

class HttpService{
  //final String placesUrl = "https://jsonplaceholder.typicode.com/posts";
  //final String placesUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.4738173587449%2C-0.37700377783188216&radius=5000&type=restaurant&key=API_KEY_HERE";

  Future<List<Place>> getPlaces(String lat, String lon, String rad, List<Place> result, String placesUrl, String keyword) async {

    String nextPageToken = "";
    if(placesUrl == "") {
      if(keyword == ""){
        placesUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + lat + "%2C" + lon + "&radius=" + rad + "&key=API_KEY_HERE";
      }
      else{
        placesUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + lat + "%2C" + lon + "&radius=" + rad + "&key=API_KEY_HERE&keyword=" + keyword;
      }

    }
    String proxy = "https://us-central1-dosomething-f63e2.cloudfunctions.net/helloWorld";




    //Response res = await get(Uri.parse(placesUrl));
    Response res = await post(Uri.parse(proxy), body: {'link': placesUrl});
    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      Map<String, dynamic> map = json.decode(res.body);



      var lista = map.values.toList();


      Place place;

      //recursive case
      if(lista[1].runtimeType == String) {

        for(int i = 0; i < lista[2].length; i++) {

          try {
            place = Place(
                lista[2][i]['name'],
                lista[2][i]['place_id'],
                lista[2][i]['rating'],
                lista[2][i]['types'],
                lista[2][i]['price_level'],
                lista[2][i]['opening_hours'],
                lista[2][i]['compound'],
                lista[2][i]['photos'],
                lista[2][i]['geometry']['location']['lat'],
                lista[2][i]['geometry']['location']['lng']
            ); //lista[1][0]['types'], , lista[1][0]['url']
            result.add(place);

          }catch(e){}

        }
        //ask for nextpage results
        nextPageToken = lista[1];

        String placesUrlNextPage = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + lat + "%2C" + lon + "&radius=" + rad + "&key=API_KEY_HERE&pagetoken=" + nextPageToken;

        //Response res = await get(Uri.parse(placesUrlNextPage));
        await Future.delayed(Duration(milliseconds: 1551));
        result = await getPlaces(lat, lon, rad, result, placesUrlNextPage, keyword);



      }
      //base case
      else {


        for(int i = 0; i < lista[1].length; i++) {
          try{
            place = Place(lista[1][i]['name'], lista[1][i]['place_id'], lista[1][i]['rating'], lista[1][i]['types'], lista[1][i]['price_level'], lista[1][i]['opening_hours'], lista[1][i]['compound'], lista[1][i]['photos'],lista[1][i]['geometry']['location']['lat'],lista[1][i]['geometry']['location']['lng']); //lista[1][0]['types'], , lista[1][0]['url']

            result.add(place);
          }catch(e){}

        }
      }
//https://www.google.com/maps/place/1200+Pennsylvania+Ave.+SE,+Washington,+DC+20003,+USA/@38.6087523,-77.2144016,11z/data=!4m5!3m4!1s0x89b7b834fb4029d3:0x9270eee67ab54203!8m2!3d38.882651!4d-76.9905426?hl=en
//https://www.google.es/maps/place/Cash+Converters/@39.4603361,-0.4228477,14z/data=!3m1!5s0xd604f49b16a5b07:0x185802a7cab11627!4m9!1m2!2m1!1scash+convcerters!3m5!1s0xd604f49b0fa43bb:0x3b1419759be54167!8m2!3d39.466817!4d-0.3812273!15sCg9jYXNoIGNvbnZlcnRlcnMiA4gBAVoRIg9jYXNoIGNvbnZlcnRlcnOSARBzZWNvbmRfaGFuZF9zaG9w
// https://www.google.es/maps/place/LEVANTE-EMV/@39.4599259,-0.4072157,19z/data=!3m2!4b1!5s0xd604f0c1f00a771:0xf47350c543234435!4m5!3m4!1s0xd604f0c1befe331:0x7ea9b0c9f54dffeb!8m2!3d39.4599118!4d-0.4066395
//https://www.google.com/maps/place/NOMBREcon mases en vez de espacios/@lat,legnth 7 decimales,


    }
    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load places');

    }

    return result;
  }
}
