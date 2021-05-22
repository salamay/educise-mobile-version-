import 'dart:convert';
import 'dart:io';
import 'package:educise/Screens/Widget/TimeoutPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostRequest{
  var client = http.Client();

  Future<http.Response> sendData(BuildContext context,String url,Map<String,dynamic> data,String token)async {
    var uri = Uri.parse(url);
    String body=json.encode(data);
    if(token==null){
      final response =await client.post(uri,headers: {
        'Content-Type': "application/json",
      },body: body,encoding: Encoding.getByName("utf-8")).catchError((error, stackTrace) {Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TimeOutPage(body: "Connection error",)));});
      return response;
    }
    else{
      final response =await client.post(uri,headers: {
        'Content-Type': "application/json",'Authorization': "Bearer "+token,
      },body: body,encoding: Encoding.getByName("utf-8")).catchError((error, stackTrace) {Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TimeOutPage(body: "Connection error",)));});
      return response;
    }
  }
}