import 'package:shared_preferences/shared_preferences.dart';
import 'package:summiteagle/models/saved_creds_model.dart';

class DataCacher {
  DataCacher._private();
  static final DataCacher _instance = DataCacher._private();
  static late final SharedPreferences sharedPreferences;
  static DataCacher get instance {
    return _instance;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<SavedCredsModel?> get credentials async {
    String? _email = sharedPreferences.getString("email");
    String? _password = sharedPreferences.getString("password");
    if (_email == null || _password == null) return null;
    return SavedCredsModel(
      email: _email,
      password: _password,
    );
  }

  Future<void> clearCredentials() async {
    sharedPreferences.remove('email');
    sharedPreferences.remove('password');
    return;
  }

  Future<void> saveCredentials(
      {required String email, required String password}) async {
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("password", password);
    return;
  }
}
