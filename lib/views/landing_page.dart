import 'package:flutter/material.dart';
import 'package:summiteagle/models/drawer_items.dart';
import 'package:summiteagle/views/landing_page_children/home_page.dart';
import 'package:summiteagle/views/landing_page_layout/mobile_view.dart';
import 'package:summiteagle/views/landing_page_layout/tablet_view.dart';
import 'package:summiteagle/views/landing_page_layout/web_view.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);
  // static

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  late final List<CustomDrawerItems> drawerItems = [
    CustomDrawerItems(
      onTap: (int i) {
        setState(() {
          currentIndex = i;
        });
      },
      icon: Icons.home_filled,
      child: const HomePage(),
      title: "Home",
    ),
    CustomDrawerItems(
      onTap: (int i) {
        setState(() {
          currentIndex = i;
        });
      },
      icon: Icons.account_balance_outlined,
      child: Container(
        color: Colors.green,
      ),
      title: "About us",
    ),
    CustomDrawerItems(
      onTap: (int i) {
        setState(() {
          currentIndex = i;
        });
      },
      icon: Icons.home_repair_service,
      child: Container(
        color: Colors.blue,
      ),
      title: "Services",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constrant) => constrant.maxWidth <= 550
            ? MobileView(
                drawerItems: drawerItems,
                currentIndex: currentIndex,
              )
            : constrant.maxWidth > 900
                ? WebView(
                    drawerItems: drawerItems,
                    currentIndex: currentIndex,
                  )
                : TabletView(
                    drawerItems: drawerItems,
                    currentIndex: currentIndex,
                  ),
      ),
    );
  }
}
