import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/models/client_file_model.dart';
import 'package:summiteagle/views/landing_page_children/home_page_layout/network_file_viewer.dart';

class ClientFileViewer extends StatelessWidget with AppConfig {
  ClientFileViewer({Key? key, required this.files, required this.docId})
      : super(key: key);
  final List<ClientFile> files;
  final String docId;
  late final DocumentReference clientDocument =
      FirebaseFirestore.instance.collection('clients').doc(docId);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Center(
                child: Container(
                  width: 100,
                  height: 8,
                  decoration: BoxDecoration(
                    color: black.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Files available",
              style: TextStyle(
                color: black,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (_, index) => ListTile(
                  onTap: () async {
                    await showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: NetworkFileViewer(
                                  url: files[index].networkFile,
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 200),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) =>
                            Container());
                  },
                  title: Text(
                    files[index].name,
                  ),
                  leading: Icon(
                    Icons.file_open,
                    color: orange,
                  ),
                  subtitle: Text(
                    DateFormat()
                        .add_MMMMEEEEd()
                        .add_jms()
                        .format(files[index].date.toDate()),
                  ),
                ),
                separatorBuilder: (_, index) => Divider(
                  color: black.withOpacity(.5),
                ),
                itemCount: files.length,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: MaterialButton(
                onPressed: () async {
                  List list = files.map((e) => e.toJson()).toList();
                  print(list);
                  list.add({
                    "name": "test file",
                    "file": "Test Fileeeee",
                    "date": Timestamp.now(),
                  });
                  await clientDocument.update({
                    'files': list,
                  });
                },
                height: 55,
                child: Text(
                  "Upload new file",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: orange,
              ),
            )
          ],
        ),
      ),
    );
  }
}
