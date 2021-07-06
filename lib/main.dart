import 'package:flutter/material.dart';
import 'scrollable_positioned_list/lib/scrollable_positioned_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                'Forward',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            TextButton(
              child: Text(
                'Reversed',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePageReversed()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();

  List<String> _curList = ['0', '1', '2', '3'];
  int index = 4;
  final double alignment = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () => itemScrollController.jumpTo(
              index: 0,
              alignment: alignment,
            ),
            child: Text('To top',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          TextButton(
            onPressed: () => itemScrollController.jumpTo(
              index: _curList.length ~/ 2,
              alignment: alignment,
            ),
            child: Text('To center',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          TextButton(
            onPressed: () => itemScrollController.jumpTo(
              index: _curList.length,
              alignment: alignment,
            ),
            child: Text('To bottom',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _curList.add(index.toString());
                index++;
              });
              Future.delayed(Duration(milliseconds: 100), () {
                itemScrollController.jumpTo(
                  index: _curList.length,
                  alignment: alignment,
                );
              });
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: _Behavior(),
        child: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          itemCount: _curList.length,
          initialAlignment: 0.0,
          reverse: false,
          itemBuilder: (_, index) {
            final cur = index == _curList.length - 1 ? 'The last one' : _curList[index];
            return ListTile(
              title: Text(cur),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
class _Behavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return ClampingScrollPhysics();
  }
}

class MyHomePageReversed extends StatefulWidget {
  @override
  _MyHomePageReverseState createState() => _MyHomePageReverseState();
}

class _MyHomePageReverseState extends State<MyHomePageReversed> {
  final ItemScrollController itemScrollController = ItemScrollController();
  List<String> _curList = ['3', '2', '1', '0'];

  // List<String> _curList = List.generate(20, (index) => (20 - index).toString());
  int index = 4;
  final double alignment = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () => itemScrollController.jumpTo(
              index: _curList.length,
              alignment: alignment,
            ),
            child: Text('To top',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          TextButton(
            onPressed: () => itemScrollController.jumpTo(
              index: _curList.length ~/ 2,
              alignment: alignment,
            ),
            child: Text('To center',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          TextButton(
            onPressed: () => itemScrollController.jumpTo(
              index: 0,
              alignment: alignment,
            ),
            child: Text('To bottom',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _curList = [index.toString()]..addAll(_curList);
                index++;
              });
              Future.delayed(Duration(milliseconds: 100), () {
                itemScrollController.jumpTo(
                  index: 0,
                  alignment: alignment,
                );
              });
            },
          ),
        ],
      ),
      body: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemCount: _curList.length,
        physics: ClampingScrollPhysics(),
        reverse: true,
        initialAlignment: alignment,
        itemBuilder: (_, index) {
          final cur = index == 0 ? 'The last one' : _curList[index];
          return ListTile(
            title: Text(cur),
            onTap: () {},
          );
        },
      ),
    );
  }
}