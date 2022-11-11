import 'package:do_something/boton_principal_page.dart';
import 'package:do_something/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'firebase_auth_controller.dart';

class FotoController extends GetxController {
  var _photo = "".obs;
  var normalBlanco = 0xFFFFFCF6.obs; //blanco
  var normalPurpura = 0xFF301744.obs; //purpura
  RxList friendsList = RxList<UserModel>();
  RxList<Widget> widgetList = RxList<Widget>();
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
class FriendsPage extends GetWidget<AuthController> {
  UserModel user = UserModel(
    email: "",
    id: "",
    name: "",
    urlPhoto: "",
    serviceLogin: "",
    photoCounter: "",
  );
  TextEditingController controllerNewCode = TextEditingController();
  FotoController ctrl = FotoController();
  late List<String> friendsIds = [];
  late int numOfFriends;

  Future cargaDatos(BuildContext context) async {
    friendsIds = await controller.getFriendsId();
    numOfFriends = friendsIds.length;
    if (numOfFriends > 0) {
      ctrl.friendsList.value = await controller.getUsersByIds(friendsIds);
    }
    user = await controller.getFireStoreUser();
    ctrl._photo.value = user.urlPhoto;

    if (controller.estado.value == 'Normal') {
      ctrl.normalBlanco.value = controller.blanco;
      ctrl.normalPurpura.value = controller.purpura;
    }
    if (controller.estado.value == 'Mystery') {
      ctrl.normalBlanco.value = controller.purpura;
      ctrl.normalPurpura.value = controller.blanco;
    }
    ctrl.widgetList.value = listaVista(context, numOfFriends);


  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(ctrl.normalBlanco.value),
            title: Text(
              "Friends",
              style: TextStyle(
                color: Color(ctrl.normalPurpura.value),
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(ctrl.normalPurpura.value),
              ),
              onPressed: () => Get.back(), //(BotonPrincipal()),
            ),
            elevation: 0,
          ),
          backgroundColor: Color(ctrl.normalBlanco.value),
          body: FutureBuilder(
              future: cargaDatos(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                } else {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    color: Color(ctrl.normalBlanco.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2.0,
                                color: Color(ctrl.normalPurpura.value)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(ctrl._photo.value).image,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(
                          user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(ctrl.normalPurpura.value),
                              fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Row(
                          children: [
                            Text(
                              'MY CODE: ',
                              style: TextStyle(
                                  color: Color(ctrl.normalPurpura.value),
                                fontWeight: FontWeight.bold),

                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Row(
                          children: [
                            Text(
                              '     ' + user.id,
                              style: TextStyle(
                                  color: Color(ctrl.normalPurpura.value),
                                  fontWeight: FontWeight.w500),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                            ),
                            TextButton.icon(
                              label: const Text(''),
                              icon: Icon(
                                Icons.copy,
                                color: Color(ctrl.normalPurpura.value),
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: user.id));
                                Get.snackbar(
                                  'Code Copied!',
                                  'Share with your friends',
                                  backgroundColor: Color(controller.amarillo),
                                  colorText: Color(controller.purpura),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Row(
                          children: [
                            Text(
                              'ADD FRIENDS:',
                              style: TextStyle(
                                  color: Color(ctrl.normalPurpura.value),
                                fontWeight: FontWeight.bold),

                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                cursorColor: Color(ctrl.normalPurpura.value),
                                style: TextStyle(
                                  decorationColor:
                                      Color(ctrl.normalPurpura.value),
                                  color: Color(ctrl.normalPurpura.value),
                                ),
                                decoration: InputDecoration(
                                  fillColor: Color(ctrl.normalPurpura.value),
                                  focusColor: Color(ctrl.normalPurpura.value),
                                  hintText: 'Friend Code',
                                  hintStyle: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                      //Color(controller.morado),
                                      fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(ctrl.normalPurpura.value),
                                    ),
                                  ),
                                  hoverColor: Color(ctrl.normalPurpura.value),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ctrl.normalPurpura.value)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ctrl.normalPurpura.value)),
                                  ),
                                ),
                                controller: controllerNewCode,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(4.0)),
                            TextButton.icon(
                              label: const Text(''),
                              icon: Icon(
                                Icons.check,
                                color: Color(ctrl.normalPurpura.value),
                              ),
                              onPressed: () async {
                                if (await controller
                                    .checkIfIdExists(controllerNewCode.text)) {
                                  if (!(await controller
                                      .checkIfDocCollectionExists(
                                          controllerNewCode.text))) {
                                    await controller
                                        .addFriend(controllerNewCode.text);

                                    await cargaDatos(context);



                                  } else {
                                    Get.snackbar(
                                      'Friend Already Added',
                                      'You can only add a friend once',
                                        backgroundColor:
                                        Color(controller.amarillo),
                                        colorText: Color(controller.purpura),
                                        snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    'User Code is Incorrect',
                                    'Check that the code is correct',
                                      backgroundColor:
                                      Color(controller.amarillo),
                                      colorText: Color(controller.purpura),
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(16.0)),
                        Row(
                          children: [
                            Text(
                              'MY FRIENDS: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(ctrl.normalPurpura.value),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(4.0)),
                        Obx(()=>
                           Flexible(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView(
                              shrinkWrap: true,
                              reverse: false,
                              children: ctrl.widgetList.value,
                              padding: const EdgeInsets.all(4.0),
                            ),
                           ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  List<Widget> listaVista(BuildContext context, int i) {
    List<Widget> aux = [];
    if (i == 0) {
      aux.add(Row(
        children: [
          Text(
            "Add a friend!",
            style: TextStyle(
              color: Color(ctrl.normalBlanco.value),
            ),
          ),
        ],
      ));
    }
    while (i > 0) {
      aux.add(_buildItem(context, ctrl.friendsList.value[i - 1], i - 1));
      i--;
    }
    return aux;
  }

  Widget _buildItem(BuildContext context, UserModel s, int i) {
    return ListTile(
      dense: true,
      title: Text(
        s.name,
        style: TextStyle(
          color: Color(ctrl.normalPurpura.value),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        s.id,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      leading: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Color(ctrl.normalPurpura.value),
              width: 2.0),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(
              s.urlPhoto,
            ),
          ),
        ),
      ),
    );
  }
}
