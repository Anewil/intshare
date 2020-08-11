import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepository({FirebaseAuth firebaseAuth, Firestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  Future<void> signInWithEmail(String email, String password) {
    this._firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> isFirstTime(String userId) async {
    return await this
        ._firestore
        .collection('users')
        .document(userId)
        .get()
        .then((user) {
      return user.exists;
    });
  }

  Future<void> signUpWithEmail(String email, String password) async {
    return await this
        ._firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    return await this._firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = this._firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await this._firebaseAuth.currentUser()).uid;
  }
}
