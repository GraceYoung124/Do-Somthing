import 'package:do_something/http_service.dart';
import 'package:do_something/place_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('Test that the pictures are returned correctly', () async {

    String photoUrl = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=4032&maxheight=3024&photo_reference=Aap_uEDOrTHXwYd_-1_FWyvqxtjL7dVZcLxdRewucWCOA2b4XJftI3w3qtmhXpfnOk7WITj4f0Oqo4XCROcbZ__dGold6tz5TZccnVrTtgVe0PYGEPjE-LtPUzowT3KwXCFXEuUzQnb7Ti0FHP_3KYV-Eh1MyEo_NVtOXOX3QMNxYQ1kgxIZ&key=API_KEY_HERE";
    Widget imagen = Image.network(photoUrl);




    expect(imagen.toString(), "Image(image: NetworkImage(\"https://maps.googleapis.com/maps/api/place/photo?maxwidth=4032&maxheight=3024&photo_reference=Aap_uEDOrTHXwYd_-1_FWyvqxtjL7dVZcLxdRewucWCOA2b4XJftI3w3qtmhXpfnOk7WITj4f0Oqo4XCROcbZ__dGold6tz5TZccnVrTtgVe0PYGEPjE-LtPUzowT3KwXCFXEuUzQnb7Ti0FHP_3KYV-Eh1MyEo_NVtOXOX3QMNxYQ1kgxIZ&key=API_KEY_HERE\", scale: 1.0), frameBuilder: null, loadingBuilder: null, alignment: Alignment.center, this.excludeFromSemantics: false, filterQuality: low)");
  });
}