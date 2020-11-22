import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculer vos intérêts et mensualités'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController t_controller = new TextEditingController();
  TextEditingController a_controller = new TextEditingController();
  TextEditingController s_controller = new TextEditingController();
  var calcul1;
  var calcul2;

  calculInteret(taux, duree, somme){
    calcul1 = (somme*((taux/100)/12))/(1-pow(1+((taux/100)/12), (-12*duree)));
    calcul2 = (12*duree*calcul1)-somme;
    showAlertDialog(context, calcul1, calcul2);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body:  SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/house.png'), fit:BoxFit.fitWidth)
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(60, 15, 60, 30),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: s_controller,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        labelText: "Entrez la somme empruntée",
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color:Colors.white)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color:Colors.white)
                        ),
                        fillColor: Color(0x6C63FE).withOpacity(1),
                        filled: true,
                        focusColor: Colors.white
                      ),
                      validator: (val){
                        if(val.length == 0){
                          return "Votre emprunt ne peut être nul";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: t_controller,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        labelText: "Entrez votre taux d'emprunt",
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color:Colors.white)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color:Colors.white)
                        ),
                        fillColor: Color(0x6C63FE).withOpacity(1),
                        filled: true,
                        focusColor: Colors.white
                      ),
                      validator: (val){
                        if(val.length == 0){
                          return "Votre taux ne peut être nul";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.numberWithOptions(decimal:true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: a_controller,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        labelText: "Entrez votre durée d'emprunt en année",
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color:Colors.white)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color:Colors.white)
                        ),
                        fillColor: Color(0x6C63FE).withOpacity(1),
                        filled: true,
                        focusColor: Colors.white
                      ),
                      validator: (val){
                        if(val.length == 0){
                          return "Votre durée d'emprunt ne peut être nulle";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height:20),
                    FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color:Colors.red)),
                      child: Text('CALCULER'),
                      color: Colors.white,
                      textColor: Colors.red,
                      height: 50,
                      minWidth: 100,
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          calculInteret(
                            double.parse(t_controller.text),
                            int.parse(a_controller.text),
                            int.parse(s_controller.text),
                          );
                        }
                      },),
                  ],),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}


showAlertDialog(BuildContext context, mensualite, interet){
  Widget closeButton = FlatButton(onPressed: ()=>Navigator.pop(context), child: Text('Close', style: TextStyle(color:Colors.red),));
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: Colors.grey[800],
    title: Text("Mes intérêts et mensualités", textAlign: TextAlign.center, style: TextStyle(color: Color(0x6C63FE).withOpacity(1)),),
    content: Text('Intérêts : '+interet.toStringAsFixed(2)+' €\n'+'Mensualités : '+mensualite.toStringAsFixed(2)+' €', style: TextStyle(color: Colors.white),),
    actions: [
      closeButton,
    ],
  );
  showDialog(context: context,
  builder: (context){
    return alert;
  });
}