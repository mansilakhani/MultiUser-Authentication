import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();
  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference usersRef;
  late CollectionReference countersRef;

  /// TODO :  connectedwithConnection

  void connectWithStudentsCollection() {
    usersRef = firebaseFirestore.collection('users'); //// firebase name
  }

  void connectWithCountersCollection() {
    countersRef = firebaseFirestore.collection('counters');
  }

  /// TODO : insertRecord
  Future<void> insertRecord({required Map<String, dynamic> data}) async {
    connectWithStudentsCollection();
    connectWithCountersCollection();

    // Map<String, dynamic> data = {
    //   'name': 'Natasha',
    //   'age': 22,
    //   'city': 'Vadadora',
    // };

    //// TODO : fetch counter value from students counter collection

    DocumentSnapshot documentSnapshot =
        await countersRef.doc('user_counter').get(); //// firebase name

    Map<String, dynamic> counterdata =
        documentSnapshot.data() as Map<String, dynamic>;

    int counter = counterdata['counter'];

    //// TODO : insert a new documnet with that fetched counter value

    await usersRef.doc('${++counter}').set(data);

    //// TODO : Update that counter value in DB

    await countersRef
        .doc('student_counter')
        .update({'counter': counter}); //// firebase name

    /// * 1) first method : add
    // DocumentReference res = await studentsRef.add(data);
    //
    // print("===================================");
    // print(res.path);
    // print("===================================");
    // print(res.id);
    // print("===================================");

    /// * 2) Second method : add

    //await studentsRef.doc('4').set(data);
  }

  /// TODO : selectRecord

  Stream<QuerySnapshot> selectRecords() {
    connectWithStudentsCollection();
    return usersRef.snapshots();
  }

  /// TODO : updateRecord

  Future<void> updateRecord({required String id}) async {
    connectWithStudentsCollection();

    Map<String, dynamic> updatedData = {
      'name': 'hello',
    };
    await usersRef.doc(id).update(updatedData);
  }

  /// TODO : deleteRecord

  Future<void> deleteRecord({required String id}) async {
    connectWithStudentsCollection();

    await usersRef.doc(id).delete();

    DocumentSnapshot documentSnapshot =
        await countersRef.doc('student_counter').get(); //// firebase name

    Map<String, dynamic> counterData =
        documentSnapshot.data() as Map<String, dynamic>;

    int counter = counterData['counter'];

    await countersRef
        .doc('student_counter')
        .set({'counter': counter--}); //// firebase name
  }
}
