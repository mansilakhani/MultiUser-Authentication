import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  /// TODO:signInAnonymously
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          print("=============================");
          print("This operation is restricted to administrators only");
          print("=============================");
          break;

        case "operation-not-allowed":
          print("=============================");
          print("Operation not allowed");
          print("=============================");
          break;
      }
    }
  }

  /// TODO: signUpUser
  Future<User?> signUpUser(
      {required String email, required String password}) async {
    try {
      UserCredential usercredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = usercredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          print("==============================");
          print("Password at least 6 char long.");
          print("==============================");
          break;

        case "email-already-in-use":
          print("===========================");
          print("This user is already exists");
          print("===========================");
          break;
      }
    }
  }

  /// TODO: signInUser
  Future<User?> signInUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          print("================================");
          print("Wrong Password");
          print("================================");
          break;

        case 'user-not-found':
          print("================================");
          print("This user is not created yet.");
          print("================================");
          break;
      }
    }
  }

  /// TODO: signInwithGoogle

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;
    return user;
  }

  /// TODO:signOut
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();

    //Globals.user = null;
  }

  // /// TODO:signInwithfacebook
  // Future<User?> signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  //   User? user = userCredential.user;
  //   return user;
  // }
}
