import 'package:flutter/material.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView> {
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
              height: 600,
              color: Colors.red,
            ),
            for (int x = 0; x < 50; x++) ...{
              Card(
                child: Text(x.toString()),
              )
            }
          ],
        ),
      ),
    );
  }
}
