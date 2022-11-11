
import 'dart:ui';

class Place {

   late String name;
   late List<dynamic> photos;
   late String place_id;
   late double rating;
   late String type;
   late double price;
   late String openOrNot;
   late double compounded;
   late double lat;
   late double lon;
   //final List<dynamic> noImage = 'assets/noImage.png';
   //late String url;


//List<String> types,
  //,  String url
  Place(String name, String place_id, var rating, List types, var price_level, var opening_hours, var compound, List<dynamic> photos,var lat,var lon) {
    double cero = 0;
   this.name = name;
  // this.photos = photos;
    if(photos.runtimeType != null) {
      this.photos = photos;
    }

   this.place_id = place_id;
   if(rating.runtimeType == int){this.rating = rating.toDouble();}
   else if (rating.runtimeType == double) {this.rating = rating;} //Necesario por si la respuesta de la api es int
        else {this.rating = cero;}

   if(types[0].runtimeType == String) {
     if(types[0] == "point_of_interest") {this.type = (types[1][0].toUpperCase() + types[1].substring(1)).replaceAll(RegExp(r'_'), ' ');}
     else{this.type = (types[0][0].toUpperCase() + types[0].substring(1)).replaceAll(RegExp(r'_'), ' ');}

   }
   else {this.type = "Unknown";}

  if (price_level.runtimeType == int) {
    if (price_level == 0) {
      //this.price = "Free!";
      this.price = 0;
    }
    else if (price_level == 1) {
      //this.price = "\$";
      this.price = 1;
    }
    else if (price_level == 2) {
      //this.price = "\$\$";
      this.price = 2;
    }
    else if (price_level == 3) {
      //this.price = "\$\$\$";
      this.price = 3;
    }
    else {
      //this.price = "\$\$\$\$";
      this.price = 4;
    }
  }
  else {
    //this.price = "";
    this.price = 0;
  }



   if(opening_hours.runtimeType != Null){
     if(opening_hours['open_now']) {this.openOrNot = "Open";}
     else{this.openOrNot = "Closed";}
   }
   else {this.openOrNot = "";}




    if(compound.runtimeType == int){this.compounded = compound.toDouble();}
    else if (compound.runtimeType == double) {this.rating = compound;}
    else {this.compounded = cero;}


   this.lat = lat.toDouble();
   this.lon = lon.toDouble();

  }

}

class PlacePhoto {
  final String referencia;
  final int height;
  final int width;
  const PlacePhoto(this.referencia, this.height, this.width);
}




