import 'package:flutter/material.dart';
import 'home.dart';

@visibleForTesting
enum Location {
  Seoul,
  Busan,
  Daegu
}
enum Room{
  Single,
  Double,
  Family
}

typedef SectionBodyBuilder<T> = Widget Function(Section<T> item);
typedef ValueToString<T> = String Function(T value);

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
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

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
                style: textTheme.body1.copyWith(fontSize: 15.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: _crossFade(
              Text(value, style: textTheme.caption.copyWith(fontSize: 15.0)),
              Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),
              showHint,
            ),
          ),
        ),
      ],
    );
  }
}

class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody({
    this.margin = EdgeInsets.zero,
    this.child,
    this.onSave,
    this.onCancel,
  });

  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 24.0,
          ) - margin,
          child: Center(
            child: DefaultTextStyle(
              style: textTheme.caption.copyWith(fontSize: 15.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class Section<T> {
  Section({
    this.name,
    this.value,
    this.hint,
    this.builder,
    this.valueToString,
  }) : textController = TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final SectionBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
        name: name,
        value: valueToString(value),
        hint: hint,
        showHint: isExpanded,
      );
    };
  }

  Widget build() => builder(this);
}

class SearchPage extends StatefulWidget {
  static const String routeName = '/material/expansion_panels';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Section<dynamic>> _sections;

  @override
  void initState() {
    super.initState();

    _sections = <Section<dynamic>>[
      
      Section<Location>(
        name: 'Location',
        value: Location.Seoul,
        hint: 'Select location',
        valueToString: (Location location) => location.toString().split('.')[1],
        builder: (Section<Location> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }
          return Form(
            child: Builder(
              builder: (BuildContext context) {
                return CollapsibleBody(
                  onSave: () { Form.of(context).save(); close(); },
                  onCancel: () { Form.of(context).reset(); close(); },
                  child: FormField<Location>(
                    initialValue: item.value,
                    onSaved: (Location result) { item.value = result; },
                    builder: (FormFieldState<Location> field) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                          children: [
                            Radio<Location>(
                              value: Location.Seoul,
                              groupValue: field.value,
                              onChanged: field.didChange,
                            ),
                            Text('Seoul')
                            ],
                          ),
                          Row(
                          children: [
                            Radio<Location>(
                              value: Location.Busan,
                              groupValue: field.value,
                              onChanged: field.didChange,
                            ),
                            Text('Busan')
                            ],
                          ),
                          Row(
                          children: [
                            Radio<Location>(
                              value: Location.Daegu,
                              groupValue: field.value,
                              onChanged: field.didChange,
                            ),
                            Text('Daegu')
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            ),
          );
        },
      ),
      Section<Room>(
        name: 'Room',
        value: Room.Single,
        hint: 'Select Room',
        valueToString: (Room room) => room.toString().split('.')[1],
        builder: (Section<Room> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }
          return Form(
            child: Builder(
              builder: (BuildContext context) {
                return CollapsibleBody(
                  onSave: () { Form.of(context).save(); close(); },
                  onCancel: () { Form.of(context).reset(); close(); },
                  child: FormField<Room>(
                    initialValue: item.value,
                    onSaved: (Room result) { item.value = result; },
                    builder: (FormFieldState<Room> field) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                          children: [
                            Radio<Room>(
                              value: Room.Single,
                              groupValue: field.value,
                              onChanged: field.didChange,
                            ),
                            Text('Single')
                            ],
                          ),
                          Row(
                          children: [
                            Radio<Room>(
                              value: Room.Double,
                              groupValue: field.value,
                              onChanged: field.didChange,
                            ),
                            Text('Double')
                            ],
                          ),
                          Row(
                          children: [
                            Radio<Room>(
                              value: Room.Family,
                              groupValue: field.value,
                              onChanged: field.didChange,
                            ),
                            Text('Family')
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            ),
          );
        },
      ),
      Section<int>(
        name: 'Class',
        value: 3,
        hint: 'select hotel classes',
        valueToString: (int amount) => amount.toString(),
        builder: (Section<int> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }

          return Form(
            child: Builder(
              builder: (BuildContext context) {
                return CollapsibleBody(
                  onSave: () { Form.of(context).save(); close(); },
                  onCancel: () { Form.of(context).reset(); close(); },
                  child: FormField<int>(
                    initialValue: item.value,
                    onSaved: (int value) { item.value = value; },
                    builder: (FormFieldState<int> field) {
                      return Column( //return checkbox list
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                          children: [
                            CheckboxListTile(
                              title: buildStar(context, 1, true),
                              value: false,
                              activeColor: Colors.blue,
                              onChanged: (bool val){
                                item.value = 1;
                              },
                            ),
                            ],
                          ),
                          Row(
                          children: [
                            CheckboxListTile(
                              title: buildStar(context, 2, true),
                              value: false,
                              activeColor: Colors.blue,
                              onChanged: (bool val){
                                item.value = 2;
                              },
                            ),
                            ],
                          ),
                          Row(
                          children: [
                            CheckboxListTile(
                              title: buildStar(context, 3, true),
                              value: false,
                              activeColor: Colors.blue,
                              onChanged: (bool val){
                                item.value = 3;
                              },
                            ),
                            ],
                          ),
                          Row(
                          children: [
                            CheckboxListTile(
                              title: buildStar(context, 4, true),
                              value: false,
                              activeColor: Colors.blue,
                             onChanged: (bool val){
                                item.value = 4;
                              },
                            ),
                            ],
                          ),
                          Row(
                          children: [
                            CheckboxListTile(
                              title: buildStar(context, 5, true),
                              value: false,
                              activeColor: Colors.blue,
                              onChanged: (bool val){
                                item.value = 5;
                              },
                            ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            ),
          );
        },
      ),

      Section<double>(
        name: 'Fee',
        value: 75.0,
        hint: 'select fee',
        valueToString: (double amount) => '${amount.round()}',
        builder: (Section<double> item) {
          void close() {
            setState(() {
              item.isExpanded = false;
            });
          }

          return Form(
            child: Builder(
              builder: (BuildContext context) {
                return CollapsibleBody(
                  onSave: () { Form.of(context).save(); close(); },
                  onCancel: () { Form.of(context).reset(); close(); },
                  child: FormField<double>(
                    initialValue: item.value,
                    onSaved: (double value) { item.value = value; },
                    builder: (FormFieldState<double> field) {
                      return Slider(
                        min: 0.0,
                        max: 150.0,
                        activeColor: Colors.blue,
                        label: '${field.value.round()}',
                        value: field.value,
                        onChanged: field.didChange,
                      );
                    },
                  ),
                );
              }
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search',
          style: TextStyle(color: Colors.white, fontSize: 18.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _sections[index].isExpanded = !isExpanded;
                });
              },
              children: _sections.map<ExpansionPanel>((Section<dynamic> item) {
                return ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: item.headerBuilder,
                  body: item.build(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}