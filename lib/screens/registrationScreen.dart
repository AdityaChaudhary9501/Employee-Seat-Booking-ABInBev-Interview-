import 'package:ab_inbev/providers/appProvider.dart';
import 'package:ab_inbev/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Welcome to Ab Inbev'),
      ),

      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Text('Login to explore Ab InBev'),
            MaterialButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child:Text('Google Account Login'),
                onPressed:(){

                  appProvider.signInWithGoogle();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                })
          ],
        )
      ),
    );
  }
}
