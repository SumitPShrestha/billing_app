import 'package:billing_app/common/components/button.dart';
import 'package:billing_app/common/components/header1.dart';
import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/common/consants/style-constants.dart';
import 'package:billing_app/common/page/dashboard_screeen.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:billing_app/common/page/auth/signup_screen.dart';
import 'package:billing_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../model/userDTO.dart';
import '../../components/glass_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginScreen> {
  TextEditingController username =
      TextEditingController(text: "sumitpshrestha");
  TextEditingController password = TextEditingController(text: "password");
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _credential;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService(_prefs);
    _credential = _prefs.then((SharedPreferences prefs) {
      return prefs.get('credential');
    });
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return LandingScreen(
      // appBarTitle: "Kurung Apparels",
      mainComponent: Container(
        alignment: Alignment.center,
        child: Form(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  height: fullHeight * .25,
                  width: fullWidth * .5,
                  child: Image.asset(
                    'assets/images/Logo.png',
                    height: fullHeight * .25,
                    width: fullWidth * .4,
                  ),
                ),
                Header1(title: "Login"),
                Center(
                  child: TextInput(
                    isRequired: true,
                    controller: username,
                    label: "username",
                  ),
                ),
                Center(
                  child: TextInput(
                      controller: password,
                      label: "password",
                      obscureText: true,
                      isRequired: true),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                  child: Center(
                    child: Button(
                        label: "Login",
                        height: fullHeight * .07,
                        width: fullWidth * 1,
                        onTap: () {
                          String usernameVal = username.value.text;
                          String passwordVal = password.value.text;
                          authService
                              .doLogin(usernameVal, passwordVal)
                              .then((User? value) {
                            if (value != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DashboardScreeen()));
                            } else {
                              SnackBar snackBar = SnackBar(
                                backgroundColor: Colors.grey.withOpacity(.5),
                                content: Text(
                                  'Sorry, $username cannot login. Kindly contact admin.',
                                  style: const TextStyle(color: errorColor),
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 15, 10),
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a user yet !",style: TextStyle(color: subTextGrey),),
                        TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen())),
                            child: const Text("Sign Up"))
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
