import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:your_ride/globle/globle.dart';
import 'package:your_ride/models/user_model.dart';

class AssistantMethod{
  static void readCurrenOnlinUserInfo()async{
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef =   FirebaseDatabase.instance.ref().child('user').child(currentUser!.uid);
    userRef.once().then((snap) {
       if(snap.snapshot.value!=null){
         userModelCurrentinfo = UserModel.fromSnapshot(snap.snapshot);
            
       }
    });
  }
}