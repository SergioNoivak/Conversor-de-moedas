

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';



const url = "https://api.hgbrasil.com/finance?key=391b4a06";

void main() async{

 runApp(
   MaterialApp(
      home:Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white
      ),
 )
 
 
 );
  
}

class Home extends StatefulWidget {
@override
_HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

double dollar;
double euro;
double real;
TextEditingController controladorReal = TextEditingController();
TextEditingController controladorDolar = TextEditingController();
TextEditingController controladorEuro = TextEditingController();


void onChangeReal(String text){

    double real = double.parse(text);
    this.controladorDolar.text = (real/this.dollar).toStringAsFixed(2);
    this.controladorEuro.text = (real/this.euro).toStringAsFixed(2);

}void onChangeDolar(String text){
      double dollar = double.parse(text);
      this.controladorReal.text = (dollar*this.dollar).toStringAsFixed(2);
      this.controladorEuro.text = (dollar*this.dollar/this.euro).toStringAsFixed(2);


}void onChangeEuro(String text){
      double euro = double.parse(text);
      this.controladorReal.text = (euro*this.euro).toStringAsFixed(2);
      this.controladorDolar.text = (euro*this.euro/this.dollar).toStringAsFixed(2);
}

@override
Widget build(BuildContext context) {
return Scaffold(
        backgroundColor:Colors.black ,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: <Widget>[
          ],
        ),

        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context,snapshot){
            switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: Text("Carregando dados", style: TextStyle(color: Colors.amber,fontSize: 10))); 
                default:
                  if(snapshot.hasError){
                      return Center(child: Text("Erro ao carregar dados", style: TextStyle(color: Colors.amber,fontSize: 10))); 
                  }
                  else{
                      dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                      euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                      return SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child:Column(children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Icon(Icons.monetization_on,size:150.0, color:Colors.amber),
                             buildTextFild("Reais", "R\$",controladorReal,onChangeReal),
                              Divider(),
                              buildTextFild("Dolares", "US\$",controladorDolar,onChangeDolar),              
                               Divider(),
                              buildTextFild("Euros", "euros: ",controladorEuro,onChangeEuro),              


                          ],)

                      ],
                      ) 
                      );
                  }
            }

          } 
        ),

);
}
}



Future<Map>  getData() async{

  http.Response response = await http.get(url);
  return json.decode(response.body);
}




Widget buildTextFild(String label, String prefix,TextEditingController controlador,Function onchange){

  return   TextField(
                                decoration: InputDecoration(

                                      labelText: label,
                                      labelStyle: TextStyle(
                                          color: Colors.amber
                                      ),
                                       border: OutlineInputBorder(),
                                      prefixText: prefix

                                ),
                                style: TextStyle(color: Colors.white),
                              controller: controlador,
                              onChanged: onchange,
                              keyboardType: TextInputType.number,
                              )  ;
}


