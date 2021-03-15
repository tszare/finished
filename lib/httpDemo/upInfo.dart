
import 'package:flutter/material.dart';
import 'package:flutter_app/httpDemo/remind.dart';

import 'apk_download_state.dart';


class CheckUpgrade{

  static upgrade(BuildContext context, Future<AppUpgradeInfo> future){
    future.then((AppUpgradeInfo appUpgradeInfo) {
      print('${appUpgradeInfo.title}');
      if (appUpgradeInfo != null && appUpgradeInfo.title != null){
        _showUpgradeDialog(context,appUpgradeInfo);
      }
    }).catchError((onError){
      print('$onError');
    });
  }

  static _showUpgradeDialog(BuildContext context,AppUpgradeInfo appUpgradeInfo){
    print(appUpgradeInfo.contents);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return WillPopScope(
            onWillPop: ()async{
                return false;},
            child: Dialog(
              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Remind(
                force: appUpgradeInfo.force,
                title: appUpgradeInfo.title,
                contents: appUpgradeInfo.contents,),
            ),
          );
        });
  }
}



class UpgradeInfo{
  final int total;
  final AppUpgradeInfo data;
  final String desc;
  final CodeResult codeResult;
  final bool success;
  UpgradeInfo({this.data,this.total,this.codeResult,this.desc,this.success});
  factory UpgradeInfo.fromJson(Map<String,dynamic> json){
    return UpgradeInfo(
      total:json['total'],
      data: AppUpgradeInfo.fromJson(json['data']),
      desc: json['desc'],
      codeResult:CodeResult.fromJson(json['codeResult']),
      success: json['success'],
    );
  }
}

class AppUpgradeInfo {
  AppUpgradeInfo(
      {@required this.title,
        @required this.contents,
        this.apkDownloadUrl,
        this.force = false});




  final String title;
  final List<String> contents;
  final String apkDownloadUrl;
  final bool force;






  factory AppUpgradeInfo.fromJson(Map<String,dynamic> json){

    return AppUpgradeInfo(

      title:json['title'],
      contents: (json['contents'] as List)?.map((e) => e as String)?.toList(),
      force: json['force'],
      apkDownloadUrl:json['apkDownloadUrl'],
    );
  }


}

class CodeResult{
  final String massage;
  final int code;

  CodeResult({this.massage,this.code});
  factory CodeResult.fromJson(Map<String, dynamic> json){
    return CodeResult(
      massage: json['massage'],
      code: json['code'],
    );
  }
}

typedef DownloadProgressCallback = Function(int count, int total);


typedef DownloadStatusChangeCallback = Function(ApkDownloadStatus apkDownloadStatus,
    {dynamic error});
