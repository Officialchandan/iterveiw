import 'dart:ffi';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview/home_page.dart';
import 'package:interview/login_page/bg_images.dart';
import 'package:interview/login_page/model/user_model.dart';
import 'package:interview/login_page/sinup.dart';
import 'package:interview/main.dart';
import 'package:interview/utilits.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {
                        context.setLocale(const Locale('hi'));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()));
                      },
                      child: const Text("Hindi")),
                  TextButton(
                      onPressed: () {
                        context.setLocale(const Locale('en', 'US'));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()));
                      },
                      child: const Text("English")),
                ]),
                Text(
                  "login_title".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  email: _email,
                  hintText: "your_name".tr(),
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  password: _password,
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "login_title".tr(),
                  press: () async {
                    await save();
                    setState(() {});
                    print("email${_email.text.toString()}");
                    print("password${_password.text.toString()}");

                    if (_formKey.currentState!.validate()) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => const HomePage()));
                      return null;
                    } else {
                      print("Not Login");
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Singup();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    await MyApp.init();
    localStorage.setString('email', _email.text.toString());
    localStorage.setString('password', _password.text.toString());
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text,
            style: const TextStyle(color: kPrimaryLightColor),
          ),
          onPressed: () {
            press();
          },
          style: ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "don't_have_an_account".tr(),
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          // onTap: () {} press,
          child: Text(
            "sign_up".tr(),
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;

  final IconData icon;
  TextEditingController email;
  final ValueChanged<String> onChanged;
  RoundedInputField({
    Key? key,
    required this.hintText,
    required this.email,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Material(
        color: kPrimaryLightColor,
        child: TextFormField(
          controller: email,
          autofillHints: const [AutofillHints.email],
          autovalidate: true,
          validator: (value) {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = RegExp(pattern.toString());
            if (value == null || value.isEmpty) {
              return 'Please enter email..';
            } else if (!(regex.hasMatch(value))) {
              return "please enter a valid email";
            }
          },
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController password;

  RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.password,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    bool _isObscure = true;

    return TextFieldContainer(
      child: Material(
        color: kPrimaryLightColor,
        child: TextFormField(
          controller: widget.password,
          autofillHints: const [AutofillHints.password],
          autovalidate: true,
          maxLength: 10,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            } else if (value.length < 6) {
              return "Please enter 6 digit password";
            } else if (value.length > 8) {
              return "Please enter 8 digit password";
            }
          },
          obscureText: true,
          onChanged: widget.onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: "your_password".tr(),
            counterText: "",
            icon: const Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            border: InputBorder.none,
            suffixIcon: textChange(_isObscure),
          ),
        ),
      ),
    );
  }

  IconButton textChange(bool _isObscure) {
    return IconButton(
      icon: Icon(
        _isObscure ? Icons.visibility : Icons.visibility_off,
        color: kPrimaryColor,
      ),
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
    );
  }
}

class TextFieldContainer extends StatefulWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: widget.child,
    );
  }
}
