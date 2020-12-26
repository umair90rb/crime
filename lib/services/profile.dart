import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  FirebaseFirestore db = FirebaseFirestore.instance;


//create profile
  Future createProfile(String id){

    DocumentReference docRef = db.collection('profile').doc(id);
    docRef.set({

    });

  }

}

