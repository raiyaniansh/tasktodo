import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBase {
  static final FireBase fireBase = FireBase._fireBaseh();

  FireBase._fireBaseh();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> singup({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "success";
    }).catchError((e) {
      msg = "$e";
    });
    return msg;
  }

  Future<String?> Login({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "success";
    }).catchError((e) {
      msg = "$e";
    });
    return msg;
  }

  Future<void> SignOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<String> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    String msg = "";
    return await firebaseAuth
        .signInWithCredential(credential)
        .then((value) => msg = "success")
        .catchError((e) => msg = "$e");
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> AddTask(String? task, date,com) async {
    String uid = firebaseAuth.currentUser!.uid;
    String msg;
     return await db.collection('Task')
        .doc('$uid')
        .collection('todo')
        .add({"task": '$task', "date": '$date',"com":"$com"}).then((value) => msg="Success");
  }

  Future<String> UpdateTask(String? task, date,com,key) async {
    String uid = firebaseAuth.currentUser!.uid;
    String msg;
    print(uid);
    print(key);
     return await db.collection('Task')
        .doc('$uid')
        .collection('todo').doc('$key')
        .set({"task": '$task', "date": '$date',"com":"$com"}).then((value) => msg="Success");
  }

  Future<String> Delettask(key) async {
    String uid = firebaseAuth.currentUser!.uid;
    String msg;
    return await db.collection('Task')
        .doc('$uid')
        .collection('todo').doc('$key')
        .delete().then((value) => msg="Success");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readTask() {
    String uid = firebaseAuth.currentUser!.uid;
    return db.collection('Task')
        .doc('$uid')
        .collection('todo').snapshots();
  }

}
