import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class WheelSelectedPage extends StatefulWidget {
  WheelSelectedPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WheelSelectedPageState createState() => _WheelSelectedPageState();
}

class _WheelSelectedPageState extends State<WheelSelectedPage> {
  int itemCount = 100;
  int selected = 50;
  FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 50);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
                color: Colors.grey[200],
                borderRadius:  BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0))),
            padding: EdgeInsets.all(kDefaultPadding/2),
            child: Row(
              children: [
                Text('Select Page',style: TEXT_STYLE_PRIMARY,),
                Spacer(),
                ElevatedButton(onPressed: (){}, child: Text('Done'))
              ],
            ),
          ),
          Container(
            height: 130,
            child: RotatedBox(
                quarterTurns: -1,
                child: ListWheelScrollView(
                  magnification: 6.0,
                  onSelectedItemChanged: (x) {
                    setState(() {
                      selected = x;
                    });
                  },
                  controller: _scrollController,
                  itemExtent: 60,

                  children: List.generate(
                      itemCount,
                      (x) => RotatedBox(
                          quarterTurns: 1,
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              width: x == selected ? 60 : 50,
                              height: x == selected ? 60 : 50,
                              child: Text(
                                '$x',
                                style: TextStyle(
                                    color: x == selected
                                        ? Colors.blue
                                        : Colors.grey,
                                    fontSize: x == selected ? 28 : 20,
                                    fontWeight: FontWeight.w600),
                              )))),
                )),
          ),

        ],
      ),
    );
  }
}
