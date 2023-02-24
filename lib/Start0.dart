import 'package:flutter/material.dart';
import 'Start2.dart';
import 'package:adobe_xd/pinned.dart';
// void main() => runApp(Start()); // 引数のWidgetが全画面表示される

// 最初に表示するWidgetのクラス
class Start extends StatelessWidget {  // StatelessWidgetを継承
  Start({
    Key? key,
  }) : super(key: key);
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
      padding: const EdgeInsets.only(top: 93, bottom: 39, ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Container(
            width: 392,
            height: 616,
            child: Image.asset(
                'image/LitaIlast2.png'
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 35),
          Container(
            width: 243,
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Start2()));
                },
                child: Container(
                  width: 243,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34.50),
                    color: Color(0xff32e891),
                  ),
                  padding: const EdgeInsets.only(left: 101, right: 102, top: 16, bottom: 15, ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Text(
                        "進む",
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
          ),
        ],
      ),
    );
  }
}