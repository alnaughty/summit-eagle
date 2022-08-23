extension FirebaseTime on String {
  int getFirebaseTimestamp([bool inSec = true]) {
    try {
      String data = this;
      List<String> datt = data
          .replaceAll("Timestamp", "")
          .replaceAll("(", "")
          .replaceAll(")", "")
          .split(",");
      int result = 0;
      if (inSec) {
        List<String> fields = datt[0].split("=");
        result = int.parse(fields[1]);
      } else {
        List<String> fields = datt[1].split("=");
        result = int.parse(fields[1]);
      }
      return result;
    } catch (e) {
      return 0;
    }
  }

  DateTime? convertedEpoch() {
    try {
      final int parsed = int.parse(this);
      return DateTime.fromMillisecondsSinceEpoch(parsed * 1000);
    } catch (e) {
      return null;
    }
  }
}
