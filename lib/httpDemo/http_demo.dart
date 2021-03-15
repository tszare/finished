
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/httpDemo/upInfo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/httpDemo/upInfo.dart' as upInfos;

class HttpDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('测试网络请求'),
        centerTitle: true,
      ),
      body: HttpBodyHome(),
    );
  }
}


class HttpBodyHome extends StatefulWidget{
  @override
  _HttpBodyHomeState createState() =>_HttpBodyHomeState();
}

class _HttpBodyHomeState extends State<HttpBodyHome>{
  var get;

  Future<BookInfo> fetchPost() async{
    final response = await http.get('http://192.168.14.211:8004/platform/flutter');
    if(response.statusCode==200){
      Utf8Decoder decode =new Utf8Decoder();
      String result= decode.convert(response.bodyBytes);
      var ajson=json.decode(result);
      BookInfo bookInfo=BookInfo.fromJson(ajson);
      return bookInfo;
    }else{
      return null;
    }
  }


  Future<upInfos.AppUpgradeInfo> _checkAppInfo() async {
    final upCheckResult = await http.get('http://192.168.14.211:8004/platform/upGrade');
    if(upCheckResult.statusCode==200){
      Utf8Decoder decode =new Utf8Decoder();
      String result= decode.convert(upCheckResult.bodyBytes);
      var aJson=json.decode(result);
      UpgradeInfo bookInfo=UpgradeInfo.fromJson(aJson);
      print(result);
      return bookInfo.data;
    }

  }


  @override
  void initState() {
    CheckUpgrade.upgrade(
      context,
      _checkAppInfo(),
    );
    super.initState();
    get = fetchPost();

  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: get,
        builder: _futureBuild
    );
  }


  Widget _futureBuild(BuildContext context, AsyncSnapshot snapshot){
    print('data:${snapshot.connectionState}');
    if(snapshot.connectionState==ConnectionState.done){

      return CustomScrollView(
        slivers: [
          SliverFixedExtentList(
            itemExtent: 150,
            delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
              return Container(
                decoration: BoxDecoration(border:Border(bottom: BorderSide(width: 1,color: Colors.grey[400]),),
                ),
                child: Row(children: [
                  Expanded(child:Container(
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: NetworkImage(snapshot.data.data[index].image),
                       fit: BoxFit.contain,
                     )
                   ),
                  ),flex: 1,),
                  Expanded(child: Text(snapshot.data.data[index].title),flex: 4,)
                ],),
              );
            },
              childCount:snapshot.data.data.length,
            ),
          )
        ],
      );
    }else{
      return Center(
        child: Text('loading....'),
      );
    }
}
}


class BookInfo{
  final int total;
  final List<Info> data;
  final String desc;
  final CodeResult codeResult;
  final bool success;
  BookInfo({this.data,this.total,this.codeResult,this.desc,this.success});
  factory BookInfo.fromJson(Map<String,dynamic> json){
    var temInfo =json['data'] as List;
    List<Info> infoList = temInfo.map((i) => Info.fromJson(i)).toList();
    return BookInfo(
      total:json['total'],
      data: infoList,
      desc: json['desc'],
      codeResult:CodeResult.fromJson(json['codeResult']),
      success: json['success'],
    );
  }
}

class Info{
  final String title;
  final String profile;
  final String image;
  Info({this.title,this.image,this.profile});
  factory Info.fromJson(Map<String,dynamic> json){
    return Info(
      title: json['title'],
      profile: json['profile'],
      image:json['image']
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