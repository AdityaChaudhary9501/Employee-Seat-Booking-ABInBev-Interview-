import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppProvider with ChangeNotifier{

  final auth=FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AppProvider.initialize(){

  }


   Future<void>signInWithGoogle() async{
     final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
     final GoogleSignInAuthentication? googleSignInAuthentication = await googleuser?.authentication;
     final credential = GoogleAuthProvider.credential(

       accessToken: googleSignInAuthentication?.accessToken,
       idToken: googleSignInAuthentication?.idToken
     );


     return await auth.signInWithCredential(credential).then((value)=>{

       firestore.collection('users').doc(value.user!.uid).set({
         "id":value.user!.uid,
         "name":value.user!.displayName,
         "email":value.user!.email
       })

     });
   }

}