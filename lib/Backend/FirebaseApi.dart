import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload: ${message.data}');
}
class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    saveFCMToken(fCMToken!);
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
  String getCurrentUserId(){
    User? user = FirebaseAuth.instance.currentUser;
    if( user != null){
      return user.uid;
    }
    else{
      return '';
    }
  }

  Future<void> saveFCMToken(String fcmToken) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try{
      String userId = getCurrentUserId();
      DocumentReference useref = firestore.collection('tokens').doc(userId);
      await useref.set({'token':fcmToken});
      print('FCM token saved to firestore: $fcmToken');
    } catch (e){
      print('Error saving token: $e');
    }
  }
}