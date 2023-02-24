import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:wondertime/Start2.dart';
// import '10minago.dart';

class Start extends StatelessWidget {
  final ImageProvider images;
  Start({
    Key? key,
    this.images = const AssetImage('assets/images/litaimg.png'),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 256.0, middle: 0.4745),
            Pin(size: 168.0, end: 48.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(27.0, 0.0),
                  child: Text(
                    '休憩を作ろう',
                    style: TextStyle(
                      fontFamily: 'Hiragino Kaku Gothic ProN',
                      fontSize: 35,
                      color: const Color(0xffffffff),
                    ),
                    softWrap: false,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, 93.0),
                  child: ElevatedButton (
                    // offset: Offset(0.0, 93.0),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Start2()),
                        // MaterialPageRoute(builder: (context) => TimerApp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                      onPrimary: Colors.blue,
                    ),

                    child: SizedBox(
                      width: 256.0,
                      height: 75.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 256.0,
                            height: 75.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff32e891),
                              borderRadius: BorderRadius.circular(38.0),
                            ),
                          ),

                          Transform.translate(
                            offset: Offset(70.0, 14.0),
                            child: Text(
                              '始める',
                              style: TextStyle(
                                fontFamily: 'Hiragino Kaku Gothic ProN',
                                fontSize: 30,
                                color: const Color(0xffffffff),
                              ),
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: images,
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 234.0),
          ),
        ],
      ),
    );
  }
}
