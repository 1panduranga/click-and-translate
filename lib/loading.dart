import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(
              color:Colors.white,
              size:30.0,
            ),
            SizedBox(height:5.0),
            Text("loading",style: TextStyle(color:Colors.blueGrey),),
          ],
        )
      )
      );
  }
}