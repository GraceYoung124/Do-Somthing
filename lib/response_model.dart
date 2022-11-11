


import 'package:do_something/place_model.dart';

class Resp {
  //final int userId;
  //final int id;
  //final String title;
  //final String body;
  final List<String> html_attributions;
  final List<Place> results;
  final String status;

  Resp({

    required this.html_attributions,
    required this.results,
    required this.status

  });

  Resp.fromJson(Map<String, dynamic> json)
      : html_attributions = json['html_attributions'],
        results = json['results'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
    'html_attributions': html_attributions,
    'results': results,
    'status': status,
  };

}
