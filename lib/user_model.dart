
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserModel {
  String id = "";
  String name = "";
  String email = "";
  String urlPhoto = "";
  String serviceLogin = "";
  String photoCounter = "";

  UserModel({required this.id, required this.name, required this.email, required this.urlPhoto, required this.serviceLogin,required this.photoCounter});

}
