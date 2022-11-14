import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 공통적인것을 미리 작성한다.
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num = 1;

  void increase() {
    setState(() {
      // 상태를 rebuild 시킨다.
      num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double screenSize = size * 0.8;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Acomponent(num: num)),
          Expanded(
              child: Bcomponent(
                  increase:
                      increase)), // 부모를 statful하게 설정 시 자식을 재활용 하고 싶다면 const를 붙힌다.
        ],
      ),
    );
  }
}

//컨슈머(소비자)
class Acomponent extends StatelessWidget {
  final int num;
  const Acomponent({Key? key, required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        children: [
          Text("Acomponent"),
          Expanded(
            child: Align(
              child: Text(
                "${num}",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//서플라이어 공급자
class Bcomponent extends StatelessWidget {
  final Function increase;
  const Bcomponent({Key? key, required this.increase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Text("Bcomponent"),
          Expanded(
            child: Align(
              child: ElevatedButton(
                  onPressed: () {
                    increase();
                  },
                  child: Text(
                    "숫자증가",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
