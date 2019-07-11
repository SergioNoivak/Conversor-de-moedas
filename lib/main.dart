

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';



const url = "https://api.hgbrasil.com/finance?key=391b4a06";

void main() async{

  http.Response response = await http.get(url);
  print(json.decode(response.body));
  runApp(MaterialApp(home:Container()));
  
}