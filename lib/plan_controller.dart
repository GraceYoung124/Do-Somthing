import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:google_maps_webservice/places.dart"; //pub.dev/packages/google_maps_webservice/versions/0.0.20-nullsafety.5
import 'package:http/http.dart' as http;

import 'plan_page.dart';
class ApiCalls {
  Future<PlacesSearchResponse> nearbyPlacesApiCall(double lat, double long) async {

    final places = GoogleMapsPlaces(apiKey: "API_KEY_HERE");

    PlacesSearchResponse response = await places.searchNearbyWithRadius(Location(lat: 31.0424, lng: 42.421), 5000);
    //Esto puede dar error en web, debido a CORS
    return  response;
  }
}

Future<String> fetchPlaces() async {
  final response = await http
      .get(Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=API_KEY_HERE'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load places');
  }
}