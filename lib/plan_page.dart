import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_something/firebase_auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'into_plan_page.dart';
import 'place_model.dart';
import "http_service.dart";
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:animated_counter/animated_counter.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

List<Place> ratingFilter(List<Place> lista, double lminRat, double lmaxRat) {
  List<Place> list2 = [];
  for (int i = 0; i < lista.length; i++) {
    if (!(lista[i].rating < lminRat || lista[i].rating > lmaxRat)) {
      list2.add(lista[i]);
    }
  }

  return list2;
}

List<Place> priceFilter(List<Place> lista, double lminPri, double lmaxPri) {
  List<Place> list3 = [];
  for (int i = 0; i < lista.length; i++) {
    if (!(lista[i].price < lminPri || lista[i].price > lmaxPri)) {
      list3.add(lista[i]);
    }
  }

  return list3;
}

List<Place> openFilter(List<Place> lista) {
  List<Place> list4 = [];
  for (int i = 0; i < lista.length; i++) {
    if (lista[i].openOrNot == "Open") {
      list4.add(lista[i]);
    }
  }

  return list4;
}

class PlanPage extends GetWidget<AuthController> {
  String rad = "5000";
  double minRat = 0;
  double maxRat = 5;
  double minPri = 0;
  double maxPri = 4;
  double isOpen = 0;
  String keyw = "";
  List<String> friends = [];

  RotatingBubblesCounter bub = RotatingBubblesCounter(
      initialCounter: 1 + Random().nextInt(10 - 1),
      initialColors: [
        Color.fromARGB(0xFF, 0xED, 0x61, 0x34),
        Color.fromARGB(0xFF, 0xFD, 0xDD, 0x93),
        Color.fromARGB(0xFF, 0xB9, 0x9A, 0xF1),
        Color.fromARGB(0xFF, 0x30, 0x17, 0x44),
        Color.fromARGB(0xFF, 0xC6, 0xFC, 0xAD),
      ],
      blend: BlendMode.darken);

  PlanPage(String radius, double minRating, double maxRating, double minPrice,
      double maxPrice, double open, String keyword, List<String> amigos) {
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
  final List<List<dynamic>> fotosvacias = [];
  final List<double> latitudes = [];
  final List<double> longitudes = [];
  final HttpService httpService = HttpService();
  late final CollectionReference _path = controller.path();
  int numList = 10;

  RxBool titleText = false.obs;

  Future cargaDatos() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    String lat = _locationData.latitude.toString();
    String lon = _locationData.longitude.toString();

    List<Place> listaVacia = [];

    List<Place> lista =
        await httpService.getPlaces(lat, lon, rad, listaVacia, "", keyw);


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

    List<Place> lista2 = [];
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
    }
    else {
      //Plan with friends
      //lista de sitios
      lista.shuffle();


      List<Map<dynamic, dynamic>> listaa = [];



      String user = controller.userFirebase!.uid;
      Map data = Map();
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

      Map sitioMap1 = Map();
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
        //user = "QDZogOup85aHZUeLSDabxkt9A7z2";
        data = new Map();
        data["user"] = user;
        data["locations"] = <Map<dynamic, dynamic>>[];

        listaCategorias = catAux.toSet().toList();
        for (String cat in listaCategorias) {
          data["locations"].add({"category": cat});
        }
        //Map data = {"user":user,"locations":[{"category":"Bar"},{"category":"Restaurant"}]};
        body = json.encode(data);
        link =
        "https://us-central1-do-something-329717.cloudfunctions.net/modelCors6";
        res = await http.post(Uri.parse(link),
            headers: {"Content-Type": "application/json"}, body: body);
        listaSitios = [];
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

                lista3.add(sitioMap2);
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

    }
    int cont = 0;
    for (var place in lista2) {
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
    if (lista2.length < 10) {
      numList = lista2.length;
    }

    titleText.value = true;

  }

  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Lexend',
            primaryColor: const Color(0xFF010101),
          ),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(controller.blanco),
              foregroundColor: Color(controller.blanco),
              elevation: 0,
              title: Obx(()=>
                  Visibility(
                    visible: titleText.value,
                  child: const Text(
                    'Do Something',
                    style: TextStyle(
                        color: Color(0xFF301744),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lexend'),
                  ),
                ),
              ),
              leading: Obx(()=>
                  Visibility(
                  visible: titleText.value,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Color(controller.purpura)),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ),
            backgroundColor: Color(controller.blanco),
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
                    return Container(
                      alignment: Alignment.topLeft,

                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                              shrinkWrap: true,
                              reverse: true,
                              children:  listaVista(context, numList)),
                        ),

                    );
                  }
                }),
          ));
    });
  }

  List<Widget> listaVista(BuildContext context, int i) {
    List<Widget> aux = [];
    if (i == 0) {
      aux.add(Row(
        children: const [
          Text(
            "0 results found",
            style: TextStyle(
              color: Color(0xFF301744),
            ),
          ),
        ],
      ));
    }
    while (i > 0) {
      aux.add(_buildItem(context, nombres[i - 1], fotos[i - 1], i - 1));
      i--;
    }

    return aux;
  }

  Widget _buildItem(BuildContext context, String s, List<dynamic> foto, int i) {
    if (foto != null) {
      return ListTile(
        dense: true,
        title: Text(
          categorias[i],
          style: const TextStyle(
            color: Color(0xFF301744),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        subtitle: Text(
          s,
          style: const TextStyle(
            color: Color(0xFF301744),
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
          _precio(i) + "  " + _rating(i),
          style: const TextStyle(
            color: Color(0xFF301744),
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
            color: Color(0xFF301744),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        subtitle: Text(
          s,
          style: const TextStyle(
            color: Color(0xFF301744),
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
            color: Color(0xFF301744),
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
              fotos: fotosvacias,
              //esto hay que cambiarlo
              latitud: latitudes[i],
              longitud: longitudes[i],
              id: ides[i],
            ),
          );
        },
      );
    }
  }

  AssetImage decideImagen() {
    int rand = Random().nextInt(9);
    AssetImage imagen = const AssetImage('assets/1.png');
    switch (rand) {
      case 0:
        imagen = const AssetImage('assets/2.png');
        break;
      case 1:
        imagen = const AssetImage('assets/3.png');
        break;
      case 2:
        imagen = const AssetImage('assets/4.png');
        break;
      case 3:
        imagen = const AssetImage('assets/5.png');
        break;
      case 4:
        imagen = const AssetImage('assets/6.png');
        break;
      case 5:
        imagen = const AssetImage('assets/7.png');
        break;
      case 6:
        imagen = const AssetImage('assets/8.png');
        break;
      case 7:
        imagen = const AssetImage('assets/9.png');
        break;
      case 8:
        imagen = const AssetImage('assets/10.png');
        break;
      case 9:
        imagen = const AssetImage('assets/1.png');
        break;
    }
    return imagen;
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
