import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/models/clients_model.dart';
import 'package:summiteagle/models/drawer_items.dart';
import 'package:summiteagle/models/news_model.dart';
import 'package:summiteagle/view_model/client_vm.dart';
import 'package:summiteagle/view_model/news_vm.dart';
import 'package:summiteagle/views/landing_page_children/about_us_page.dart';
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
  double _opacity = 0.0;
  final ScrollController _scrollController = ScrollController();
  late final List<CustomDrawerItems> drawerItems = [
    CustomDrawerItems(
      onTap: (int i) {
        setState(() {
          currentIndex = i;
        });
      },
      appbarOpacity: (double opacity) {
        setState(() {
          _opacity = opacity;
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
      appbarOpacity: (double opacity) {
        setState(() {
          _opacity = opacity;
        });
      },
      icon: Icons.account_balance_sharp,
      child: const AboutUsPage(),
      title: "About us",
    ),
    CustomDrawerItems(
      onTap: (int i) {
        setState(() {
          currentIndex = i;
        });
      },
      appbarOpacity: (double opacity) {
        setState(() {
          _opacity = opacity;
        });
      },
      icon: Icons.home_repair_service,
      child: Container(
        color: Colors.blue,
      ),
      title: "Services",
    ),
    if (isUserAdmin) ...{
      CustomDrawerItems(
        onTap: (int i) {
          setState(() {
            currentIndex = i;
          });
        },
        appbarOpacity: (double opacity) {
          setState(() {
            _opacity = opacity;
          });
        },
        icon: Icons.settings_sharp,
        child: Container(
          color: Colors.blue,
        ),
        title: "Back office",
      ),
    },
  ];
  final FirebaseFirestore fstore = FirebaseFirestore.instance;
  final NewsVm _nvm = NewsVm.instance;
  final ClientsVm _cvm = ClientsVm.instance;

  @override
  void initState() {
    // isAdmin();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _nvm.set(
        fstore
            .collection("news")
            .withConverter(
              fromFirestore: (snapshots, _) =>
                  NewsModel.fromJson(snapshots.data()!),
              toFirestore: (NewsModel news, _) => news.toJson(),
            )
            .snapshots(),
      );

      _cvm.set(fstore
          .collection("clients")
          .withConverter(
              fromFirestore: (snapshots, _) =>
                  ClientsModel.fromJson(snapshots.data()!),
              toFirestore: (ClientsModel clients, _) => clients.toJson())
          .snapshots());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constrant) => constrant.maxWidth <= 550
            ? MobileView(
                drawerItems: drawerItems,
                currentIndex: currentIndex,
                opacity: _opacity,
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
