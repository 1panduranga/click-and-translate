import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';

class Translate extends StatefulWidget {
  final File image;
  final bool  img;
  Translate({this.image, this.img});
  @override
  _TranslateState createState() => _TranslateState();
   
  
}

class _TranslateState extends State<Translate> {
 @override
  void initState() {
    super.initState();
    print("**************************************************************************init ");
    if(widget.img==true)
    {
      print("**************************************************************************init success");
      textTranslate();
    }
  }


  void textTranslate()async {
    try{
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(widget.image);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    print("************************************************************************* got text");
    setState(() {
      inputText= visionText.text;
      txt.text=visionText.text;
    }); 
    textRecognizer.close();
    }
    catch (e){
      print("%^%^%%^%^%^%^%^%^%^%^%^%^%^%^%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5 $e");
    }
    
    print("**************************************************************************getting translation");
    await getTranslation();
    setState(() {
      display=true;
      copied=false;
    });
    print("**************************************************************************got translation");
    
  }

  Divider divide= Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          );
 var txt = TextEditingController();
 String copyHint="copy to clipboard";
VoiceController controller = FlutterTextToSpeech.instance.voiceController();



Future paste() async{

      ClipboardData data= await Clipboard.getData("text/plain");
      setState(() {
        txt.text=data.text;
        inputText=txt.text;
      });

}

Future getTranslation() async{
  Navigator.pushNamed(context,'/loading');
   try{
     setState(() {
       outputText="";
     });
     final translator = new GoogleTranslator();
     if(inputLang=="Auto detect"){
       await translator.translate(inputText, to:codes[outputLang]).then((s) => s!=""?setState((){outputText=s;}):setState((){outputText="Something's wrong.Try again";}));
     }
     else{
       await translator.translate(inputText, from:codes[inputLang] , to:codes[outputLang]).then((s)=>s!=""?setState((){outputText=s;}):setState((){outputText="Something's wrong.Try again";})); 
     }
    }
   catch (e){
    setState(() {
      outputText="Something went wrong.Try again";
    });
   }
   Navigator.pop(context);
 }
 
Future sound() async{
   try{
     print(outputText);
    controller.init().then((_) {
      controller.speak(
          outputText, VoiceControllerOptions(delay: 0));
    });
  }
  catch(e){
    print(e);
  }

}

 


  void copy(){ 
    if(copied==false){
      copyHint="remove from clipboard";
      Clipboard.setData(new ClipboardData(text:outputText));
      
    }
    else{
      copyHint="copy to clipboard";
      Clipboard.setData(new ClipboardData(text:""));
    }
    setState(() {
      copied=!copied;
    });
  }
  bool sounded=false;
  bool speaked=false;
  bool copied=false;
  bool display=false;
  String outputText='';
  int maxLines=5;
  String inputText='';
  String inputLang = 'Auto detect';
  String outputLang="Telugu";
  Map codes={'Telugu':'te','English':'en','Tamil':'ta','Hindi':'hi','Irish':'ga','Italian':'it','Arabic':'ar','Japanese':'ja','Kannada':'kn','Korean':'ko','Bengali':'bn','Latin':'la','Chinese':'zh-CN','Polish':'pl','Dutch':'nl','Portuguese':'pt','Romanian':'ro','Russian':'ru','Spanish':'es','French':'fr','German':'de','Turkish':'tr','Urdu':'ur','Vietnamese':'vi'};
  List <String> inLang=['Auto detect','Telugu', 'English', 'Tamil', 'Hindi','Irish','Italian','Arabic','Japanese','Kannada','Korean','Bengali','Latin','Chinese','Polish','Dutch','Portuguese','Romanian','Russian','Spanish','French','German','Turkish','Urdu','Vietnamese'];
  List <String> allLang=['Telugu', 'English', 'Tamil', 'Hindi','Irish','Italian','Arabic','Japanese','Kannada','Korean','Bengali','Latin','Chinese','Polish','Dutch','Portuguese','Romanian','Russian','Spanish','French','German','Turkish','Urdu','Vietnamese'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      backgroundColor: Colors.black,
      elevation: 0.0,
      centerTitle:true,
      actions: <Widget>[
         Container(
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround ,
                 children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical:0.0,horizontal:0.0),
              child: DropdownButton<String>(
              dropdownColor: Colors.grey[800],
              value: inputLang,
              icon: Icon(Icons.expand_more,color: Colors.white,),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.white),
              onChanged: (String newValue) {
                setState(() {
                  inputLang = newValue;
                });
              },
              items: 
                  inLang.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              ),
            ),

            Padding(
               padding: const EdgeInsets.symmetric(vertical:0.0,horizontal:20.0),
              child: Text(
                "to",
                style: TextStyle(color:Colors.grey[500]),),
            ),

             Padding(
               padding: const EdgeInsets.symmetric(vertical:0.0,horizontal:20.0),
               child: DropdownButton<String>(
            dropdownColor: Colors.grey[800],
            value: outputLang,
            icon: Icon(Icons.expand_more,color: Colors.white,),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.white),
            onChanged: (String newValue) {
                setState(() {
                  outputLang = newValue;
                });
            },
            items: 
                  allLang.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
            }).toList(),
            ),
             ),
               ],)
            ),
      ],
  ),
  body:SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txt,
                  style: TextStyle(color:Colors.white),
                  cursorColor: Colors.grey[200],
                  // readOnly:true,
                  maxLines: maxLines,
                  decoration:InputDecoration(
                    suffixIcon: Column(
                        children: <Widget>[
                          IconButton(
                            tooltip:"Paste from clipboard",
                            icon: Icon(
                            Icons.content_paste,color: Colors.white,
                            ),
                             onPressed:(){
                               paste();
                               }
                            ),
                        ],
                      ),
                    hintText: "Type or paste something to translate...",
                    hintStyle: TextStyle(color:Colors.grey[600]),
                    fillColor: Colors.grey[900],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width:0.0),
                    ),
                     focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width:0.0),
                    )
                  ),
                  onChanged:(val){
                    if(val=="")
                    {
                      setState(() {
                        outputText="";
                        display=false;
                      });
                    }
                    inputText=val;}
                ),
              )
              ),
               RaisedButton.icon(
             onPressed: () async {
               
               await getTranslation();
               setState(() {
                 display=true;
                 copied=false;
               });
               
             },
            icon:Icon(Icons.translate),
            color:Colors.grey[300],
            label:Text("Translate")),
            if(display)
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                    style: TextStyle(color:Colors.white),
                    cursorColor: Colors.grey[200],
                   keyboardType: TextInputType.multiline,
                   readOnly: true,
                   maxLines: maxLines,
                   enableInteractiveSelection: true,
                    decoration:InputDecoration(
                      suffixIcon: Column(
                        children: <Widget>[
                          IconButton(
                            tooltip:copyHint,
                            icon: copied ? Icon(
                            Icons.done,color: Colors.blue,
                            
                            ) : Icon(
                            Icons.content_copy,color: Colors.white,
                            ),
                             onPressed:(){
                               copy();
                               }
                            ),
                            IconButton(
                            tooltip:"spell aloud",
                            icon: sounded ? Icon(
                            Icons.volume_up,color: Colors.blue,
                            ) : Icon(
                            Icons.volume_up,color: Colors.white,
                            ),
                             onPressed:() async {
                               setState(() {
                                 sounded=true;
                               });
                              await sound();
                              setState(() {
                                sounded=false;
                              });
                               }
                            ),
                        ],
                      ),
                      hintText: "$outputText",
                      hintStyle: TextStyle(color:Colors.grey[200]),
                      fillColor: Colors.grey[900],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width:0.0),
                      ),
                       focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width:0.0),
                      )
                    ),
                    onChanged:(val){inputText=val;}
                  ),
            ),
          ],
        ),
      ),
       ),
  )
    );
  }
}