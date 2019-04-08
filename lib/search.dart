import 'package:flutter/material.dart';
import 'home.dart';

enum Location{
  Seoul,
  Busan,
  Daegu
}
enum Room{
  Single,
  Double,
  Family
}

typedef SectionBodyBuilder = Widget Function(Section item);

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint,
  });

  final String name;
  final String value;
  final String hint;
  final bool showHint;

  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                name,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: Text(hint, style: TextStyle(fontSize: 13.0)),
            /* _crossFade(
              Text(value, style: textTheme.caption.copyWith(fontSize: 15.0)),
              Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),
              showHint,
            ), */
          ),
        ),
      ],
    );
  }
}

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class Section {
  bool isExpanded;
  final DualHeaderWithHint header;
  final Widget body;
  final String value;
  Section({Key key, @required this.isExpanded, @required this.header, @required this.body, @required this.value});
}

class _SearchPageState extends State<SearchPage> {
  int _location;
  int _room;
  List<bool> _checker = [false, false, false, false, false,];
  void setlocation(int num){
    print('Pressed');
    setState((){
      _location = num;
      print("Location: " + _location.toString());
    });
  }
  void setroom(int num){
    print('Pressed');
    setState((){
      _room = num;
      print("Room: " + _room.toString());
    });
  }
  // TODO: Section should be implemented as a Widget!!!!
  Widget collapsibleBody(Section item){
     return Center(
       child: Container(
         alignment: Alignment.center,
         child: item.body,
       )
     );
  }

  List<Section> items;
  @override
  void initState(){
    super.initState();

    items = <Section>[
      Section(
        isExpanded: false,
        header: DualHeaderWithHint(
          name: 'Location',
          hint: 'select location',
          showHint: false,
        ),
        body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _location,
                        activeColor: Colors.blue,
                        onChanged: (int num) => setlocation(num), 
                      ),
                      Text('Seoul')
                      ],
                    ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _location,
                        activeColor: Colors.blue,
                        onChanged: (int num) => setlocation(num),
                      ),
                      Text('Busan')
                      ],
                    ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _location,
                        activeColor: Colors.blue,
                        onChanged: (int num) => setlocation(num),
                      ),
                      Text('Daegu')
                      ],
                  ),
                ],
              ),
        ),
        Section(
        isExpanded: false,
        header: DualHeaderWithHint(
          name: 'Room',
          hint: 'select room',
          showHint: false,
        ),
        body:Center(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _room,
                            onChanged: (int num) => setroom(num), 
                          ),
                          Text('Single')
                          ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _room,
                            onChanged: (int num) => setroom(num),
                          ),
                          Text('Double')
                          ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _room,
                            onChanged: (int num) => setroom(num),
                          ),
                          Text('Family')
                          ],
                      ),
                    ],
              ),
          ),
        ),
        ),
        Section(
        isExpanded: false,
        header: DualHeaderWithHint(
          name: 'Class',
          hint: 'select hotel classes',
          showHint: false,
        ),
        body:Center(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Checkbox(
                            value: _checker[0],
                            onChanged: (_check){
                              _checker[0] = _check;
                            }, 
                          ),
                          buildStar(context, 1, false),
                          ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _checker[1],
                            onChanged: (_check){
                              _checker[1] = _check;
                            }, 
                          ),
                          buildStar(context, 2, false),
                          ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _checker[2],
                            onChanged: (_check){
                              _checker[2] = _check;
                            }, 
                          ),
                          buildStar(context, 3, false),
                          ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _checker[3],
                            onChanged: (_check){
                              _checker[3] = _check;
                            }, 
                          ),
                          buildStar(context, 4, false),
                          ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _checker[4],
                            onChanged: (_check){
                              _checker[4] = _check;
                            }, 
                          ),
                          buildStar(context, 5, false),
                          ],
                      ),
                    ],
              ),
          ),
        ),
        ),
  ];
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0),
            ),
          centerTitle: true,
        ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: ExpansionPanelList(
              expansionCallback: (index, isExpanded){
                setState((){
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((item){
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded){
                    return ListTile(
                      title: item.header,
                    );
                  },
                  isExpanded: item.isExpanded,
                  body: collapsibleBody(item),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}