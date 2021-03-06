import 'dart:convert';

import 'package:educise/Screens/Widget/TimeoutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Get{
  var client = http.Client();
  Future<http.Response> getData(BuildContext context,String url,String token)async{
    var uri = Uri.parse(url);
    final response =await client.get(uri,headers: {'Authorization': "Bearer "+token,}).catchError((error, stackTrace) {Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TimeOutPage(body: "Connection error",)));});
    print(response.statusCode);
    return response;
  }
}