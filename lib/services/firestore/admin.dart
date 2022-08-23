import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summiteagle/globals/access.dart';

class Admin {
  final FirebaseFirestore fstore = FirebaseFirestore.instance;
  Future<void> isAdmin() async {
    try {
      final DocumentReference ff =
          fstore.collection("user-details").doc(loggedUser!.uid);
      bool res = false;
      await ff.get().then((value) {
        res = value.exists;
      });

      isUserAdmin = res;
      print("FFFF : $res");
      return;
    } catch (e) {
      isUserAdmin = false;
      return;
    }
  }
}
