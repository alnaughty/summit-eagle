import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/models/drawer_items.dart';
import 'package:summiteagle/services/data_cacher.dart';

class MobileView extends StatefulWidget {
  const MobileView(
      {Key? key, required this.drawerItems, required this.currentIndex})
      : super(key: key);
  final List<CustomDrawerItems> drawerItems;
  final int currentIndex;
  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView>
    with SingleTickerProviderStateMixin {
  final DataCacher _dataCacher = DataCacher.instance;
  late final TabController _tabController;
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
      backgroundColor: Colors.grey.shade800,
      drawer: Drawer(
        backgroundColor: Colors.grey.shade900,
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: loggedUser!.photoURL == null
                                ? FittedBox(
                                    child: Icon(
                                      Icons.account_circle_outlined,
                                      color: Colors.grey.shade200,
                                    ),
                                  )
                                : Image.network(loggedUser!.photoURL!),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          loggedUser!.displayName ?? "UNNAMED",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1,
                          ),
                        ),
                        Text(
                          loggedUser!.email!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(.5),
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
                          widget.drawerItems[index].onTap(index);
                          _tabController.animateTo(index);
                        },
                        color: widget.currentIndex == index
                            ? Colors.blue.shade800
                            : Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          leading: Icon(
                            widget.drawerItems[index].icon,
                            color: Colors.white,
                          ),
                          title: Text(
                            widget.drawerItems[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade200,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 10,
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
      body: TabBarView(
        children: [
          ...widget.drawerItems.map(
            (e) => e.child,
          ),
        ],
        controller: _tabController,
      ),
      appBar: AppBar(
        title: title,
        backgroundColor: Colors.grey.shade900,
      ),
    );
  }
}
