import 'package:snap_and_translate/help.dart';
import 'package:snap_and_translate/loading.dart';
import 'package:snap_and_translate/translate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  routes: {
    '/':(context)=> MyApp(),
    '/help':(context)=>Help(),
    '/translate':(context)=>Translate(),
    '/loading':(context)=>Loading(),
  },
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future getImage (bool isCamera) async{
    File image;
    if(isCamera)
    {
      image= await ImagePicker.pickImage( source:ImageSource.camera);     
    }
    else{
      image= await ImagePicker.pickImage( source:ImageSource.gallery);
    }
    print("************************************************************ called");
    Translate(image:image,img:true);
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Translate(image:image,img:true),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: Text(
        "Snap & Translate",
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
  body: SingleChildScrollView(
      child: Column(
      children: <Widget>[
        SizedBox(height:30.0),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image(
            image:AssetImage('assets/home.png'),
            ),
        ),
        SizedBox(height:50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Column(
            children: <Widget>[
              RaisedButton(
                onPressed: ()=>getImage(true),
                shape: CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.camera
                    ),
                ),
              ),
              SizedBox(height:5.0),
              Text("camera",style: TextStyle(color: Colors.grey),)
            ],
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                onPressed: ()=>getImage(false),
                shape:CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.image),
                ),
              ),
              SizedBox(height:5.0),
              Text("gallery",style: TextStyle(color: Colors.grey),)
            ],
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                onPressed: (){ Navigator.pushNamed(context,'/translate');},
                shape:CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.g_translate),
                ),
              ),
              SizedBox(height:5.0),
              Text("translate",style: TextStyle(color: Colors.grey),),
            ],
          ),
           Column(
             children: <Widget>[
               RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context,'/help');
                },
                shape:CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.live_help),
                ),
          ),
          SizedBox(height:5.0),
          Text("help",style: TextStyle(color: Colors.grey),)
             ],
           )
        ],
        ),        
        // _image==null? Container():Image.file(_image,height:300.0,width:300.0)

      ],
      ),
  )
  );
  }
}