import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      title: Text(
        "How to use this app",
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize:20.0,
          fontWeight:FontWeight.w300,
          fontFamily: 'Pacifico',
          ),
          ),
      backgroundColor: Colors.black,
      elevation: 0.0,
      centerTitle:true,
  ),
  body:Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical:100.0,horizontal:25.0),
      child: Column(
        children:<Widget>[
          Text("This app lets you translate text from one language to another using any of these three ways.",style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily:'QuickSand'),textAlign: TextAlign.justify,),
          SizedBox(height:35.0),
          Text("1. Click the camera icon to translate text infront of you by taking a picture.",style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily:'QuickSand'),textAlign: TextAlign.justify,),
          SizedBox(height:20.0),
          Text("2. Click the gallery icon to translate text from a pic that you already had.",style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily:'QuickSand',),textAlign: TextAlign.justify,),
          SizedBox(height:20.0),
          Text("3. Click the translate icon to translate by typing or pasting the text you want to translate.",style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily:'QuickSand'),textAlign: TextAlign.justify,)
        ]
      ),
    ),
  ),
  );
  }
}