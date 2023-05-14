import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/globals/widget.dart';
import 'package:summiteagle/models/drawer_items.dart';
import 'package:summiteagle/services/data_cacher.dart';

class WebView extends StatefulWidget {
  const WebView(
      {Key? key, required this.currentIndex, required this.drawerItems})
      : super(key: key);
  final List<CustomDrawerItems> drawerItems;
  final int currentIndex;
  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView>
    with SingleTickerProviderStateMixin, AppConfig {
  final DataCacher _dataCacher = DataCacher.instance;

  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: widget.drawerItems.length,
      initialIndex: widget.currentIndex,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            AppBar(
              actions: [
                PopupMenuButton(
                  onSelected: (v) async {
                    if (v == "/logout") {
                      setState(() {
                        loggedUser = null;
                      });
                      await _dataCacher.clearCredentials().whenComplete(
                            () => Navigator.pushReplacementNamed(
                              context,
                              '/login_page',
                              result: {},
                            ),
                          );
                    } else {}
                  },
                  tooltip: "Account",
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey.shade900,
                  offset: const Offset(0, 40),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: loggedUser!.photoURL == null
                          ? Padding(
                              padding: const EdgeInsets.all(3),
                              child: FittedBox(
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            )
                          : Image.network(loggedUser!.photoURL!),
                    ),
                  ),
                  itemBuilder: (_) => [
                    // PopupMenuItem(
                    //  value: "/show_details",
                    // child: Row(
                    //  children: [
                    //   Icon(
                    //    Icons.account_box_rounded,
                    //   color: Colors.grey.shade200,
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    //  ),
                    //  Expanded(
                    //   child: Text(
                    //  "Details",
                    //  style: TextStyle(
                    //   fontWeight: FontWeight.w500,
                    //    color: Colors.grey.shade200,
                    //   fontSize: 12,
                    // ),
                    //  ),
                    //)
                    // ],
                    // ),
                    // ),
                    PopupMenuItem(
                      value: "/logout",
                      child: Row(
                        children: const [
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
              title: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 70,
                        child: logoSmall(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: TabBar(
                      onTap: (index) {
                        widget.drawerItems[index].onTap(index);
                      },
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      labelStyle: TextStyle(
                        color: orange,
                      ),
                      indicatorColor: orange,
                      unselectedLabelStyle:
                          TextStyle(color: black.withOpacity(.7)),
                      tabs: [
                        ...widget.drawerItems.map(
                          (e) => Tab(
                            text: e.title,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...widget.drawerItems.map((e) => e.child),
                ],
                controller: _tabController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
