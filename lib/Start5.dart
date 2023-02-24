import 'package:flutter/material.dart';
import 'Start6.dart';
// void main() => runApp(Start()); // 引数のWidgetが全画面表示される

// 最初に表示するWidgetのクラス
class Start5 extends StatelessWidget {  // StatelessWidgetを継承
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
    return SizedBox(
      width: 390,
      height: 844,
      child: Material(
        color: Color(0xff171717),
        child: Padding(
          padding: const EdgeInsets.only(left: 38, right: 15, top: 38, bottom: 89, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
            SizedBox(
            width: 118,
            child: Text(
              "Stap3",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
              ),
            ),
          ),
          SizedBox(height: 225),
          SizedBox(
            width: 337,
            child: Text(
                "通知を出すにはアプリを別のものに切り替えるか、終了させる必要があります。(iOSのみ)\n\nAndroidでアプリを終了させないで起動したままだと、チャイムも鳴ってしまう不具合があります。",
            style: TextStyle(
            color: Color(0xffd5d5d5),
            fontSize: 20,
          ),
        ),
      ),
      SizedBox(height: 88),
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Start6()));
        },
      child: SizedBox(
        width: 243,
        height: 70,
        child: Material(
          color: Color(0xff32e891),
          borderRadius: BorderRadius.circular(34.50),
          child: Padding(
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
      ),
          ),
      ],
    ),
    ),
    ),
    );
  }
}