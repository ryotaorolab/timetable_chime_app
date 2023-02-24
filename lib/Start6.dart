import 'package:flutter/material.dart';
import 'main.dart';
// void main() => runApp(Start()); // 引数のWidgetが全画面表示される

// 最初に表示するWidgetのクラス
class Start6 extends StatelessWidget {  // StatelessWidgetを継承
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
          padding: const EdgeInsets.only(left: 52, right: 27, top: 151, bottom: 89, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
                "お待たせしました",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 100.50),
              SizedBox(
                width: 311,
                height: 200,
                child: Text(
                  "Wdの授業をいい感じするための\nアプリを使用する準備が整いました。\n\nこのアプリを使用して、最高の\n授業体験をお子さんに届けましょう。",
                  style: TextStyle(
                    color: Color(0xffd5d5d5),
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 150.88),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TimerApp()));
                },
                child: SizedBox(
                  width: 243,
                  height: 70,
                  child: Material(
                    color: Color(0xff0bff8a),
                    borderRadius: BorderRadius.circular(34.50),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 82, right: 81, top: 16, bottom: 15, ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Text(
                            "はじめる",
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