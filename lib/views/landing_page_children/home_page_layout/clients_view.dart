import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:summiteagle/globals/animated_widget.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/models/clients_model.dart';
import 'package:summiteagle/view_model/client_vm.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/client_file.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  static final ClientsVm _vm = ClientsVm.instance;

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> with AppConfig {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Stream<QuerySnapshot<ClientsModel>>>(
      stream: ClientsView._vm.stream,
      builder: (_, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Container();
        }
        return StreamBuilder<QuerySnapshot<ClientsModel>>(
            stream: snapshot.data,
            builder: (context, query) {
              if (query.hasError || !query.hasData) {
                return Container();
              }
              return LayoutBuilder(builder: (context, c) {
                final double width = c.maxWidth;
                return ParallaxArea(
                  scrollController: widget.scrollController,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Clients",
                                style: TextStyle(
                                  color: black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => setState(
                                () => showAll = !showAll,
                              ),
                              icon: const Icon(
                                Icons.view_agenda,
                              ),
                              label: Text("View ${showAll ? "less" : "all"}"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ...query.data!.docs
                                .sublist(0, showAll ? null : 3)
                                .map((e) {
                              final String? image = e.data().image;
                              final String name = e.data().name;
                              final List services = e.data().services;

                              return AnimatedFadeWidget(
                                slideFrom: const Offset(1, 0),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () async {
                                    if (e.data().files != null) {
                                      await showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(40),
                                          ),
                                        ),
                                        context: context,
                                        builder: (_) => ClientFileViewer(
                                          files: e.data().files!,
                                          docId: e.id,
                                        ),
                                      );
                                    } else {
                                      print("WARA FILE!");
                                    }
                                  },
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: width <= 800 ? width : width * .45,
                                    child: Row(
                                      children: [
                                        if (image != null) ...{
                                          ParallaxWidget(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset:
                                                        const Offset(-1, -1),
                                                    color:
                                                        black.withOpacity(.5),
                                                    blurRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Image.network(
                                                    image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        },
                                        Expanded(
                                          child: LayoutBuilder(
                                              builder: (context, l) {
                                            final double w = l.maxWidth;
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1,
                                                    color: black,
                                                  ),
                                                ),
                                                if (services.isNotEmpty) ...{
                                                  SizedBox(
                                                    height: 30,
                                                    width: w,
                                                    child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemBuilder: (_, index) =>
                                                          Text(
                                                        services[index],
                                                        style: TextStyle(
                                                            color: black
                                                                .withOpacity(
                                                          .5,
                                                        )),
                                                      ),
                                                      separatorBuilder:
                                                          (_, index) =>
                                                              const Text(", "),
                                                      itemCount:
                                                          services.length,
                                                    ),
                                                  ),
                                                },
                                              ],
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
            });
      },
    );
  }
}
