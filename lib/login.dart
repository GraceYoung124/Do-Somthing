import 'package:do_something/firebase_auth_controller.dart';
import 'package:do_something/signup_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              alignment: Alignment.topLeft,
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
                            "Welcome to",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                              //color: Colors.white,
                            ),
                          ),
                          Text(
                            "DoSomething!",
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
                          decorationColor: Color(controller.purpura),
                          color: Color(controller.purpura),
                        ),
                        decoration: InputDecoration(
                          fillColor: Color(controller.purpura),
                          focusColor: Color(controller.purpura),
                          hintText: 'EMAIL',
                          hintStyle: TextStyle(
                              fontSize: 20.0, color: Color(controller.purpura)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(controller.purpura),
                            ),
                          ),
                          hoverColor: Color(controller.purpura),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(controller.purpura)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(controller.purpura)),
                          ),
                        ),
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 5,
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
                              fontSize: 20.0, color: Color(controller.purpura)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(controller.purpura),
                            ),
                          ),
                          hoverColor: Color(controller.purpura),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(controller.purpura)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(controller.purpura)),
                          ),
                        ),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child:
                            TextButton(
                                onPressed: () {
                                  controller.anonimusLogin();
                                },
                                child: Text(
                                  'GUEST',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(controller.purpura),
                                  ),
                                )
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: FloatingActionButton.extended(
                              backgroundColor: Color(controller.purpura),
                              label: const Text(
                                'LOG IN',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () {
                                controller.login(_emailController.text,
                                    _passwordController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 180,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('NEW HERE? ',
                                style: TextStyle(
                                  color: Color(controller.purpura),
                                )
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => SignUp());
                              },
                              child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(controller.purpura),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      if(!kIsWeb)
                      Container(
                        alignment: Alignment.center,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            controller.googleSignInMethod();
                          },
                          icon: Image.asset(
                            'assets/icon_google_32x32.png',
                            height: 20,
                            width: 20,
                          ),
                          label: Text(
                            'CONTINUE WITH GOOGLE',
                            style: TextStyle(
                              color: Color(controller.purpura),
                            ),
                          ),
                          backgroundColor: Color(controller.blanco),
                        ),
                      ),

                    ]
                ),
              )
          ),
        )
    );
  }
}