

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
                              TextField(
                                decoration: InputDecoration(

                                      labelText: "Reais",
                                      labelStyle: TextStyle(
                                          color: Colors.amber
                                      ),
                                       border: OutlineInputBorder(),
                                      prefixText: "R\$ "

                                ),
                                style: TextStyle(color: Colors.white),

                              ),

                              Divider(),
                                                      TextField(
                                decoration: InputDecoration(

                                      labelText: "Dólares",
                                      labelStyle: TextStyle(
                                          color: Colors.amber
                                      ),
                                       border: OutlineInputBorder(),
                                      prefixText: "US\$ "

                                ),
                                style: TextStyle(color: Colors.white),

                              ),
                                        Divider(),                    TextField(
                                decoration: InputDecoration(

                                      labelText: "Euros",
                                      labelStyle: TextStyle(
                                          color: Colors.amber
                                      ),
                                       border: OutlineInputBorder(),
                                      prefixText: "euros "

                                ),
                                style: TextStyle(color: Colors.white),

                              )  
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