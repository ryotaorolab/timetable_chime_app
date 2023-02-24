import 'package:flutter/material.dart';
import 'package:wondertime/Start3.dart';
import 'main.dart';
// void main() => runApp(Start()); // 引数のWidgetが全画面表示される

// 最初に表示するWidgetのクラス
class Start2 extends StatelessWidget {  // StatelessWidgetを継承
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
      padding: const EdgeInsets.only(left: 68, right: 63, top: 197, bottom: 45, ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Text(
            "質問です",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          SizedBox(height: 92.75),
          Text(
            "このアプリの使い方は\nご存知ですか？",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffd5d5d5),
              fontSize: 20,
            ),
          ),
          SizedBox(height: 92.70),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Start3()));
            },
          child: Container(
            width: 243,
            height: 60,
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
                  "いいえ",
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
          SizedBox(height: 70.75),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => TimerApp()));
          },
          child: Container(
            width: 243,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34.60),
              color: Color(0xffd5e9df),
            ),
            padding: const EdgeInsets.only(left: 102, right: 101, ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(
                  "はい",
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
          SizedBox(height: 80.65),
          Text(
            "はいを選択した場合、チュートリアルをスキップします。",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffd5d5d5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}