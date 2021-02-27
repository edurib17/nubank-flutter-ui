import 'package:flutter/material.dart';
import 'package:nubank_flutter/pages/home/widgets/first_card.dart';
import 'package:nubank_flutter/pages/home/widgets/secont_card.dart';
import 'package:nubank_flutter/pages/home/widgets/third_card.dart';

import 'card_app.dart';

class PageViewApp extends StatelessWidget {

  final double top;
  final ValueChanged<int> onChanged;
  final GestureDragUpdateCallback onPanUpdate;
  final bool showMenu;

  const PageViewApp({Key key, this.top, this.onChanged, this.onPanUpdate, this.showMenu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  AnimatedPositioned(
             duration: Duration(milliseconds: 250),
             curve: Curves.easeOut,
             top: top, 
             height:MediaQuery.of(context).size.height* .45,
             left: 0,
             right: 0,
          // width: MediaQuery.of(context).size.width,
             child:GestureDetector(
               onPanUpdate: onPanUpdate,
                            child: PageView(  
                 onPageChanged: onChanged,
                 physics: showMenu ? NeverScrollableScrollPhysics(): BouncingScrollPhysics(),
                  children: <Widget>[
                  CardApp(
                    child: FirstCard(),
                  ),
                  CardApp(
                    child: SecondCard(),
                  ),
                  CardApp(),
            ],),
             ),
     );
  }
}