import 'package:flutter/material.dart';
import 'package:tutorial/widgets/reveal_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentTab = 0;
  final List<Widget> _tabChildren = [
    RevealScreen(text: new Text('Fig Tree'),
      image: new Image.asset('assets/figTree.png')),
    RevealScreen(text: new Text('Eucalyptus'),
        image: new Image.asset('assets/eucalyptus.png')),
    RevealScreen(text: new Text('Cactus'),
        image: new Image.asset('assets/cactus.png')),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
       body: SafeArea(
           child:  _tabChildren[_currentTab],
       ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
        primaryColor: Colors.white,
        canvasColor: Colors.green[300],
      ),
        child: Container(
          decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)]),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentTab,
              onTap: onTabTapped,
              items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                'assets/icon-fig.png',
                width: 40,
                height: 40,
                ),
                title: Text( "Fig Tree",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset( 'assets/icon-eucalyptus.png',
                  width: 40,
                  height: 40,
                ),
                title: Text( "Eucalyptus",
                  style: TextStyle(color: Colors.black),
                ),
                ),
              BottomNavigationBarItem(
                icon: Image.asset( 'assets/icon-cactus.png',
                  width: 40,
                  height: 40,
                ),
                title: Text( "Cactus",
                  style: TextStyle(color: Colors.black),
                  ),
                ),
            ],
        ),
        )
      )
    );
  }
}