import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/globals/widget.dart';
import 'package:summiteagle/models/drawer_items.dart';
import 'package:summiteagle/services/data_cacher.dart';

// ignore: must_be_immutable
class TabletView extends StatefulWidget {
  const TabletView(
      {Key? key, required this.drawerItems, required this.currentIndex})
      : super(key: key);
  final List<CustomDrawerItems> drawerItems;
  final int currentIndex;
  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView>
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

  // int curr
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          height: 50,
          child: logo,
        ),
        // backgroundColor: Colors.grey.shade900,
      ),
      // backgroundColor: Colors.grey.shade800,
      body: Row(
        children: [
          Container(
              height: double.maxFinite,
              width: 70,
              // color: Colors.grey.shade100,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) => SizedBox(
                        height: 65,
                        width: double.maxFinite,
                        child: Tooltip(
                          message: widget.drawerItems[index].title,
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade300,
                          ),
                          child: MaterialButton(
                            elevation: 0,
                            color: widget.currentIndex == index
                                ? orange
                                : Colors.transparent,
                            onPressed: () {
                              widget.drawerItems[index].onTap(index);
                              _tabController.animateTo(index);
                            },
                            child: Icon(widget.drawerItems[index].icon,
                                color: widget.currentIndex == index
                                    ? Colors.white
                                    : black.withOpacity(.7)),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: widget.drawerItems.length,
                    ),
                  ),
                  SafeArea(
                    child: MaterialButton(
                      height: 65,
                      elevation: 0,
                      color: Colors.transparent,
                      onPressed: () async {
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
                      },
                      child: Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...widget.drawerItems.map(
                  (e) => e.child,
                )
              ],
              controller: _tabController,
            ),
            // child: widget.drawerItems[widget.currentIndex].child,
          )
        ],
      ),
    );
  }
}
