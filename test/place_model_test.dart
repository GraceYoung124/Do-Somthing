import 'package:do_something/place_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  test(
    'Test that places are created correctly',
    () async {
      List<dynamic> photos = [];
      List<dynamic> lista = [];
      lista.add("patata");
      Place test = Place("test", "1", 1, lista, 2.0, null, null, photos, 10.0, 10.0);
      expect(test.name, "test");
      expect(test.lat, 10.0);
      expect(test.lon, 10.0);
      expect(test.place_id, "1");
    },
  );
}
