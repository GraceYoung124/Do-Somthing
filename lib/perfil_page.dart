import 'package:do_something/boton_principal_page.dart';
import 'package:do_something/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_auth_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FotoController extends GetxController {
  var _photo = "".obs;
  var _name = "".obs;
}

class ColorController extends GetxController {
  var normalBlanco = 0xFFFFFCF6.obs; //blanco
  var normalPurpura = 0xFF301744.obs; //purpura
}

class PerfilPage extends GetWidget<AuthController> {
  UserModel user = UserModel(
      email: "",
      id: "",
      name: "",
      urlPhoto: "",
      serviceLogin: "",
      photoCounter: "");
  FotoController ctrl = FotoController();
  ColorController cc = ColorController();
  final TextEditingController newNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(cc.normalBlanco.value),
            title: Text(
              "Account",
              style: TextStyle(
                color: Color(cc.normalPurpura.value),
              ),
            ),
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Color(cc.normalPurpura.value)),
              onPressed: () =>
                  Get.offAll(BotonPrincipal()),
            ),
            elevation: 0,
          ),
          backgroundColor: Color(cc.normalBlanco.value),
          body: FutureBuilder(
              future: cargaUsuario(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                } else {
                  return Obx(
                    () => Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Perfil',
                              style: TextStyle(
                                color: Color(cc.normalBlanco.value),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(cc.normalPurpura.value),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(cc.normalPurpura.value),
                                  width: 2.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(ctrl._photo.value),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                              Text(
                                'Email: ',
                                style: TextStyle(
                                  color: Color(cc.normalPurpura.value),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                user.email,
                                style: TextStyle(
                                  color: Color(cc.normalPurpura.value),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                              Text(
                                'Name: ',
                                style: TextStyle(
                                  color: Color(cc.normalPurpura.value),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                user.name,
                                style: TextStyle(
                                  color: Color(cc.normalPurpura.value),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          if(!kIsWeb)
                          ElevatedButton(
                            child: Text(
                              'Change profile image',
                              style: TextStyle(
                                  color: Color(cc.normalBlanco.value),
                                  fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Color(cc.normalPurpura.value),
                              shadowColor: Color(cc.normalBlanco.value),
                              elevation: 0,
                              minimumSize: const Size(200, 50),
                              //side: BorderSide(width: 2.0, color: Color(controller.blanco),)
                            ),
                            onPressed: () {
                              cambiarImagen(context);
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(40.0),
                          ),/*
                          ElevatedButton(
                            child: Text(
                              'Change name',
                              style: TextStyle(
                                  color: Color(cc.normalBlanco.value),
                                  fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Color(cc.normalPurpura.value),
                              shadowColor: Color(cc.normalBlanco.value),
                              elevation: 0,
                              minimumSize: const Size(200, 50),
                              //side: BorderSide(width: 2.0, color: Color(controller.blanco),)
                            ),
                            onPressed: () {},
                          ),*/
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          TextButton(
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                  color: Color(controller.naranja),
                                  fontSize: 16),
                            ),
                            /*
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Color(controller.naranja),
                              shadowColor: Color(controller.blanco),
                              elevation: 0,
                              minimumSize: const Size(200, 50),
                              //side: BorderSide(width: 2.0, color: Color(controller.blanco),)
                            ),*/
                            onPressed: () {
                              controller.logOut();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  Future cargaUsuario() async {
    user = await controller.getFireStoreUser();
    ctrl._photo.value = user.urlPhoto;
    ctrl._name.value = user.name;
    if (controller.estado.value == 'Normal') {
      cc.normalBlanco.value = controller.blanco;
      cc.normalPurpura.value = controller.purpura;
    }
    if (controller.estado.value == 'Mystery') {
      cc.normalBlanco.value = controller.purpura;
      cc.normalPurpura.value = controller.blanco;
    }
  }

  void cambiarImagen(BuildContext context) async {
    var results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file has been picked')));
      return null;
    }

    String path = results.files.single.path!;
    String fileName = results.files.single.name;

    if (fileName.toLowerCase().contains(".jpg")) {
      fileName =
          controller.firebaseUser.value!.uid + '_' + user.photoCounter + ".jpg";
    } else if (fileName.toLowerCase().contains(".png")) {
      fileName =
          controller.firebaseUser.value!.uid + '_' + user.photoCounter + ".png";
    }

    controller.uploadImage(path, fileName, user.id);
    user.photoCounter = (int.parse(user.photoCounter) + 1).toString();
    //var aux = await controller.storage.ref('imagenDePerfil/'+controller.userFirebase!.uid).getDownloadURL().toString();
    String url =
        "https://firebasestorage.googleapis.com/v0/b/dosomething-f63e2.appspot.com/o/imagenDePerfil%2F" +
            user.id +
            '%2F' +
            fileName +
            "?alt=media";
    controller.store
        .collection('dbUser')
        .doc(controller.userFirebase!.uid)
        .set({
      'email': user.email,
      'serviceLogin': user.serviceLogin,
      'urlPhoto': url,
      'username': user.name,
      'photoCounter': user.photoCounter
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    cargaUsuario();
    //Get.reloadAll();
    //Get.to(PerfilPage());
  }

  Future<String> downloadURL() async {
    String aux = await controller.storage
        .ref('imagenDePerfil/' + controller.userFirebase!.uid)
        .getDownloadURL();
    print(downloadURL);
    return aux;
  }
/*
  void dialogoCambiarNombre(BuildContext context) {
    SimpleDialog(
      title: const Text('Cambiar Nombre'),
      children: [
        const Text('Actual Name'),
        Text(user.name),
        const Text('New Name'),
        TextFormField(
          controller: ctrl._name,
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Ok'),
        ),
      ],
    );
  }
  */
}
