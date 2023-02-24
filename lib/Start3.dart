import 'package:flutter/material.dart';
import 'main0.dart';
import 'Start4.dart';
// void main() => runApp(Start()); // 引数のWidgetが全画面表示される

// 最初に表示するWidgetのクラス
class Start3 extends StatelessWidget {  // StatelessWidgetを継承
  @override
  Widget build(BuildContext context) {  //buildメソッドでUIを作成
    return MaterialApp(  // マテリアルデザインのアプリ
      title: "My Simple App",  // アプリのタイトル
      home: Scaffold(
        body: Scaffold(
          body: ListView(
            children: [
              StartmenueWidget()
            ],
          ),
        ),  //　Center
      ),  //　Scaffold
    );  //　MaterialApp
  }  //　Widget build(BuildContext context)
}  //　class MyApp

class StartmenueWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844,
      color: Color(0xff171717),
      padding: const EdgeInsets.only(left: 38, right: 15, top: 38, bottom: 89, ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Text(
            "Stap1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          SizedBox(height: 125),
          Container(
            width: 312,
            height: 99,
            child: Image.asset(
                'image/notifics.png'
                  // fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 125),
          SizedBox(
            width: 337,
            child: Text(
              "授業開始時間とFBの時間\n授業終了時間に通知で教えてくれる\nアプリです。\n\n起動したままにすると授業終了時のみチャイムがなります。",
              style: TextStyle(
                color: Color(0xffd5d5d5),
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 70),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Start4()));
          },
          child : Container(
            width: 243,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34.50),
              color: Color(0xff32e891),
            ),
            padding: const EdgeInsets.only(left: 92, right: 91, top: 16, bottom: 15, ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(
                  "つぎへ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ),
        ],
      ),
    );
  }
}