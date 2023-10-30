import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_ride/models/user_model.dart';

final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentinfo;
String? userDropOffAddress;