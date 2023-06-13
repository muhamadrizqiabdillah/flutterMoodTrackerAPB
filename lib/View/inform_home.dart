import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class sangatbaik extends StatefulWidget {
  const sangatbaik({Key? key}) : super(key: key);

  @override
  State<sangatbaik> createState() => _sangatbaikState();
}

class _sangatbaikState extends State<sangatbaik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emoji"),
      ),
      body: PageView(
        children: [
          Container(
            color: Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  foto
                Text(
                  '🤩',
                  style: TextStyle(
                    fontSize: 75,
                  ),
                ),
                Text(
                  "this image discribe : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "your mood is very good",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                )
                //  penjelasan
              ],
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  foto
                  Text(
                    '🙂',
                    style: TextStyle(
                      fontSize: 75,
                    ),
                  ),
                  Text(
                    "this image discribe : ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "your mood is good",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  )
                  //  penjelasan
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  foto
                Text(
                  '😐',
                  style: TextStyle(
                    fontSize: 75,
                  ),
                ),
                Text(
                  "this image discribe : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "your mood is oke",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                )
                //  penjelasan
              ],
            ),
          ),
          Container(
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  foto
                Text(
                  '😑',
                  style: TextStyle(
                    fontSize: 75,
                  ),
                ),
                Text(
                  "this image discribe : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "your mood is bad",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                )
                //  penjelasan
              ],
            ),
          ),
          Container(
            color: Colors.amberAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  foto
                Text(
                  '😡',
                  style: TextStyle(
                    fontSize: 75,
                  ),
                ),
                Text(
                  "this image discribe : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "your mood is very bad",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                )
                //  penjelasan
              ],
            ),
          ),
        ],
      ),
    );
  }
}
