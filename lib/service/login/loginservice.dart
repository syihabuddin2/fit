import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance; 
  User? user;

  SharedPreferences? prefs;

  Future<User?> login({String? email,String? password,}) async {
    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
      
    user = userCredential.user;

    prefs!.setString("token", user!.uid.toString());

    return user;
  }

  Future<void> logout() async {
    prefs!.remove("token");
    FirebaseAuth.instance.signOut();
    return;
  }

  Future<User?> currentUser() async {
    final user = firebaseAuth.currentUser;
    return user;
  }

  Future<bool> hasToken() async {
    prefs = await SharedPreferences.getInstance();
    bool hasToken = prefs!.containsKey("token");
    return hasToken;
  }

  Future<bool> hasLogin() async {
    prefs = await SharedPreferences.getInstance();
    bool hasLogin = prefs!.containsKey("hasLogin");
    return hasLogin;
  }
}
