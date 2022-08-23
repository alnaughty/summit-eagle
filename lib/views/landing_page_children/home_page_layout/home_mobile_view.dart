import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:summiteagle/extensions/string.dart';
import 'package:summiteagle/globals/animated_widget.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/models/news_model.dart';
import 'package:summiteagle/view_model/news_vm.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/clients_view.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/tax_info_view.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView> with AppConfig {
  final NewsVm _nvm = NewsVm.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) => Scrollbar(
        controller: widget.scrollController,
        child: ParallaxArea(
            scrollController: widget.scrollController,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              controller: widget.scrollController,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 600,
                  child: ParallaxWidget(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            "https://wallpaperaccess.com/full/1454022.jpg",
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(orange),
                                ),
                              );
                            },
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                AnimatedFadeWidget(
                                  child: Text(
                                    "Taxation of digital economy".toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                    ),
                                  ),
                                  slideFrom: const Offset(-1, 0),
                                  duration: const Duration(
                                    milliseconds: 600,
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  height: 10,
                                  color: orange,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const AnimatedFadeWidget(
                                  slideFrom: Offset(1, 0),
                                  duration: Duration(
                                    milliseconds: 600,
                                  ),
                                  child: Text(
                                    "Explore our interactive tool for a comparison of unilateral measures across the globe.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 300,
                              width: constraint.maxWidth,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white,
                                  Colors.transparent,
                                ],
                              ))),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<Stream<QuerySnapshot<NewsModel>>>(
                        stream: _nvm.stream,
                        builder: (_, snapshot) => !snapshot.hasData ||
                                snapshot.hasError
                            ? Container()
                            : StreamBuilder<QuerySnapshot<NewsModel>>(
                                stream: snapshot.data!,
                                builder: (_, query) => !query.hasData ||
                                        query.hasError
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SEAF News",
                                            style: TextStyle(
                                              color: black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ...query.data!.docs.map(
                                            (e) {
                                              final DateTime? date = e
                                                  .get("date")
                                                  .toString()
                                                  .convertedEpoch();
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: orange,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(e.get("title"),
                                                            style: TextStyle(
                                                              fontSize: 19,
                                                              height: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: orange,
                                                            )),
                                                        Text(e.get("data"),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: black,
                                                            )),
                                                        if (date != null) ...{
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    "Date posted : ",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text: DateFormat(
                                                                            "MMMM dd, yyyy")
                                                                        .format(
                                                                            date),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                        },
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                          // for(QueryDocumentSnapshot<NewsModel> in )...{},
                                        ],
                                      ),
                              ),
                      ),
                      ClientsView(
                        scrollController: widget.scrollController,
                      ),
                      TaxInfoView(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
