import 'package:flutter/cupertino.dart';

import '../screens/loading_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networkhelper {
  Networkhelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);
      var decodeddata = jsonDecode(data);
      return decodeddata;
    } else {
      print(response.statusCode);
    }
  }
}

//
