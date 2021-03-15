import 'package:flutter/material.dart';
import 'package:tutorial/widgets/reveal_screen.dart';
import 'package:tutorial/utility/colors.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentTab = 0;
  final _selectedBgColor = AppColors.colorHighlightWhite;
  final _unselectedBgColor = AppColors.colorLightGrey;
  
  final List<Widget> _tabChildren = [
    RevealScreen(title: new Text('Fiddle Leaf Fig', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
      overlayImage: new Image.asset('assets/blur-fig.png'),
      image: new Image.asset('assets/figTree.png')),
    RevealScreen(title: new Text('Eucalyptus', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
        overlayImage: new Image.asset('assets/blur-eucalyptus.png'),
        image: new Image.asset('assets/eucalyptus.png')),
    RevealScreen(title: new Text('Cactus', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
        overlayImage: new Image.asset('assets/blur-cactus.png'),
        image: new Image.asset('assets/cactus.png')),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  Color _getBgColor(int index) =>
      _currentTab == index ? Colors.deepOrange : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
           child:  _tabChildren[_currentTab],
       ),
      bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentTab,
              onTap: onTabTapped,
              backgroundColor: AppColors.colorLightGrey,
              items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/icon-fig.png',
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
        );
  }
}