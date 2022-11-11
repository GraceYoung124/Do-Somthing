import 'package:do_something/boton_principal_page.dart';
import 'package:do_something/com_plan_page.dart';
import 'package:do_something/mys_plan_page.dart';
import 'package:do_something/plan_page.dart';
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
  var friendsSelected = [].obs;

  toogle(int index) {
    if (friendsSelected.contains(index)) {
      friendsSelected.remove(index);
    } else {
      friendsSelected.add(index);
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SelectFriends extends GetWidget<AuthController> {
  UserModel user = UserModel(
    email: "",
    id: "",
    name: "",
    urlPhoto: "",
    serviceLogin: "",
    photoCounter: "",
  );
  String rad = "5000";
  double minRat = 0;
  double maxRat = 5;
  double minPri = 0;
  double maxPri = 4;
  double isOpen = 0;
  String keyw = "";
  int friendMode = 0;
  double compoundValue = 0;
  //friendMode:
  //0=Normal
  //1=Compound
  //2=Mystery
  late List<String> selectedFriends = [];
  SelectFriends(String radius, double minRating, double maxRating, double minPrice,
      double maxPrice, double open, String keyword, int mode, double compVal) {
    rad = radius;
    minRat = minRating;
    maxRat = maxRating;
    minPri = minPrice;
    maxPri = maxPrice;
    isOpen = open;
    keyw = keyword;
    friendMode = mode;
    compoundValue = compVal;
  }
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
              "Select Friends",
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
              onPressed: () =>
                  Get.offAll(() => BotonPrincipal()), //(BotonPrincipal()),
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
                  alignment: Alignment.topLeft,
                  color: Color(ctrl.normalBlanco.value),
                  child: Obx(
                    () => Column(
                      children: [
                        Flexible(
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: ListView(
                              shrinkWrap: true,
                              reverse: false,
                              children: ctrl.widgetList.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Color(ctrl.normalPurpura.value),
                                shadowColor: Colors.white,
                                elevation: 0,
                                side: BorderSide(
                                  width: 0.0,
                                  color: Colors.white,
                                )),
                            onPressed: () {
                              if (selectedFriends.length == 0) {
                                Get.snackbar(
                                  'No Friends Selected',
                                  'Select at least one friend to continue',
                                  backgroundColor: Color(controller.amarillo),
                                  colorText: Color(controller.purpura),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              } else {
                                if (friendMode == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlanPage(
                                            rad,
                                            minRat,
                                            maxRat,
                                            minPri,
                                            maxPri,
                                            isOpen,
                                            keyw,
                                            selectedFriends),
                                      ));
                                } else if (friendMode == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                        builder: (context) =>
                            PlanComPage(
                                rad,
                                minRat,
                                maxRat,
                                minPri,
                                maxPri,
                                isOpen,
                                keyw,
                                compoundValue,
                                selectedFriends),
                      )
                  );
                }
                else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlanMysPage(
                                rad,
                                minRat,
                                maxRat,
                                minPri,
                                maxPri,
                                isOpen,
                                keyw,
                                selectedFriends),
                      )
                  );
                }
              }
                            },
                            child: Text('Continue',
                                style: TextStyle(
                                    fontSize: 22, color: Color(ctrl.normalBlanco.value))),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> listaVista(BuildContext context, int i) {
    List<Widget> aux = [];
    if (i == 0) {
      aux.add(Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Add a friend first!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(ctrl.normalPurpura.value),
              ),
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
    return Obx(
      () => Container(
        color: ctrl.friendsSelected.contains(i)
            ? Color(controller.verde)
            : Color(ctrl.normalBlanco.value),
        child: ListTile(
          subtitle: Text(" "),
          //dense: true,

          title: Text(
            s.name,
            style: TextStyle(
              color: Color(ctrl.normalPurpura.value),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          onTap: () {
            ctrl.toogle(i);
            friendsListControl(s.id);
          },

          leading: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Color(ctrl.normalPurpura.value), width: 2.0),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                  s.urlPhoto,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  friendsListControl(String id) {
    if (!(selectedFriends.contains(id))) {
      selectedFriends.add(id);
    } else {
      for (int i = 0; i < selectedFriends.length; i++) {
        if (selectedFriends[i] == id) {
          selectedFriends.removeAt(i);
        }
      }
    }
  }
}
