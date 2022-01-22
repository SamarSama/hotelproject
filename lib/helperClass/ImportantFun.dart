import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
class ImportantFun{
  late FirebaseApp app;
  late FirebaseDatabase database;
  late DatabaseReference base;
  void startRealTimeFirebase()async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
  }

}