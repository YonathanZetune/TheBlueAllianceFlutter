import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:tba_application/team.dart';
import 'package:tba_application/teamView.dart';
import 'package:tba_application/main.dart';

class Requests {
    static String getTeamsJsonForRequest(String reqPath) {
        String result;
        HttpClient myhttp = new HttpClient();
        myhttp.get('www.thebluealliance.com', 80, '/api/v3' + reqPath) 
        .then((HttpClientRequest request) {
            request.headers.set("accept", "application/json");
            request.headers.set("X-TBA-Auth-Key", "yQEov7UAGBKouLOxmatZFhTJUv7km660eKXAKgeJElVIp6iGtrsRrfk1JuvXxrMC");
            return request.close();
        })
        .then((HttpClientResponse response) {
            response.transform(utf8.decoder).transform(json.decoder).listen((conts) {
                print(conts);
                result = conts.toString();
            });
        });
        return result;
    }
}

