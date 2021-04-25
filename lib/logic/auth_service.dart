import 'package:trueaddresser/imports.dart';

String errortext;

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _userRef = FirebaseFirestore.instance.collection("users");
  UserModel _userModel = UserModel();

  Stream<String> get onAuthStateChanged => _auth.authStateChanges().map(
        (User user) => user?.uid,
      );

  // GET UID
  String getCurrentUID() {
    return _auth.currentUser.uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<User> signupEmail({
    String email,
    String password,
    BuildContext context,
    scaffoldKey,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          errortext = "Email Already Exists";
          break;
        case 'invaild-email':
          errortext = "Invalid Email Address";
          break;
        case 'weak-password':
          errortext = "Please Choose a stronger password";
          break;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(errortext),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 1000),
        ));
      });
    }
    return Future.value(null);
  }

  Future<User> signinEmail(
      String email, String password, BuildContext context, _scaffoldKey) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'user-not-found':
          errortext = 'Entered email not exists please check your email';
          break;
        case 'wrong-password':
          errortext = 'Wrong password Please Enter Correct Password';
          break;
        case 'unknown':
          errortext = 'Pelase check your internet';
          break;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(errortext),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 1000),
        ));
      });
    }
    return Future.value(null);
  }

  Future<void> phoneSignup(
      {String phoneNumber,
      PhoneCodeSent codeSent,
      PhoneVerificationFailed verificationFailed}) async {
    if (phoneNumber.isNotEmpty) {
      if (!phoneNumber.contains("+")) phoneNumber = '+91' + phoneNumber;
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: verificationFailed,
          timeout: Duration(seconds: 60),
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (code) {});
    } else {}
  }

  Future<User> verifyOTP(
      String verificationId, String otp, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);

    UserCredential result;
    try {
      result = await _auth.signInWithCredential(credential);
      User user = result.user;
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          errortext = "Invalid Verification code";
          break;
      }
    }

    return Future.value(null);
  }

  Future<void> phoneSignIn(
      {String phoneNumber,
      PhoneCodeSent codeSent,
      verificationComplete,
      PhoneVerificationFailed verificationFailed,
      BuildContext context,
      GlobalKey<ScaffoldMessengerState> scaffoldMessenger}) async {
    var isValidUser = false;

    await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then((result) => {
              if (result.docs.length > 0) {isValidUser = true}
            });
    if (phoneNumber.isNotEmpty) {
      if (isValidUser) {
        if (!phoneNumber.contains("+")) phoneNumber = '+91' + phoneNumber;
        await _auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: verificationComplete,
            verificationFailed: verificationFailed,
            timeout: Duration(seconds: 60),
            codeSent: codeSent,
            codeAutoRetrievalTimeout: (code) {});
      } else {
        errortext = "Number not found, please sign up first";
        scaffoldMessenger.currentState.showSnackBar(errorSnakBar(errortext));
      }
    } else {
      //return errortext = "phone number is empty";
    }
  }
  // Future<void> addUsertoDB(
  //     {String uid, String username, String email, DateTime timestamp}) async {
  //   userModel = UserModel(
  //       uid: uid, username: username, email: email, timestamp: timestamp);

  //   await userRef.doc(uid).set(userModel.toMap(userModel));
  // }

  // Future<bool> usernameCheck(String _username) async {
  //   final result = await userRef.where("username", isEqualTo: _username).get();
  //   return result.docs.isEmpty;
  // }

  Future<UserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await _userRef.doc(uid).get();
    return UserModel.fromMap(doc.data());
  }

  Future<void> updateUserData(
      {String uid,
      String username,
      String phoneNumber,
      DateTime timestamp,
      String address,
      int likes,
      String isAccountPrivate}) async {
    _userModel = UserModel(
      uid: uid,
      username: username,
      phoneNumber: phoneNumber,
      timestamp: timestamp,
      address: address,
      likes: likes,
      isAcoountPrivate: isAccountPrivate,
    );

    try {
      await _userRef.doc(uid).update(_userModel.toMap(_userModel));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> addUserLikes({String uid, int value}) async {
    return await _userRef
        .doc(uid)
        .update({'likes': FieldValue.increment(value)});
  }

  Future<bool> signOutUser() async {
    await _auth.signOut();
    return Future.value(true);
  }
}
