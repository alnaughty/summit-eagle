import 'package:flutter/material.dart';

class HomeWebView extends StatefulWidget {
  const HomeWebView({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  @override
  State<HomeWebView> createState() => _HomeWebViewState();
}

class _HomeWebViewState extends State<HomeWebView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) => Scrollbar(
        controller: widget.scrollController,
        child: ListView(
          controller: widget.scrollController,
          children: [
            Container(
              width: double.maxFinite,
              height: 500,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
