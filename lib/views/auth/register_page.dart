import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/globals/my_regexp.dart';
import 'package:summiteagle/globals/textfield_design.dart';
import 'package:summiteagle/globals/widget.dart';
import 'package:summiteagle/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with AppConfig {
  bool _isLoading = false;
  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _confPasswordSubject =
      BehaviorSubject<String>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextFieldDesign _tDes = TextFieldDesign();
  final AuthService _auth = AuthService();
  bool obscureText = true;
  bool obscureConfText = true;
  bool isRemember = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
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
    _confPasswordSubject
        .debounceTime(const Duration(milliseconds: 800))
        .listen((event) {
      _formKey.currentState!.validate();
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _auth
          .create(
        context,
        email: _emailController.text,
        password: _passwordController.text,
        fname: _firstName.text,
        lname: _lastName.text,
        isRemembered: isRemember,
      )
          .then((value) {
        if (value != null) {
          Navigator.pushReplacementNamed(
            context,
            '/landing_page',
          );
        }
      }).whenComplete(() => setState(() => _isLoading = false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            // backgroundColor: Colors.grey.shade900,
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
                return SizedBox(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: constraint.maxWidth,
                        height: constraint.maxHeight,
                        fit: constraint.maxWidth > 1400
                            ? BoxFit.fitWidth
                            : BoxFit.fitHeight,
                        colorBlendMode: BlendMode.dstATop,
                        color: Colors.grey.shade900
                            .withOpacity(constraint.maxWidth <= 800 ? 0 : 1),
                        cacheKey: "bg-image",
                        imageUrl:
                            "https://static.vecteezy.com/system/resources/previews/005/299/230/non_2x/financial-stock-market-graph-on-stock-market-investment-trading-bullish-point-bearish-point-trend-of-graph-for-business-idea-and-all-art-work-design-illustration-vector.jpg",
                      ),
                      Positioned.fill(
                        child: Padding(
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
                                  : Colors.white,
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(
                                                minWidth: 180,
                                                maxWidth: 350,
                                              ),
                                              width: constraint.maxWidth -
                                                  (((constraint.maxWidth <= 800
                                                              ? -300
                                                              : constraint
                                                                      .maxWidth *
                                                                  .3) *
                                                          2) +
                                                      350),
                                              child: const Text(
                                                "LETS GET STARTED!",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      34, 73, 87, 1),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 42,
                                                  height: .8,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                onFieldSubmitted: (text) async {
                                                  await register();
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
                                                onChanged: (text) {
                                                  _passwordSubject.add(text);
                                                },
                                                validator: (text) {
                                                  if (text!.isEmpty) {
                                                    return "This field is required";
                                                  }
                                                  if (text !=
                                                      _confPasswordController
                                                          .text) {
                                                    return "Password mismatch";
                                                  }
                                                  return null;
                                                },
                                                onFieldSubmitted: (text) async {
                                                  await register();
                                                },
                                                cursorColor: black,
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                                obscureText: obscureText,
                                                controller: _passwordController,
                                                decoration:
                                                    _tDes.defaultDecoration(
                                                  hintText:
                                                      "Enter your password",
                                                  labelText: "Password",
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() =>
                                                          obscureText =
                                                              !obscureText);
                                                    },
                                                    icon: Icon(
                                                      obscureText
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                onChanged: (text) {
                                                  _confPasswordSubject
                                                      .add(text);
                                                },
                                                validator: (text) {
                                                  if (text!.isEmpty) {
                                                    return "This field is required";
                                                  }
                                                  if (text !=
                                                      _passwordController
                                                          .text) {
                                                    return "Password mismatch";
                                                  }
                                                  return null;
                                                },
                                                onFieldSubmitted: (text) async {
                                                  await register();
                                                },
                                                cursorColor: black,
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                                obscureText: obscureConfText,
                                                controller:
                                                    _confPasswordController,
                                                decoration:
                                                    _tDes.defaultDecoration(
                                                  hintText:
                                                      "Confirm your password",
                                                  labelText: "Confirm Password",
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() =>
                                                          obscureConfText =
                                                              !obscureConfText);
                                                    },
                                                    icon: Icon(
                                                      obscureConfText
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                onFieldSubmitted: (text) async {
                                                  await register();
                                                },
                                                validator: (text) {
                                                  if (text!.isEmpty) {
                                                    return "This field is required";
                                                  }
                                                  return null;
                                                },
                                                controller: _firstName,
                                                cursorColor: black,
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                                decoration:
                                                    _tDes.defaultDecoration(
                                                  hintText:
                                                      "Enter your firstname",
                                                  labelText: "Firstname",
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                onFieldSubmitted: (text) async {
                                                  await register();
                                                },
                                                validator: (text) {
                                                  if (text!.isEmpty) {
                                                    return "This field is required";
                                                  }
                                                  return null;
                                                },
                                                controller: _lastName,
                                                cursorColor: black,
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                                decoration:
                                                    _tDes.defaultDecoration(
                                                  hintText:
                                                      "Enter your lastname",
                                                  labelText: "Lastname",
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  runAlignment: WrapAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 250,
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                            activeColor:
                                                                const Color
                                                                        .fromRGBO(
                                                                    34,
                                                                    73,
                                                                    87,
                                                                    1),
                                                            value: isRemember,
                                                            checkColor:
                                                                Colors.white,
                                                            side:
                                                                const BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      34,
                                                                      73,
                                                                      87,
                                                                      1),
                                                            ),
                                                            onChanged: (bo) =>
                                                                setState(() =>
                                                                    isRemember =
                                                                        !isRemember),
                                                          ),
                                                          const Text(
                                                            "Remember me",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      34,
                                                                      73,
                                                                      87,
                                                                      1),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              SizedBox(
                                                width: double.maxFinite,
                                                height: 60,
                                                child: MaterialButton(
                                                  onPressed: () async {
                                                    await register();
                                                  },
                                                  color: const Color.fromRGBO(
                                                      34, 73, 87, 1),
                                                  child: const Center(
                                                    child: Text(
                                                      "R E G I S T E R",
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
                                                height: 20,
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  width: double.maxFinite,
                                                  child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      text:
                                                          "Already have an account ? ",
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            34, 73, 87, 1),
                                                        fontSize: 17,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                          text: "Login",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    34,
                                                                    73,
                                                                    87,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
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
        ),
        _isLoading
            ? loader(
                color: Colors.blue.shade800,
              )
            : Container(),
      ],
    );
  }
}
