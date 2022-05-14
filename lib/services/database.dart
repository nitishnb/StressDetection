import 'package:stress_detection/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference accountCollection = FirebaseFirestore.instance.collection('userInfo');

  Future<void> updateUserData(String? name, String? emailid, String? profilePic) async {
    return await accountCollection.doc(uid).set({
      'name': name,
      'emailid': emailid,
      'profilePic': profilePic
    });
  }

  // userData from snapshot
  Info _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Info(
        uid: uid,
        name: snapshot.get('name'),
        emailid: snapshot.get('emailid'),
        profilePic: snapshot.get('profilePic'),
    );
  }

  // get user doc stream
  Stream<Info> get userData {
    return accountCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Future getAccountList(String id) async {
    DocumentSnapshot variable = await accountCollection.doc(id).get();
    return variable.get('cart');
  }

  Future<void> addtoCart(String id, List<dynamic> cart) async {
    return await accountCollection.doc(id).update({'cart': cart});
  }

}