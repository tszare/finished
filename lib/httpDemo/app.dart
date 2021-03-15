import 'package:flutter/services.dart';
import 'package:flutter_app/httpDemo/app.dart';


class App {

  static const MethodChannel _channel = const MethodChannel('app');

  static Future<String> get downloadPath async{
    return await _channel.invokeMethod('getApkDownLoadPath');
  }


  static installAppForAndroid(String path) async {
    var map = {'path': path};
    return await _channel.invokeMethod('install', map);
  }


}