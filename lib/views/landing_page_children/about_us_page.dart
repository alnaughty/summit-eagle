import 'package:flutter/material.dart';
import 'package:summiteagle/views/landing_page_children/about_us_page_layout/about_us_main.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);
  static final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) => Scaffold(
        body: AboutUsMainPage(
          isWeb: constraint.maxWidth > 900,
        ),
      ),
    );
  }
}
