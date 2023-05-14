import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:summiteagle/extensions/string.dart';
import 'package:summiteagle/globals/animated_widget.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/models/news_model.dart';
import 'package:summiteagle/view_model/news_vm.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/clients_view.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/tax_info_view.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView> with AppConfig {
  final NewsVm _nvm = NewsVm.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) => Scrollbar(
        controller: widget.scrollController,
        child: ParallaxArea(
            scrollController: widget.scrollController,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              controller: widget.scrollController,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 1000,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Image.asset(
                        "assets/images/image_3.png",
                        fit: BoxFit.cover,
                      )),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 250),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'S E A F',
                                      style: TextStyle(
                                        fontSize: 60,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 3
                                          ..color = Colors.white,
                                        fontFamily: "BrunoAce",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'S E A F',
                                      style: TextStyle(
                                        fontSize: 60,
                                        color: Color.fromRGBO(34, 73, 87, 1),
                                        fontFamily: "BrunoAce",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.7),
                                      fontFamily: "Montserrat",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'S',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(34, 73, 87, 1),
                                            fontFamily: "BrunoAce",
                                            fontSize: 25),
                                      ),
                                      TextSpan(text: 'ummit '),
                                      TextSpan(
                                        text: 'E',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(34, 73, 87, 1),
                                            fontFamily: "BrunoAce",
                                            fontSize: 25),
                                      ),
                                      TextSpan(text: 'agle '),
                                      TextSpan(
                                        text: 'A',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(34, 73, 87, 1),
                                            fontFamily: "BrunoAce",
                                            fontSize: 25),
                                      ),
                                      TextSpan(text: 'ccounting & '),
                                      TextSpan(
                                        text: 'F',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(34, 73, 87, 1),
                                            fontFamily: "BrunoAce",
                                            fontSize: 25),
                                      ),
                                      TextSpan(text: 'inance'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
