import 'package:do_something/firebase_auth_controller.dart';
import 'package:do_something/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          alignment: Alignment.center,
          color: Color(controller.blanco),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sign up &",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        //color: Colors.white,
                      ),
                    ),
                    Text(
                      "DoSomething today!",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  cursorColor: Color(controller.purpura),
                  style: TextStyle(
                    color: Color(controller.purpura),
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(controller.purpura),
                    focusColor: Color(controller.purpura),
                    hintText: 'USERNAME',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color(controller.purpura),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    hoverColor: Color(controller.purpura),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                  ),
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Color(controller.purpura),
                  style: TextStyle(
                    color: Color(controller.purpura),
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(controller.purpura),
                    focusColor: Color(controller.purpura),
                    hintText: 'EMAIL',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color(controller.purpura),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    hoverColor: Color(controller.purpura),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                  ),
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Color(controller.purpura),
                  style: TextStyle(
                    color: Color(controller.purpura),
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(controller.purpura),
                    focusColor: Color(controller.purpura),
                    hintText: 'PASSWORD',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color(controller.purpura),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    hoverColor: Color(controller.purpura),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Color(controller.purpura),
                  style: TextStyle(
                    color: Color(controller.purpura),
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(controller.purpura),
                    focusColor: Color(controller.purpura),
                    hintText: 'REPEAT PASSWORD',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color(controller.purpura),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    hoverColor: Color(controller.purpura),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(controller.purpura),
                      ),
                    ),
                  ),
                  obscureText: true,
                  controller: _repeatController,
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.center,
                  child: FloatingActionButton.extended(
                    backgroundColor: Color(controller.purpura),
                    label: const Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      if (testSamePass(
                          _repeatController.text, _passwordController.text)) {
                        controller.createUserFireAuth(_emailController.text,
                            _passwordController.text, _usernameController.text);
                      }else{
                        Get.snackbar("Register Error", "Passwords don't match",
                            backgroundColor: Color(controller.amarillo),
                            colorText: Color(controller.purpura),
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HAVE AN ACCOUNT? ',
                        style: TextStyle(
                          color: Color(controller.purpura),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(
                                () => Login(),
                          );
                        },
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                              color: Color(controller.purpura),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
bool testSamePass(String pass, String otherPass) {
  if (pass == otherPass) {
    return true;
  } else {
    return false;
  }
}
