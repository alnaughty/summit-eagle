import 'package:flutter/material.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/home_mobile_view.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/home_web_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) => Scaffold(
        // backgroundColor: Colors.grey.shade800,
        body: constraint.maxWidth > 900
            ? HomeWebView(
                scrollController: _scrollController,
              )
            : HomeMobileView(
                scrollController: _scrollController,
              ),
      ),
    );
  }
}
