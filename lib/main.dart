import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double xPosition = 0;
  double yPosition = 0;

  @override
  Widget build(BuildContext context) {
    // 画面全体の幅
    final double screenWidth = MediaQuery.of(context).size.width;

    // 画面全体の高さ
    final double screenHeight = MediaQuery.of(context).size.height;

    // ステータスバーの高さ
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    // アプリバーの高さ
    final double appBarHeight = AppBar().preferredSize.height;

    // Scaffoldのボディの高さ
    final double bodyHeight = screenHeight - statusBarHeight - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<AccelerometerEvent>(
          stream: accelerometerEventStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // x軸のデータで縦方向（上下）の移動を制御
              yPosition = snapshot.data!.y * 10;

              // y軸のデータで横方向（左右）の移動を制御
              xPosition = snapshot.data!.x * 10;
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox.expand(),
                Positioned.fill(
                    child: Container(
                  color: Colors.blueAccent,
                )),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Color(0xFF000000),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: xPosition + (screenWidth / 2), // 中心からのオフセットを加算
                  top: yPosition + (bodyHeight / 2), // 中心からのオフセットを加算
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
