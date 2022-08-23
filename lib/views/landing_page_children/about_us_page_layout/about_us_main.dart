import 'package:flutter/material.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:summiteagle/globals/animated_widget.dart';
import 'package:summiteagle/globals/app.dart';

class AboutUsMainPage extends StatelessWidget with AppConfig {
  AboutUsMainPage({Key? key, required this.isWeb}) : super(key: key);
  final bool isWeb;
  static final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final double w = c.maxWidth;
        return ParallaxArea(
          scrollController: _scrollController,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            controller: _scrollController,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: isWeb ? 800 : 600,
                child: ParallaxWidget(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/about_us.webp",
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              AnimatedFadeWidget(
                                child: Text(
                                  "Get to know us".toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                                slideFrom: const Offset(-1, 0),
                                duration: const Duration(
                                  milliseconds: 600,
                                ),
                              ),
                              Container(
                                width: 250,
                                height: 10,
                                color: orange,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const AnimatedFadeWidget(
                                slideFrom: Offset(1, 0),
                                duration: Duration(
                                  milliseconds: 600,
                                ),
                                child: Text(
                                  "Bringing precision, consistency, and punctuality to your tax and accounting needs.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: 300,
                            width: w,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white,
                                Colors.transparent,
                              ],
                            ))),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: black,
                padding: const EdgeInsets.all(30),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  runAlignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: w <= 800 ? w : 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const AnimatedFadeWidget(
                              slideFrom: Offset(-1, 0),
                              child: Text(
                                "Edmund Y. Legitimas",
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              "Chief Executive Officer / President",
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedFadeWidget(
                                slideFrom: const Offset(-1, 0),
                                child: Text(
                                  "\"Come at once if convenient-if inconvenient come all the same.\"",
                                  style: TextStyle(
                                    fontSize: 25,
                                    height: 1,
                                    color: Colors.white.withOpacity(.7),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AnimatedFadeWidget(
                                slideFrom: const Offset(1, 0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "- Sherlock Holmes",
                                    style: TextStyle(
                                      color: orange,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                // color: black,
                padding: const EdgeInsets.all(30),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w <= 800 ? w : 550,
                      height: 600,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: w <= 800 ? w : 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: AnimatedFadeWidget(
                              slideFrom: const Offset(-1, 0),
                              child: Text(
                                "Maroo Rebadula-Legitimas",
                                style: TextStyle(
                                  color: black.withOpacity(.8),
                                  height: 1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              "Chief Operating Officer / Vice President",
                              style: TextStyle(
                                color: orange,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedFadeWidget(
                                slideFrom: const Offset(-1, 0),
                                child: Text(
                                  "\"Always bear in mind that your own resolution to succeed is more important than any other\"",
                                  style: TextStyle(
                                    fontSize: 25,
                                    height: 1,
                                    color: black.withOpacity(.7),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AnimatedFadeWidget(
                                slideFrom: const Offset(1, 0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "- Abraham Lincoln",
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
