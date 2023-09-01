import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../Services/auth.dart';
import '../componet/lodingcomponet.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String notificationTitle = "NO Title";
  String notificationBody = "NO Body";
  String notificationData = "NO Data";

  bool isLogoutLoading = false;

  @override
  void initState() {

    final firebaseMessaging = FCM();
     firebaseMessaging.setNotification();

     firebaseMessaging.streamCtlr.stream.listen((e)=>setState(()=>notificationData = e));
     firebaseMessaging.bodyCtlr.stream.listen((e) => setState((){

       notificationBody = e;
       showSimpleNotification(
         Text(notificationTitle),
        subtitle:Text(notificationData),
       background: Colors.cyan.shade700,
         duration: Duration(seconds: 10)
       );
     }) );
     firebaseMessaging.titleCtlr.stream.listen((e)=>setState(()=>notificationTitle = e ));

     // PushNotification

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: () async {
        for(int i=0;i<100;i++)
          {
            await Future.delayed(Duration(seconds: 5));

            showSimpleNotification(
              Text("Notification"),
              subtitle: Text("Please drink watet well"),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 1),
              position: NotificationPosition.top,
              elevation: 0.0,
              slideDismissDirection: DismissDirection.startToEnd,
            );
          }
      },

      ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade400,
        title: Text("Thread"),
      actions: [
        IconButton(onPressed: ()async{
          setState(()=> isLogoutLoading =true);
        //   await AuthProvider().logout();
           await AuthProvider().signOut();
          setState(()=> isLogoutLoading =false);
        }, icon: isLogoutLoading ? LoadingComponet() : Icon(Icons.logout,size: 22,))
      ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title : $notificationTitle "),
            Text("Title : $notificationBody"),
            Text("Title : $notificationData"),
          ],
        ),
      ),
    );
  }
}

class FCM {

  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotification(){
    FirebaseMessaging.onMessage.listen((message) {
      if(message.data.containsKey("data"))
        {
          streamCtlr.sink.add(message.data['data']);
        }
      if(message.data.containsKey('notification'))
        {
          streamCtlr.sink.add(message.data['notification']);
        }
      titleCtlr.sink.add(message.notification!.title!);
      titleCtlr.sink.add(message.notification!.body!);
    });

    // With this token you can test it easily on your phone
    final token = _firebaseMessaging.getToken().then((value) => print("Token : $value"));
  }

  static Future<void> onBackgroundMessage(RemoteMessage message)async{
    await Firebase.initializeApp();

    // handle
   if(message.data.containsKey("notification"))
     {
       final notification = message.data['notification'];
       debugPrint('notification => $notification');
     }
   if(message.data.containsKey('data'))
     {
       final data = message.data['data'];
       debugPrint('data => $data');
     }
  }

}