import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/globals/widget.dart';
import 'package:summiteagle/models/drawer_items.dart';
import 'package:summiteagle/services/data_cacher.dart';

class MobileView extends StatefulWidget {
  const MobileView(
      {Key? key,
      required this.drawerItems,
      required this.currentIndex,
      required this.opacity})
      : super(key: key);
  final List<CustomDrawerItems> drawerItems;
  final int currentIndex;
  final double opacity;
  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView>
    with SingleTickerProviderStateMixin, AppConfig {
  final DataCacher _dataCacher = DataCacher.instance;
  late final TabController _tabController;
  // double opacity = 0.0;
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
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: logo,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Text(
                            loggedUser!.displayName ?? "UNNAMED",
                            style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1,
                            ),
                          ),
                          Text(
                            loggedUser!.email!,
                            style: TextStyle(
                              color: black.withOpacity(.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) => SizedBox(
                        width: double.maxFinite,
                        child: MaterialButton(
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          onPressed: () {
                            // setState(
                            //   () => widget.currentIndex = widget.drawerItems.indexOf(e),
                            // );
                            Navigator.of(context).pop(null);
                            widget.drawerItems[index].onTap(index);
                            _tabController.animateTo(index);
                          },
                          color: widget.currentIndex == index
                              ? orange
                              : Colors.transparent,
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(
                              widget.drawerItems[index].icon,
                              color: widget.currentIndex == index
                                  ? Colors.white
                                  : black.withOpacity(.7),
                            ),
                            title: Text(
                              widget.drawerItems[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: widget.currentIndex == index
                                    ? Colors.white
                                    : black.withOpacity(.7),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: widget.drawerItems.length,
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: SizedBox(
                  width: double.maxFinite,
                  child: MaterialButton(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    elevation: 0,
                    onPressed: () async {
                      // Navigator.of(context).pop(null);

                      await _dataCacher.clearCredentials().whenComplete(
                            () => Navigator.pushReplacementNamed(
                                context, '/login_page'),
                          );

                      setState(() {
                        loggedUser = null;
                      });
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.red.shade400,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ...widget.drawerItems.map(
              //   (e) => ,
              // )
            ],
          ),
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...widget.drawerItems.map(
            (e) => e.child,
          ),
        ],
        controller: _tabController,
      ),
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.red,
        title: SizedBox(
          height: 50,
          child: logo,
        ),
        // title: Text(
        //   "Summit Eagle \nAccounting and Finance",
        //   maxLines: 2,
        //   style: TextStyle(
        //     fontSize: 15,
        //     color: black,
        //     height: 1,
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
      ),
    );
  }
}
