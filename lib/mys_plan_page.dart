import 'dart:convert';
import 'dart:math';
import 'package:do_something/firebase_auth_controller.dart';
import 'package:do_something/plan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'into_plan_page.dart';
import 'place_model.dart';
import "http_service.dart";
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:haversine_distance/haversine_distance.dart' as haversine;
import 'package:animated_counter/animated_counter.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SController extends GetxController {
  var visiblePlan = false.obs;
}

class PlanMysPage extends GetWidget<AuthController> {
  String rad = "5000";
  double minRat = 0;
  double maxRat = 5;
  double minPri = 0;
  double maxPri = 4;
  double isOpen = 0;
  String keyw = "";
  List<String> friends = [];
  String url = "https://www.google.com/maps/dir";
  var visibleButtons = true.obs;
  List<Place> lista = <Place>[];

  SController sController = SController();
  RotatingBubblesCounter bub = RotatingBubblesCounter(
      initialCounter: 1 + Random().nextInt(10 - 1),
      initialColors: [
        const Color.fromARGB(0xFF, 0xED, 0x61, 0x34),
        const Color.fromARGB(0xFF, 0xFD, 0xDD, 0x93),
        const Color.fromARGB(0xFF, 0xB9, 0x9A, 0xF1),
        const Color.fromARGB(0xFF, 0xC6, 0xFC, 0xAD),
        const Color.fromARGB(0xFF, 0xFF, 0xFC, 0xF6)
      ],
      blend: BlendMode.lighten);

  PlanMysPage(String radius, double minRating, double maxRating,
      double minPrice, double maxPrice, double open, String keyword, List<String> amigos) {
    rad = radius;
    minRat = minRating;
    maxRat = maxRating;
    minPri = minPrice;
    maxPri = maxPrice;
    isOpen = open;
    keyw = keyword;
    friends = amigos;
  }

  final List<String> nombres = [];
  final List<String> ides = [];
  final List<double> ratings = [];
  final List<String> categorias = [];
  final List<double> precios = [];
  final List<String> abiertos = [];
  final List<List<dynamic>> fotos = [];
  final List<double> latitudes = [];
  final List<double> longitudes = [];
  final List<List<dynamic>> fotosvacias = [];
  final HttpService httpService = HttpService();
  int numList = 10;
  double latmod = 0;
  double lonmod = 0;

  RxBool titleText = false.obs;

  Future<LocationData> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    return location.getLocation();
  }

  Future cargaDatos() async {
    /*Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {

      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {

      }
    }

    _locationData = await location.getLocation();*/
    LocationData _locationData;
    _locationData = await getLocation();
    String lat = _locationData.latitude.toString();
    String lon = _locationData.longitude.toString();

    List<Place> listaVacia = [];
    lista = await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);

    //Rating Filter
    if (minRat != 0 || maxRat != 5) {
      lista = ratingFilter(lista, minRat, maxRat);
    }

    //Price Filter
    if (minPri != 0 || maxPri != 4) {
      lista = priceFilter(lista, minPri, maxPri);
    }

    //Open Filter
    if (isOpen == 1) {
      lista = openFilter(lista);
    }

    List<String> catAux = [];
    for (var place in lista) {
      catAux.add(place.type);
    }

    //String user = "115254712534831098290";
    if(friends.isEmpty) {
    String user = controller.userFirebase!.uid;
    Map data = new Map();
    data["user"] = user;
    data["locations"] = <Map<dynamic, dynamic>>[];

    List<String> listaCategorias = catAux.toSet().toList();
    for (String cat in listaCategorias) {
      data["locations"].add({"category": cat});
    }
    //Map data = {"user":user,"locations":[{"category":"Bar"},{"category":"Restaurant"}]};
    var body = json.encode(data);
    String link =
        "https://us-central1-do-something-329717.cloudfunctions.net/modelCors6";
    http.Response res = await http.post(Uri.parse(link),
        headers: {"Content-Type": "application/json"}, body: body);
    var listaSitios = [];
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      listaSitios = map.values.toList();
    }
    List<Place> lista2 = [];
    lista.shuffle();
    if (keyw == "") {
      for (var cat in listaSitios) {
        bool isRepeat = true;
        for (Place sitio in lista) {
          if (cat['title'] == sitio.type && isRepeat) {
            lista2.add(sitio);
            isRepeat = false;
          }
        }
      }
    } else {
      for (var cat in listaSitios) {
        for (Place sitio in lista) {
          if (cat['title'] == sitio.type) {
            lista2.add(sitio);
          }
        }
      }
    }
    lista = lista2;

    List<Place> list5 = [];

    for (int i = 0; i < 5 && i < lista.length; i++) {
      list5.add(lista[i]);
    }
    lista = list5;
    lista.shuffle();

    }
    else{
      //Plan with friends
      List<Place> lista2 = [];
      lista.shuffle();
      List<Map<dynamic, dynamic>> listaa = [];


      String user = controller.userFirebase!.uid;
      Map data = new Map();
      data["user"] = user;
      data["locations"] = <Map<dynamic, dynamic>>[];

      List<String> listaCategorias = catAux.toSet().toList();
      for (String cat in listaCategorias) {
        data["locations"].add({"category": cat});
      }
      //Map data = {"user":user,"locations":[{"category":"Bar"},{"category":"Restaurant"}]};
      var body = json.encode(data);
      String link =
          "https://us-central1-do-something-329717.cloudfunctions.net/modelCors6";
      http.Response res = await http.post(Uri.parse(link),
          headers: {"Content-Type": "application/json"}, body: body);
      var listaSitios = [];
      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        listaSitios = map.values.toList();
      }

      Map sitioMap1 = new Map();
      if (keyw == "") {
        for (var cat in listaSitios) {
          bool isRepeat = true;
          for (Place sitio in lista) {
            if (cat['title'] == sitio.type && isRepeat) {
              sitioMap1 = {'place': sitio, 'score': cat['score']};
              listaa.add(sitioMap1);
              isRepeat = false;
            }
          }
        }
      } else {
        for (var cat in listaSitios) {
          for (Place sitio in lista) {
            if (cat['title'] == sitio.type) {
              sitioMap1 = {'place': sitio, 'score': cat['score']};
              listaa.add(sitioMap1);
            }
          }
        }
      }

      List<List<Map<dynamic, dynamic>>> listaDeListas = [];
      listaDeListas.add(listaa);


    for(String friend in friends) {

      user = friend;
      List<Map<dynamic, dynamic>> lista3 = [];
      data["user"] = user;
      data["locations"] = <Map<dynamic, dynamic>>[];

      List<String> listaCategorias = catAux.toSet().toList();
      for (String cat in listaCategorias) {
        data["locations"].add({"category": cat});
      }
      //Map data = {"user":user,"locations":[{"category":"Bar"},{"category":"Restaurant"}]};
      var body = json.encode(data);
      String link =
          "https://us-central1-do-something-329717.cloudfunctions.net/modelCors6";
      http.Response res = await http.post(Uri.parse(link),
          headers: {"Content-Type": "application/json"}, body: body);
      var listaSitios = [];
      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        listaSitios = map.values.toList();
      }

      Map sitioMap2 = new Map();

      if (keyw == "") {
        for (var cat in listaSitios) {
          bool isRepeat = true;
          for (Place sitio in lista) {
            if (cat['title'] == sitio.type && isRepeat) {
              sitioMap2 = {'place': sitio, 'score': cat['score']};

              lista3.add(sitioMap2);
              isRepeat = false;
            }
          }
        }
      } else {
        for (var cat in listaSitios) {
          for (Place sitio in lista) {
            if (cat['title'] == sitio.type) {
              sitioMap2 = {'place': sitio, 'score': cat['score']};

              lista3.add(sitioMap2);;
            }
          }
        }
      }
      listaDeListas.add(lista3);
    }
      listaa.sort((a, b) => a['place'].name.compareTo(b['place'].name));

      List<Map<dynamic, dynamic>> listaResult = [];
      Map sitioMapFinal = new Map();

      for(int i = 0; i < listaa.length; i++) {
        double media = double.parse(listaa[i]['score']);
        int cont = 1;
        for(List<Map<dynamic, dynamic>> listaMaps in listaDeListas){
          //sitioMapFinal = {'place': listaa[i]['place'], 'score': ((double.parse(listaa[i]['score']) + double.parse(lista3[i]['score'])) / 2)};
          media += double.parse(listaMaps[i]['score']);
          cont++;
        }
        sitioMapFinal = {'place': listaa[i]['place'], 'score': media / cont};
        listaResult.add(sitioMapFinal);
      }
      listaResult.sort((a, b) => b['score'].compareTo(a['score']));

      for(var sitio in listaResult) {
        lista2.add(sitio['place']);
      }


      lista = lista2;

      List<Place> list5 = [];

      for (int i = 0; i < 5 && i < lista.length; i++) {
        list5.add(lista[i]);
      }
      lista = list5;




    }


    List<Place> list6 = [];



    int cont = 0;
    Place lugar = lista[0];
    for (var place in lista) {
      //await Future.delayed(Duration(milliseconds: 550)); //coco, deberia ser solo web
      cont = 0;

      try {
        nombres.add(place.name);
        cont = 1;
        ides.add(place.place_id);
        cont = 2;
        ratings.add(place.rating);
        cont = 3;
        categorias.add(place.type);
        cont = 4;
        precios.add(place.price);
        cont = 5;
        abiertos.add(place.openOrNot);
        cont = 6;
        fotos.add(place.photos);
        lugar = place;
      }catch(e) {
        if (cont == 1) {
          nombres.removeLast();
        }
        else if (cont == 2){
          nombres.removeLast();
          ides.removeLast();
        }
        else if (cont == 3){
          nombres.removeLast();
          ides.removeLast();
          ratings.removeLast();
        }
        else if (cont == 4){
          nombres.removeLast();
          ides.removeLast();
          ratings.removeLast();
          categorias.removeLast();
        }
        else if (cont == 5){
          nombres.removeLast();
          ides.removeLast();
          ratings.removeLast();
          categorias.removeLast();
          precios.removeLast();
        }
        else if (cont == 6){
          nombres.removeLast();
          ides.removeLast();
          ratings.removeLast();
          categorias.removeLast();
          precios.removeLast();
          abiertos.removeLast();
        }
      }
      latitudes.add(place.lat);
      longitudes.add(place.lon);
    }

    //int numList = 5;
    if(nombres.length > 1){
      do {
        nombres.removeLast();
        ides.removeLast();
        ratings.removeLast();
        categorias.removeLast();
        precios.removeLast();
        abiertos.removeLast();
        fotos.removeLast();
        latitudes.removeLast();
        longitudes.removeLast();
      } while (nombres.length > 1);
    }

    if (nombres.isNotEmpty) {
      list6.add(lugar);
      lista = list6;


      Random random1 = new Random();
      double randomDouble1 = random1.nextDouble() * (0.0006 - 0.0002) + 0.0002;
      Random random2 = new Random();
      double randomDouble2 = random2.nextDouble() * (0.0006 - 0.0002) + 0.0002;

      Random randomBool1 = Random();
      bool randomBoolean1 = randomBool1.nextBool();
      Random randomBool2 = Random();
      bool randomBoolean2 = randomBool2.nextBool();

      latmod = lista[0].lat;
      lonmod = lista[0].lon;
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
    }

    url += '/' + lat + ',' + lon;
    for (int j = 0; j < lista.length; j++) {
      url += '/' + latmod.toString() + ',' + lonmod.toString();
      //url += '/' + lista[j].lat.toString() + ',' + lista[j].lon.toString();
    }

    String furl = url.replaceAll(' ', '%20');
    url = furl;

    if (nombres.length == 1) {
      numList = 1;
    }
    else{
      numList = 0;
    }
    //  await Future.delayed(Duration(milliseconds: 1551));
    visibleButtons.value = lista.isNotEmpty;

    titleText.value = true;
  }

  List<Widget> aux = [];

  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Lexend',
            primaryColor: Color(controller.blanco),
          ),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(controller.purpura),
              foregroundColor: Color(controller.purpura),
              elevation: 0,
              leading: Obx(() =>
                  Visibility(
                  visible: titleText.value,
                  child: IconButton(
                    icon:
                        Icon(Icons.arrow_back, color: Color(controller.blanco)),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ),
            backgroundColor: Color(controller.purpura),
            body: FutureBuilder(
                future: cargaDatos(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: decideImagen(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: bub.build(context),
                    );
                  } else {
                    LocationData currentLoc;
                    String cLat;
                    String cLon;
                    String placeLat;
                    String placeLon;
                    double dist;
                    haversine.Location startCoordinate;
                    haversine.Location endCoordinate;
                    final haversineDistance = haversine.HaversineDistance();
                    return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Do Something \nMysterious',
                              style: TextStyle(
                                color: Color(controller.blanco),
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(50)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: visibleButtons.value,
                                  child: ElevatedButton(
                                    onPressed: () => {_launchURL()},
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary: Color(controller.verde),
                                      shadowColor: Colors.white,
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'See Route',
                                      style: TextStyle(
                                        color: Color(controller.purpura),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: visibleButtons.value,
                                  child: ElevatedButton(
                                    onPressed: () async => {
                                      currentLoc = await getLocation(),
                                      startCoordinate = haversine.Location(
                                          currentLoc.latitude!,
                                          currentLoc.longitude!),
                                      endCoordinate =
                                          haversine.Location(latmod, lonmod),
                                      dist = haversineDistance.haversine(
                                          startCoordinate,
                                          endCoordinate,
                                          haversine.Unit.METER),
                                      if (dist < 150)
                                        {
                                          sController.visiblePlan.value = true,
                                        }
                                      else
                                        {
                                          Get.snackbar(
                                              "Get Closer to Reveal the Mystery!",
                                              "You are " +
                                                  dist.round().toString() +
                                                  " meters away",
                                              backgroundColor:
                                                  Color(controller.verde),
                                              colorText:
                                                  Color(controller.purpura),
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition:
                                                  SnackPosition.BOTTOM),
                                        }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary: Color(controller.verde),
                                      shadowColor: Colors.white,
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Reveal Mystery',
                                      style: TextStyle(
                                        color: Color(controller.purpura),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(20)),
                            Obx(
                              () => Visibility(
                                visible: sController.visiblePlan.value,
                                child: Flexible(
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: ListView(
                                        shrinkWrap: true,
                                        reverse: true,
                                        children: listaVista(context, numList)),
                                  ),
                                ),
                                replacement: Flexible(
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: ListView(
                                        shrinkWrap: true,
                                        reverse: true,
                                        children: listaVista(context, 0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
                  }
                }),
          ));
    });
  }

  List<Widget> listaVista(BuildContext context, int i) {
    List<Widget> aux = [];
    if (i == 0) {
      if (lista.isEmpty) {
        aux.add(
          Row(
            children: [
              Text(
                "0 results found",
                style: TextStyle(
                  color: Color(controller.blanco),
                ),
              ),
            ],
          ),
        );
      } else {
        aux.add(
          Row(
            children: [
              Text(
                "",
                style: TextStyle(
                  color: Color(controller.blanco),
                ),
              ),
            ],
          ),
        );
      }
    }

    while (i > 0) {
      aux.add(_buildItem(context, nombres[i - 1], fotos[i - 1], i - 1));
      i--;
    }

    return aux;
  }

/*
  Widget _buildItem(BuildContext context, String s, List<dynamic> foto, int i) {
    return ListTile(
      title: Text(
        s,
        style: TextStyle(
          color: Color(controller.blanco),
        ),
      ),
      subtitle: Text(
        categorias[i],
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      leading: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blueAccent),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=' +
                  fotos[i][0]['width'].toString() +
                  '&maxheight=' +
                  fotos[i][0]['height'].toString() +
                  '&photo_reference=' +
                  fotos[i][0]['photo_reference'] +
                  '&key=API_KEY_HERE',
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => dentroPlan(
                    nombre: nombres[i],
                    rating: ratings[i],
                    precio: precios[i],
                    categoria: categorias[i],
                    abierto: abiertos[i],
                    fotos: fotos[i],
                    latitud: latitudes[i],
                    longitud: longitudes[i],
                    id: ides[i],
                  )),
        );
      },
    );
  }

  */
  Widget _buildItem(BuildContext context, String s, List<dynamic> foto, int i) {
    if (foto != null) {
      return ListTile(
        dense: true,
        title: Text(
          categorias[i],
          style: const TextStyle(
            color: Color(0xFFFFFCF6),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        subtitle: Text(
          s,
          style: const TextStyle(
            color: Color(0xFFFFFCF6),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=' +
                    fotos[i][0]['width'].toString() +
                    '&maxheight=' +
                    fotos[i][0]['height'].toString() +
                    '&photo_reference=' +
                    fotos[i][0]['photo_reference'] +
                    '&key=API_KEY_HERE',
              ),
            ),
          ),
        ),
        trailing: Text(
          _precio(i) + " " + _rating(i),
          style: const TextStyle(
            color: Color(0xFFFFFCF6),
          ),
        ),
        onTap: () {
          Get.to(
            () => dentroPlan(
              nombre: nombres[i],
              rating: ratings[i],
              precio: precios[i],
              categoria: categorias[i],
              abierto: abiertos[i],
              fotos: fotos[i],
              latitud: latitudes[i],
              longitud: longitudes[i],
              id: ides[i],
            ),
          );
        },
      );
    } else {
      return ListTile(
        dense: true,
        title: Text(
          categorias[i],
          style: const TextStyle(
            color: Color(0xFFFFFCF6),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        subtitle: Text(
          s,
          style: const TextStyle(
            color: Color(0xFFFFFCF6),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/image-not-found.png"),
            ),
          ),
        ),
        trailing: Text(
          _precio(i) + " " + _rating(i),
          style: const TextStyle(
            color: Color(0xFFFFFCF6),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => dentroPlan(
                nombre: nombres[i],
                rating: ratings[i],
                precio: precios[i],
                categoria: categorias[i],
                abierto: abiertos[i],
                fotos: fotosvacias,
                //esto hay que cambiarlo
                latitud: latitudes[i],
                longitud: longitudes[i],
                id: ides[i],
              ),
            ),
          );
        },
      );
    }
  }

  AssetImage decideImagen() {
    int rand = Random().nextInt(9);
    AssetImage imagen = const AssetImage('assets/1_Misterio.png');
    switch (rand) {
      case 0:
        imagen = const AssetImage('assets/1_Misterio.png');
        break;
      case 1:
        imagen = const AssetImage('assets/2_Misterio.png');
        break;
      case 2:
        imagen = const AssetImage('assets/3_Misterio.png');
        break;
      case 3:
        imagen = const AssetImage('assets/4_Misterio.png');
        break;
      case 4:
        imagen = const AssetImage('assets/5_Misterio.png');
        break;
      case 5:
        imagen = const AssetImage('assets/6_Misterio.png');
        break;
      case 6:
        imagen = const AssetImage('assets/7_Misterio.png');
        break;
      case 7:
        imagen = const AssetImage('assets/8_Misterio.png');
        break;
    }
    return imagen;
  }

  void _launchURL() async {
    final String googleMapsUrl = url;
    /*
    final String appleMapsUrl = 'https://maps.apple.com/?q='+ latitud.toString() + '%2C' + longitud.toString();
   if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
    */
    await canLaunch(googleMapsUrl)
        ? await launch(googleMapsUrl)
        : throw 'Could not launch $googleMapsUrl';
  }

  String _precio(int i) {
    double p = precios[i];
    String aux = '';
    if (p == 0.0) {
      aux = 'Free';
    } else {
      if (p == 1.0) {
        aux = '€';
      } else if (p == 2.0) {
        aux = '€€';
      } else if (p == 3.0) {
        aux = '€€€';
      } else if (p == 4.0) {
        aux = '€€€€';
      } else if (p == 5.0) {
        aux = '€€€€€';
      }
    }
    return aux;
  }

  String _rating(int i) {
    return ratings[i].toString();
  }
}
