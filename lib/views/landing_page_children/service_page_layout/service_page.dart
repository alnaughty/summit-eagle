import 'package:flutter/material.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:summiteagle/globals/animated_widget.dart';
import 'package:summiteagle/globals/app.dart';

class ServicePage extends StatelessWidget with AppConfig {
  late final ScrollController _scrollController;
  final List<String> _contents = [
    "ACCURATE RECORDING OF ALL FINANCIAL TRANSACTIONS",
    "TAX COMPLIANCE FOR BIR",
    "FINANCIAL STATEMENT PREPARATION",
    "PROVIDE INTERNAL CONTROL"
  ];

  ServicePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final double w = c.maxWidth;
        final bool isWeb = c.maxWidth > 900;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                "assets/images/image_2.png",
                fit: BoxFit.cover,
              )),
              Positioned.fill(
                  child: Center(
                      child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * .1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      " S E R V I C E S",
                      style: TextStyle(
                        color: Color.fromRGBO(34, 73, 87, 1),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BrunoAce",
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        return Text(
                          "${i + 1}. ${_contents[i]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(34, 73, 87, 1),
                              fontSize: 20),
                        );
                      },
                      separatorBuilder: (_, i) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: _contents.length,
                    )
                  ],
                ),
              )))
            ],
          ),
        );
      },
    );
  }
}
