
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/httpDemo/app.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

import 'apk_download_state.dart';


class Remind extends StatefulWidget{





  final List<String> contents;
  final bool force;
  final String title;
  final String apkDownloadUrl;
  final DownloadProgressCallback downloadProgress;
  final DownloadStatusChangeCallback downloadStatusChange;
  final VoidCallback onCancel;
  Remind({
    @required this.title,
    @required this.contents,
    @required this.force,
    this.onCancel,
    this.apkDownloadUrl,
    this.downloadProgress,
    this.downloadStatusChange
  });


  @override
  State<StatefulWidget> createState() => _Remind();

}



class _Remind extends State<Remind>{

  static final String _downloadApkName = 'temp.apk';

  ///
  /// 下载进度
  ///
  double _downloadProgress = 0.0;

  ApkDownloadStatus _apkDownloadStatus = ApkDownloadStatus.none;



  @override
  Widget build(BuildContext context) {
    return  Container(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 30),
            child: Text(widget.title,
                style: TextStyle(fontSize: 22)),
          ),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
              height: 200,
              child: ListView(
                children: widget.contents.map((f) {
                  return Text(f,
                    style:TextStyle(fontSize: 18,color: Colors.lightBlueAccent),
                  );
                }).toList(),
              )),
          Column(
            children: <Widget>[
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Row(
                children: <Widget>[
                  widget.force
                      ? Container()
                      : Expanded(
                    child: _buildCancelActionButton(),
                  ),
                  Expanded(
                    child: _buildOkActionButton(),
                  ),
                ],
              ),
            ],
          )
        ],) ,);
  }


  _buildCancelActionButton() {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20))),
      child: InkWell(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20)),
          child: Container(
            height: 45,
            alignment: Alignment.center,
            child: Text( '以后再说',
                style: TextStyle()),
          ),
          onTap: () {
            widget.onCancel?.call();
            Navigator.of(context).pop();
          }),
    );
  }

  ///
  /// 确定按钮
  ///
  _buildOkActionButton() {
     var _okBackgroundColors = [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor
      ];

    return Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_okBackgroundColors[0], _okBackgroundColors[1]]),
          ),
      child: InkWell(
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: Text( '立即体验',
              style:  TextStyle(color: Colors.white)),
        ),
        onTap: () {

          _clickUpdate(widget.apkDownloadUrl);
        },
      ),
    );
  }

  _clickUpdate(String url) async{
    String path = await App.downloadPath;

    if (widget.apkDownloadUrl == null || widget.apkDownloadUrl.isEmpty) {
      print('此处后去需编写转跳应用市场代码');
    }
    _updateApkDownloadState(ApkDownloadStatus.start);

    try{
      var dio =Dio();
      await dio.download(url, path,onReceiveProgress: (int count,int total){
        if(total == -1){
          _downloadProgress = 0.01;
        }else{
          widget.downloadProgress?.call(count,total);
          _downloadProgress = count/total.toDouble();
        }
        setState(() {});
        if(_downloadProgress ==1){
          _updateApkDownloadState(ApkDownloadStatus.done);
          Navigator.pop(context);
          App.installAppForAndroid(path);

        }
      });

    }catch(e){
      print('$e');
      _downloadProgress = 0;
      _updateApkDownloadState(ApkDownloadStatus.error,error: e);
    }


  }


  _updateApkDownloadState(ApkDownloadStatus apkDownloadStatus,{dynamic error}){
    _apkDownloadStatus = apkDownloadStatus;


  }


}