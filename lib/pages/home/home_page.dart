import 'package:flutter/material.dart';
import 'package:nubank_flutter/pages/home/widgets/bottom_menu.dart';
import 'package:nubank_flutter/pages/home/widgets/menu_app.dart';
import 'package:nubank_flutter/pages/home/widgets/my_app_bar.dart';
import 'package:nubank_flutter/pages/home/widgets/my_dots_app.dart';
import 'package:nubank_flutter/pages/home/widgets/page_view_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _showMenu;
  int _currentIndex;
  double _yPosition ;

  @override
  void initState(){
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeigh = MediaQuery.of(context).size.height;
    if(_yPosition == null){
         _yPosition = _screenHeigh * .24;

    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 47, 116, 1),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
                _yPosition =  _showMenu ? _screenHeigh * .75 :_screenHeigh * .24;
              });
            },
          ),
          MenuApp(
            top:_screenHeigh * .20,
            showMenu: _showMenu,
          ),
          BottomMenu(showMenu: _showMenu,),
          MyDotsApp(
            showMenu: _showMenu,
            top:_screenHeigh * .70,
            currentIndex: _currentIndex,
          ),
          PageViewApp(
           showMenu: _showMenu,
           top:_yPosition,
           onChanged: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          onPanUpdate: (details){
            double positionBottomLimit = _screenHeigh * .75;
            double positionTopLimit = _screenHeigh * .24;
            double midlePosition = positionBottomLimit - positionTopLimit ;
            midlePosition = midlePosition /2;
            setState(() {
              _yPosition += details.delta.dy;

              _yPosition = _yPosition < positionTopLimit
                ? positionTopLimit 
                : _yPosition;

               _yPosition = _yPosition > positionBottomLimit
                ? positionBottomLimit
                : _yPosition;
                
               if(_yPosition != positionBottomLimit && details.delta.dy > 0){
                 _yPosition = _yPosition > positionTopLimit + midlePosition -50
                 ? positionBottomLimit
                 :_yPosition;
               } 

                  if(_yPosition != positionTopLimit && details.delta.dy < 0){
                 _yPosition = _yPosition < positionBottomLimit - midlePosition 
                 ? positionTopLimit
                 :_yPosition;
               } 

                if(_yPosition == positionBottomLimit){
                  _showMenu = true;
                }else if(_yPosition == positionTopLimit){
                  _showMenu = false;
                }
            });
          },
         ),
          
        
        
        ]
      ),
    );
  }
}