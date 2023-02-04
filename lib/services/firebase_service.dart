import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import '../models/user.dart' as u;

const userCollection = 'users';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection(userCollection);

  FirebaseService();

  Map? currentUser;


  // Stream<List<u.User>> readUsers() => _users.snapshots().map((snapshot) =>
  //     snapshot.docs.map((doc) => u.User.fromJson(doc.data())).toList());

  CollectionReference getUsers() {
    return _users;
  }

  FirebaseStorage getStorage() {
    return _storage;
  }

  FirebaseAuth getAuth() {
    return _auth;
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  

  Future<bool> registerUser(u.User user) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: user.email.toString(), password: user.password.toString());
      String _userId = _userCredential.user!.uid;
      await _db.collection(userCollection).doc(_userId).set({
        'fullname': user.fullname,
        'username': user.username,
        'email': user.email,
        'birthday' : null,
        'phone' : null,
        'imageUrl' : null
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      // u.User? currentUser;

      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        currentUser = await getUserData(_userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map?> getUserData(String uid) async {
    DocumentSnapshot _doc = await _db.collection(userCollection).doc(uid).get();
    return _doc.data() as Map;
  }

    Future updateUser(u.User updateUser, String uid) async {

    await getUsers().doc(uid).update({
      
      'fullname' : updateUser.fullname,
      'phone' : updateUser.phone,
      'birthday' : updateUser.birth,
      'imageUrl' : updateUser.imageUrl
    });

  }

}
