import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messageapp/apis/apis.dart';
import 'package:messageapp/screens/auth/login_screen.dart';
import 'package:messageapp/screens/home_screen.dart';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), (){
      setState(() {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.white, statusBarColor: Colors.white));

        if(APIs.auth.currentUser!=null){
          print('\nUser: ${APIs.auth.currentUser}');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
        }


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              right: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset("images/chat.png", )
          ),
          Positioned(
              bottom: mq.height * .15,
              width: mq.width,
              child: Text("Chat App", style: TextStyle(fontSize: 16, color: Colors.black87, letterSpacing: .5),textAlign: TextAlign.center,)
          )
        ],
      ),
    );
  }
}
