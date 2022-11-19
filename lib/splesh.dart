// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'first.dart';

class splesh extends StatefulWidget {
  const splesh({Key? key}) : super(key: key);

  @override
  State<splesh> createState() => _spleshState();
}

class _spleshState extends State<splesh> {
  bool tap=false;
  @override
  void initState() {
     super.initState();
    spl();
  }
  spl()
  async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return frist();
    },
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              alignment: Alignment.center,
              child: Text("Loading..",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
            )),
          ],
        )
    );

  }
}
