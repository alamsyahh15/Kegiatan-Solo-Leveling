import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

// int mainCount = 0;
// Timer timerQ;
Stream<int> subsStream;
StreamSubscription mainStream;

abstract class CounterService {
  StreamController<int> _notifChatController =
      StreamController<int>.broadcast();
  Stream<int> get chatServiceStream => _notifChatController.stream;

  void addToStream(int count) {
    _notifChatController.add(count);
    subsStream = _notifChatController.stream;
    // mainCount = count;
  }

  onListen({Function(int data) onEvent}) {
    mainStream = subsStream.listen((event) {
      onEvent(event);
    });
    // timerQ = Timer.periodic(Duration(seconds: 1), (timer) {
    //   onEvent(mainCount);
    //   log("Stream Listen $mainCount");
    // });
  }

  disposeStream() {
    mainStream.cancel();
    // timerQ.cancel();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with CounterService {
  Timer timer;
  int count = 0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count = timer.tick;
        addToStream(count);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose 1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondPage(service: this)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final CounterService service;

  const SecondPage({Key key, this.service}) : super(key: key);
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with CounterService {
  ScrollController scrollController = ScrollController();
  int length = 0;

  void scrollBottom() {
    setState(() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    onListen(
      onEvent: (data) {
        setState(() => length = data);
        log("Data $data");
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mainStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Sample "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SecondPage',
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return Text(
                      "Data $index",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
