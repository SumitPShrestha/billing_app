import 'package:billing_app/common/components/button.dart';
import 'package:billing_app/common/components/header1.dart';
import 'package:billing_app/common/components/text_input.dart';
import 'package:billing_app/common/page/landing_screen.dart';
import 'package:billing_app/model/addrress.dart';
import 'package:billing_app/services/auth_service.dart';
import 'package:billing_app/services/user_service.dart';
import 'package:flutter/material.dart';

import '../../../model/userDTO.dart';
import '../../consants/style-constants.dart';
import '../../components/glass_container.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController name =
      TextEditingController(text: "Sumit Prakash Shrestha");
  TextEditingController username =
      TextEditingController(text: "sumitpshrestha");
  TextEditingController password = TextEditingController(text: "password");
  TextEditingController phone = TextEditingController(text: "9846599987");
  TextEditingController email =
      TextEditingController(text: "sumitpshrestha@gmail.com");

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return LandingScreen(
      appBarTitle: "Kurung Apparels",
      backButton: true,
      mainComponent: Container(
        alignment: Alignment.center,

          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  height: fullHeight * .2,
                  width: fullWidth * .3,
                  child: Image.asset('assets/images/Logo.png'),
                ),
                Header1(title: "Sign Up"),
                Center(
                  child: TextInput(
                    controller: name,
                    label: "Full Name",
                    isRequired: true,
                  ),
                ),
                Center(
                  child: TextInput(
                    controller: username,
                    label: "username",
                    isRequired: true,
                  ),
                ),
                Center(
                  child: TextInput(
                      controller: password,
                      label: "password",
                      obscureText: true,
                      isRequired: true),
                ),
                Center(
                  child: TextInput(
                      controller: phone,
                      label: "Phone",
                      keyboardType: TextInputType.phone,
                      isRequired: true),
                ),
                Center(
                  child: TextInput(
                      controller: email,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      isRequired: true),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Center(
                    child: Button(
                        label: "Sign Up",
                        height: fullHeight * .06,
                        width: fullWidth * .8,
                        onTap: () async {
                          String usernameVal = username.value.text;
                          String phoneVal = phone.value.text;
                          String nameVal = name.value.text;
                          String passwordVal = password.value.text;
                          String emailVal = email.value.text;
                          User user = User(null, nameVal, usernameVal,
                              passwordVal, emailVal, phoneVal);

                          await UserService()
                              .createUser(user)
                              .then((val) {
                            SnackBar snackBar = SnackBar(
                              content:
                                  Text('User ${user.full_name} is created'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
