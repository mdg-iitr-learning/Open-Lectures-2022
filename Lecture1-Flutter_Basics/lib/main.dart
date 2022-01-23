import 'package:flutter/material.dart';
import 'package:flutter_lecture1_b25/welcome_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int selectedIndex = 0;
  bool initialState = true;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 8000),
      () {
        setState(
          () {
            initialState = false;
          },
        );
      },
    );
    return initialState == true
        ? const Scaffold(
            body: Center(
              child: WelcomeWidget(),
            ),
          )
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.pink,
              currentIndex: selectedIndex,
              onTap: (int index) => setState(() {
                selectedIndex = index;
              }),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.network(
                      'https://res.cloudinary.com/nitishk72/image/upload/v1586796259/nstack_in/courses/flutter/flutter-banner.png',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Button has been pressed ',
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        TextSpan(
                            text: 'following number of times',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                const snackBar = SnackBar(
                  content: Text('Counter Incremented once'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(
                  () {
                    _counter++;
                  },
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
  }
}
