import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/globals/my_regexp.dart';
import 'package:summiteagle/globals/textfield_design.dart';
import 'package:summiteagle/globals/widget.dart';
import 'package:summiteagle/services/auth.dart';
import 'package:summiteagle/services/firestore/admin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AppConfig {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextFieldDesign _tDes = TextFieldDesign();
  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  final AuthService _auth = AuthService();
  bool obscureText = true;
  bool isRemember = false;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailSubject
        .debounceTime(const Duration(milliseconds: 800))
        .listen((text) {
      _formKey.currentState!.validate();
    });
    _passwordSubject
        .debounceTime(const Duration(milliseconds: 800))
        .listen((event) {
      _formKey.currentState!.validate();
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final Admin admin = Admin();
  bool _isLoading = false;
  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });

    await _auth
        .signIn(
      context,
      email: _emailController.text,
      password: _passwordController.text,
      isRememberd: isRemember,
    )
        .then((value) async {
      if (value != null) {
        setState(() {
          loggedUser = value;
        });
        await admin.isAdmin();
        Navigator.pushReplacementNamed(context, '/landing_page');
      }
    }).whenComplete(() => setState(
              () => _isLoading = false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            body: LayoutBuilder(
              builder: (_, constraint) {
                double cardVertPadd = constraint.maxWidth > 800
                    ? 20
                    : (sqrt(constraint.maxHeight - constraint.maxWidth * .5) *
                                5)
                            .isNaN
                        ? 20
                        : sqrt(constraint.maxHeight -
                                constraint.maxWidth * .5) *
                            3;
                return Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight,
                  // color: Colors.grey.shade900,
                  child: Stack(
                    children: [
                      Image.network(
                        "https://drive.google.com/uc?id=17tYrTocLetMupZ1D6FKYBqPjgMfMa_7A",
                        width: constraint.maxWidth,
                        height: constraint.maxHeight,
                        fit: constraint.maxWidth > 1400
                            ? BoxFit.fitWidth
                            : BoxFit.fitHeight,
                        colorBlendMode: BlendMode.dstATop,
                        color: Colors.grey.shade900
                            .withOpacity(constraint.maxWidth <= 800 ? 0 : 1),
                      ),
                      // CachedNetworkImage(
                      // width: constraint.maxWidth,
                      // height: constraint.maxHeight,
                      // fit: constraint.maxWidth > 1400
                      //     ? BoxFit.fitWidth
                      //     : BoxFit.fitHeight,
                      //   cacheKey: "bg-image",
                      //   colorBlendMode: BlendMode.dstATop,
                      // color: Colors.grey.shade900
                      //     .withOpacity(constraint.maxWidth <= 800 ? 0 : 1),
                      //   imageUrl:
                      //       "https://drive.google.com/uc?id=17tYrTocLetMupZ1D6FKYBqPjgMfMa_7A",
                      //   // "https://static.vecteezy.com/system/resources/previews/005/299/230/non_2x/financial-stock-market-graph-on-stock-market-investment-trading-bullish-point-bearish-point-trend-of-graph-for-business-idea-and-all-art-work-design-illustration-vector.jpg",
                      // ),
                      // Text(constraint.maxWidth.toString()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraint.maxWidth <= 800
                              ? 0
                              : constraint.maxWidth * .27,
                          vertical: constraint.maxWidth <= 800
                              ? 0
                              : constraint.maxHeight * .01,
                        ),
                        child: Align(
                          alignment: constraint.maxWidth <= 800
                              ? Alignment.topCenter
                              : Alignment.center,
                          child: Card(
                            color: constraint.maxWidth <= 800
                                ? Colors.transparent
                                : Colors.grey.shade100,
                            shadowColor: constraint.maxWidth <= 800
                                ? Colors.transparent
                                : Colors.grey.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: cardVertPadd,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: constraint.maxHeight * .01,
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Container(
                                        // height: 90,
                                        padding: const EdgeInsets.all(0),
                                        alignment: Alignment.center,
                                        child: logo,
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            TextFormField(
                                              onFieldSubmitted: (text) async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _emailController.text =
                                                        _emailController.text
                                                            .replaceAll(
                                                                RegExp(r"\s+"),
                                                                "");
                                                  });
                                                  await login();
                                                }
                                              },
                                              validator: (text) {
                                                if (text!.isEmpty) {
                                                  return "This field is required";
                                                }
                                                if (!text.isEmail) {
                                                  return "Invalid email";
                                                }
                                                return null;
                                              },
                                              onChanged: (text) {
                                                _emailSubject.add(text);
                                              },
                                              controller: _emailController,
                                              cursorColor: black,
                                              style: TextStyle(
                                                color: black,
                                              ),
                                              decoration:
                                                  _tDes.defaultDecoration(
                                                hintText: "Enter your email",
                                                labelText: "Email",
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              onFieldSubmitted: (text) async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _emailController.text =
                                                        _emailController.text
                                                            .replaceAll(
                                                                RegExp(r"\s+"),
                                                                "");
                                                  });
                                                  await login();
                                                }
                                              },
                                              onChanged: (text) {
                                                _passwordSubject.add(text);
                                              },
                                              validator: (text) {
                                                if (text!.isEmpty) {
                                                  return "This field is required";
                                                }
                                                return null;
                                              },
                                              cursorColor: black,
                                              style: TextStyle(
                                                color: black,
                                              ),
                                              obscureText: obscureText,
                                              controller: _passwordController,
                                              decoration:
                                                  _tDes.defaultDecoration(
                                                hintText: "Enter your password",
                                                labelText: "Password",
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() => obscureText =
                                                        !obscureText);
                                                  },
                                                  icon: Icon(
                                                    obscureText
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                runAlignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 250,
                                                    child: Row(
                                                      children: [
                                                        Checkbox(
                                                          activeColor: black,
                                                          value: isRemember,
                                                          checkColor:
                                                              Colors.white,
                                                          side: BorderSide(
                                                            color: black,
                                                          ),
                                                          onChanged: (bo) =>
                                                              setState(() =>
                                                                  isRemember =
                                                                      !isRemember),
                                                        ),
                                                        Text(
                                                          "Remember me",
                                                          style: TextStyle(
                                                            color: black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  SizedBox(
                                                    child: TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        "Forgot Password",
                                                        style: TextStyle(
                                                          color: orange,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: double.maxFinite,
                                              height: 60,
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      _emailController.text =
                                                          _emailController.text
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r"\s+"),
                                                                  "");
                                                    });
                                                    await login();
                                                  }
                                                },
                                                color: orange,
                                                child: const Center(
                                                  child: Text(
                                                    "LOGIN",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "No account yet ? ",
                                                  style: TextStyle(
                                                    color: black,
                                                    fontSize: 17,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                "/register_page",
                                                              );
                                                            },
                                                      text: "Create Account",
                                                      style: TextStyle(
                                                        color: orange,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _isLoading ? loader(color: Colors.blue.shade800) : Container(),
        ],
      ),
    );
  }
}
