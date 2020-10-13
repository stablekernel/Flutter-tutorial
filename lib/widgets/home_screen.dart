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
    RevealScreen(text: new Text('Palm'),
      image: new Image.asset('assets/images/plant1.jpeg')),
    RevealScreen(text: new Text('Calathea'),
        image: new Image.asset('assets/images/plant2.jpeg')),
    RevealScreen(text: new Text('Succulents'),
        image: new Image.asset('assets/images/plant3.jpeg')),
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
                'assets/images/rake.png',
                width: 40,
                height: 40,
                ),
                title: Text( "Plants",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset( 'assets/images/shovel.png',
                  width: 40,
                  height: 40,
                ),
                title: Text( "Plants",
                  style: TextStyle(color: Colors.white),
                ),
                ),
              BottomNavigationBarItem(
                icon: Image.asset( 'assets/images/can.png',
                  width: 40,
                  height: 40,
                ),
                title: Text( "Plants",
                  style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
        ),
        )
      )
    );
  }
}