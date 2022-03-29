import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
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

class _WebViewState extends State<WebView> with SingleTickerProviderStateMixin {
  final DataCacher _dataCacher = DataCacher.instance;
  final Widget title = Row(
    children: [
      Hero(
        tag: "logo",
        child: Container(
          height: 50,
          width: 50,
          color: Colors.red,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Text(
          "Summit Eagle \nAccounting and Finance",
          maxLines: 2,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(.8),
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    ],
  );
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
      backgroundColor: Colors.grey.shade900,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.grey.shade900,
              actions: [
                // PopupMenuButton<int>(
                //   tooltip: "Afficher les options de paramètres",
                //   padding: const EdgeInsets.all(0),
                //   offset: const Offset(0, 45),
                // onSelected: (int value) async {
                //   // callback(value);
                // },
                //   icon: SizedBox(
                //     width: 40,
                //     height: 40,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(60),
                //       child: loggedUser!.photoURL == null
                //           ? Icon(
                //               Icons.account_circle_outlined,
                //               color: Colors.grey.shade200,
                //             )
                //           : Image.network(loggedUser!.photoURL!),
                //     ),
                //   ),
                //   itemBuilder: (_) => <PopupMenuItem<int>>[
                //     PopupMenuItem(
                //       value: 0,
                //       child: Row(
                //         children: const [
                //           Icon(Icons.person),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Text("Details")
                //         ],
                //       ),
                //     ),
                //     PopupMenuItem(
                //       value: 2,
                //       child: Row(
                //         children: const [
                //           Icon(
                //             Icons.exit_to_app,
                //             color: Colors.red,
                //           ),
                // SizedBox(
                //   width: 10,
                // ),
                //           Text(
                //             "Déconnecter",
                //             style: TextStyle(color: Colors.red),
                //           )
                //         ],
                //       ),
                //     )
                //   ],
                // ),
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
                    } else {
                      /// show account details
                    }
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
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            )
                          : Image.network(loggedUser!.photoURL!),
                    ),
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: "/show_details",
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_box_rounded,
                            color: Colors.grey.shade200,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Details",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade200,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "/logout",
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.red.shade400,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade400,
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
                    child: title,
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
                        color: Colors.blue.shade800,
                      ),
                      indicatorColor: Colors.blue.shade800,
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.white),
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
            // Container(
            //   width: size.width,
            //   height: 60,
            //   child: Row(
            //     children: [
            //       title,
            //       // const Spacer(),
            //       // Expanded(
            // child: TabBar(
            //   controller: _tabController,
            //   physics: const NeverScrollableScrollPhysics(),
            //   labelStyle: TextStyle(
            //     color: Colors.blue.shade800,
            //   ),
            //   indicatorColor: Colors.blue.shade800,
            //   unselectedLabelStyle: const TextStyle(color: Colors.white),
            //   tabs: [
            //     ...widget.drawerItems.map(
            //       (e) => Tab(
            //         text: e.title,
            //       ),
            //     )
            //   ],
            // ),
            //       // )
            //     ],
            //   ),
            // ),
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
