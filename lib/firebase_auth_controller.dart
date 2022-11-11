import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_something/gustos_page.dart';
import 'package:do_something/login.dart';
import 'package:do_something/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'boton_principal_page.dart';

class AuthController extends GetxController {
  //FireAuth

  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  User? get userFirebase => firebaseUser.value;

  //FireStore
  FirebaseFirestore store = FirebaseFirestore.instance;
  var _pathFirestoreUser = FirebaseFirestore.instance.collection('dbUser');

  //Google
  GoogleSignIn _googleSignin = GoogleSignIn();

  //FirebaseStorage
  FirebaseStorage storage = FirebaseStorage.instance;

  //Colores
  var naranja = 0xFFED6134;
  var amarillo = 0xFFFDDD93;
  var morado = 0xFFB9ACF1;
  var purpura = 0xFF301744;
  var blanco = 0xFFFFFCF6;
  var verde = 0xFFC6FCAD;

  var estado = 'Normal'.obs;

  @override
  onInit() async {
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUserFireAuth(
      String email, String password, String username) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Future.delayed(const Duration(milliseconds: 1000));
      createUserFirestore(username, email, firebaseUser.value!.uid, "noURL", 0);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Creating Account", e.message!,
          backgroundColor: Color(amarillo),
          colorText: Color(purpura),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => BotonPrincipal());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Logging In", e.message!,
          backgroundColor: Color(amarillo),
          colorText: Color(purpura),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> createUserFirestore(String username, String email, String id,
      String pathImage, int servicio) async {
    //Firebase = 0 Google = 1 Anonimo = 2
    try {
      if (!(await checkIfDocExists(id))) {
        await _pathFirestoreUser.doc(id).set(
          {
            'username': username,
            'email': email,
            'urlPhoto':
                'https://firebasestorage.googleapis.com/v0/b/dosomething-f63e2.appspot.com/o/imagenPorDefecto.png?alt=media',
            'serviceLogin': servicio.toString(),
            'photoCounter': "0",
          },
        );

        if (!userFirebase!.isAnonymous) {
          Get.to(() => GustosPage());
        }
        return true;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Signing Out", e.message!,
          backgroundColor: Color(amarillo),
          colorText: Color(purpura),
          snackPosition: SnackPosition.BOTTOM);
    }
    return false;
  }

  void logOut() async {
    // firebaseUser.close();
    //await _googleSignin.signOut();
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
    Get.offAll(() => Login());
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var doc = await _pathFirestoreUser.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    var aux2 = await _auth.signInWithCredential(credential);
    print(aux2.user!.photoURL);
    bool aux;

    //await uploadFile(googleUser.photoUrl.toString(), ".jpg");
    //String urlPhoto = await storage.ref('imagenDePerfil/'+userFirebase!.uid).getDownloadURL().toString();
    aux = await createUserFirestore(googleUser.displayName.toString(),
        googleUser.email, userFirebase!.uid, googleUser.photoUrl.toString(), 1);
    if (!aux) {
      Get.offAll(() => BotonPrincipal());
    }
  }

  void anonimusLogin() async {
    UserCredential user = await _auth.signInAnonymously();
    createUserFirestore('anonymous-' + user.user!.uid,
        user.user!.uid + '@dosomething.com', user.user!.uid, "noURL", 2);
    await Future.delayed(Duration(milliseconds: 2000));
    Get.offAll(() => BotonPrincipal());
  }

  CollectionReference path() {
    return FirebaseFirestore.instance
        .collection('dbUser')
        .doc(userFirebase!.uid)
        .collection('entries');
  }

  Future<UserModel> getFireStoreUser() async {
    try {
      DocumentSnapshot doc =
          await _pathFirestoreUser.doc(userFirebase!.uid).get();
      var aux = UserModel(
        id: doc.id,
        name: doc['username'],
        email: doc['email'],
        urlPhoto: doc['urlPhoto'],
        serviceLogin: doc['serviceLogin'],
        photoCounter: doc['photoCounter'],
      );
      return aux;
    } catch (e) {
      print(e);
    }
    return UserModel(
        id: 'error',
        name: 'error',
        email: 'error',
        urlPhoto: 'error',
        serviceLogin: 'error',
        photoCounter: 'error');
  }

  Future uploadImage(String filePath, String fileName, String id) async {
    File file = File(filePath);

    try {
      await storage.ref('imagenDePerfil/' + id + '/' + fileName).putFile(file);
    } on FirebaseException catch (e) {
      Get.snackbar("Error Creating Account", e.message!,
          backgroundColor: Color(amarillo),
          colorText: Color(purpura),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future addFriend(String id) async {
    String idFriend = id;
    if (!(await checkIfDocCollectionExists(idFriend)) &&
        await checkIfIdExists(idFriend) &&
        idFriend != userFirebase!.uid) {
      FirebaseFirestore.instance
          .collection('dbUser')
          .doc(userFirebase!.uid)
          .collection('friends')
          .doc(idFriend)
          .set({'friendId': idFriend});
      FirebaseFirestore.instance
          .collection('dbUser')
          .doc(idFriend)
          .collection('friends')
          .doc(userFirebase!.uid)
          .set({'friendId': userFirebase!.uid});
    }
  }

  Future<bool> checkIfDocCollectionExists(String docId) async {
    try {
      var doc = await _pathFirestoreUser
          .doc(userFirebase!.uid)
          .collection('friends')
          .doc(docId)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkIfIdExists(String docId) async {
    var aux = false;
    try {
      await FirebaseFirestore.instance
          .collection('dbUser')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (docId == doc.id.toString()) {
            aux = true;
          }
          ;
        });
      });
      return aux;
    } catch (e) {
      throw e;
    }
  }

  //Future List<String> getFriends() async{
  //List<String> aux = [];
  Future<List<String>> getFriendsId() async {
    late List<String> aux = [];
    try {
      await FirebaseFirestore.instance
          .collection('dbUser')
          .doc(userFirebase!.uid)
          .collection('friends')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          aux.add(doc.get('friendId'));
        });
      });
      return aux;
    } catch (e) {
      throw e;
    }
  }

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    List<UserModel> aux = [];
    try {
      for (int i = 0; i < ids.length; i++) {
        DocumentSnapshot doc = await _pathFirestoreUser.doc(ids[i]).get();
        aux.add(
          UserModel(
            id: doc.id,
            name: doc['username'],
            email: doc['email'],
            urlPhoto: doc['urlPhoto'],
            serviceLogin: doc['serviceLogin'],
            photoCounter: doc['photoCounter'],
          ),
        );
      }
      return aux;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
