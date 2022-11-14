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
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AbComponent(),
          HomePage(),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double screenSize = size * 0.5;
    return Container(
      child: Container(
        color: Colors.green,
        width: screenSize,
      ),
    );
  }
}

class AbComponent extends StatefulWidget {
  const AbComponent({Key? key}) : super(key: key);

  @override
  State<AbComponent> createState() => _HomePageState();
}

class _HomePageState extends State<AbComponent> {
  int num = 1;

  void increase(int n) {
    setState(() {
      // 상태를 rebuild 시킨다.
      num += n;
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double screenSize = size * 0.5;
    return SizedBox(
      width: screenSize,
      child: Column(
        children: [
          Expanded(child: Acomponent(num: num)),
          Expanded(
            child: Bcomponent(increase: (n) {
              increase(n);
            }),
          ), // 부모를 statful하게 설정 시 자식을 재활용 하고 싶다면 const를 붙힌다.
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
                    increase(1);
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
