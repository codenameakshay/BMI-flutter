import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<DynamicTheme>(
      create: (_) => DynamicTheme(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return MaterialApp(
      title: 'BMI Calculator',
      theme: themeProvider.getDarkMode() ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return Scaffold(
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo.jfif',
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 60, 140, 231),
                    Color.fromARGB(255, 0, 234, 255),
                  ],
                ),
              ),
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              title: Center(
                child: Text('CodeNameAKshay'),
              ),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            Divider(
              height: 2.0,
            ),
            Builder(
              builder: (context) => ListTile(
                title: Text('Toggle Dark mode'),
                leading: Icon(Icons.brightness_4),
                onTap: () {
                  setState(() {
                    themeProvider.changeDarkMode(!themeProvider.isDarkMode);
                  });
                  Navigator.pop(context);
                },
                trailing: CupertinoSwitch(
                  value: themeProvider.getDarkMode(),
                  onChanged: (value) {
                    setState(() {
                      themeProvider.changeDarkMode(value);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Divider(
              height: 2.0,
            ),
            Builder(
              builder: (context) => ListTile(
                title: Text('Nothing here'),
                leading: Icon(Icons.access_time),
                onTap: () {
                  // changeIsBinary();
                  Navigator.pop(context);
                },
              ),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: MainScreen(),
      // isBinary ? BinaryClock() : DigitalClock(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxHeight > constraints.maxWidth
              ? MainScreenP(constraints.maxHeight, constraints.maxWidth)
              : MainScreenL(constraints.maxHeight, constraints.maxWidth);
        },
      ),
    );
  }
}

class MainScreenP extends StatefulWidget {
  var height;
  var width;
  MainScreenP(this.height, this.width);
  @override
  _MainScreenPState createState() => _MainScreenPState(this.height, this.width);
}

class _MainScreenPState extends State<MainScreenP> {
  var genderValue;
  var height;
  var width;
  var weight;
  var age;
  var _length;
  var bmi;

  @override
  void initState() {
    super.initState();
    genderValue = 0;
    weight = 45;
    age = 20;
    _length = 185.0;
    bmi = 0.0;
  }

  void changeGenderValue(int val) {
    setState(
      () {
        genderValue = val;
      },
    );
  }

  void increaseWeight() {
    setState(() {
      weight++;
      print(weight);
    });
  }

  void decreaseWeight() {
    setState(() {
      if (weight > 0) {
        weight--;
        print(weight);
      } else {
        weight = 0;
      }
    });
  }

  void increaseAge() {
    setState(() {
      age++;
      print(age);
    });
  }

  void decreaseAge() {
    setState(() {
      if (age > 0) {
        age--;
        print(age);
      } else {
        age = 0;
      }
    });
  }

  void calculateBMI() {
    bmi = weight / (_length * _length);
  }

  _MainScreenPState(this.height, this.width);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return Column(
      children: <Widget>[
        Container(
          width: width * 0.98,
          height: height * 0.17,
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(
              vertical: height * 0.03,
              horizontal: width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: genderValue,
                      onChanged: (value) {
                        changeGenderValue(value);
                        print('Male');
                      },
                    ),
                    Text('Male',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 30,
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: genderValue,
                      onChanged: (value) {
                        changeGenderValue(value);
                        print('Female');
                      },
                    ),
                    Text(
                      'Female',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width * 0.495,
              height: height * 0.35,
              child: Card(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.05,
                ),
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Text(
                        'Weight',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Text(
                        '$weight Kg',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              decreaseWeight();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ClipOval(
                                child: Container(
                                  color: themeProvider.isDarkMode
                                      ? Colors.tealAccent[400]
                                      : Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(
                                      child: Icon(Icons.remove,
                                          size: width * 0.08)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              increaseWeight();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ClipOval(
                                child: Container(
                                  color: themeProvider.isDarkMode
                                      ? Colors.tealAccent[400]
                                      : Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    size: width * 0.08,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: width * 0.495,
              height: height * 0.35,
              child: Card(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.05,
                ),
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Text(
                        'Age',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Text(
                        '$age ' + ((age > 1) ? 'years' : 'year'),
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              decreaseAge();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ClipOval(
                                child: Container(
                                  color: themeProvider.isDarkMode
                                      ? Colors.tealAccent[400]
                                      : Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(
                                      child: Icon(
                                    Icons.remove,
                                    size: width * 0.08,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              increaseAge();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ClipOval(
                                child: Container(
                                  color: themeProvider.isDarkMode
                                      ? Colors.tealAccent[400]
                                      : Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    size: width * 0.08,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: width * 0.98,
          height: height * 0.3,
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(
              vertical: height * 0.03,
              horizontal: width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Height :',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        ' $_length cm',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: themeProvider.isDarkMode
                        ? Colors.teal[700]
                        : Colors.blue[700],
                    inactiveTrackColor: themeProvider.isDarkMode
                        ? Colors.teal[100]
                        : Colors.blue[100],
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    thumbColor: themeProvider.isDarkMode
                        ? Colors.tealAccent
                        : Colors.blueAccent,
                    overlayColor: themeProvider.isDarkMode
                        ? Colors.teal.withAlpha(32)
                        : Colors.blue.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    activeTickMarkColor: themeProvider.isDarkMode
                        ? Colors.teal[700]
                        : Colors.blue[700],
                    inactiveTickMarkColor: themeProvider.isDarkMode
                        ? Colors.teal[100]
                        : Colors.blue[100],
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: themeProvider.isDarkMode
                        ? Colors.tealAccent
                        : Colors.blueAccent,
                    valueIndicatorTextStyle: TextStyle(
                      fontFamily: 'Raleway',
                      color: themeProvider.isDarkMode
                          ? Colors.black38
                          : Colors.white70,
                    ),
                  ),
                  child: Slider(
                    value: _length,
                    min: 60,
                    max: 310,
                    label: '$_length',
                    divisions: 500,
                    onChanged: (value) {
                      setState(
                        () {
                          _length = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: width * 0.88,
          height: height * 0.15,
          child: Card(
            elevation: 0,
            child: CupertinoButton(
              color: Color.fromARGB(255, 73, 232, 108),
              onPressed: () {},
              child: Text(
                'Calculate',
                style: TextStyle(fontFamily: 'IBM Plex Sans', fontSize: 40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MainScreenL extends StatefulWidget {
  var height;
  var width;
  MainScreenL(this.height, this.width);
  @override
  _MainScreenLState createState() => _MainScreenLState(this.height, this.width);
}

class _MainScreenLState extends State<MainScreenL> {
  var genderValue;
  var height;
  var width;
  var weight;
  var age;
  var _length;

  @override
  void initState() {
    super.initState();
    genderValue = 0;
    weight = 45;
    age = 20;
    _length = 185.0;
  }

  void changeGenderValue(int val) {
    setState(
      () {
        genderValue = val;
      },
    );
  }

  void increaseWeight() {
    setState(() {
      weight++;
      print(weight);
    });
  }

  void decreaseWeight() {
    setState(() {
      if (weight > 0) {
        weight--;
        print(weight);
      } else {
        weight = 0;
      }
    });
  }

  void increaseAge() {
    setState(() {
      age++;
      print(age);
    });
  }

  void decreaseAge() {
    setState(() {
      if (age > 0) {
        age--;
        print(age);
      } else {
        age = 0;
      }
    });
  }

  _MainScreenLState(this.height, this.width);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return Row(
      children: <Widget>[
        Container(
          height: height * 0.98,
          width: width * 0.5,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.04,
                  horizontal: width * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: genderValue,
                          onChanged: (value) {
                            changeGenderValue(value);
                            print('Male');
                          },
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: genderValue,
                          onChanged: (value) {
                            changeGenderValue(value);
                            print('Female');
                          },
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width * 0.25,
                    height: height * 0.68,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.005,
                        horizontal: width * 0.02,
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              '$weight Kg',
                              style: TextStyle(
                                fontFamily: 'IBM Plex Sans',
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.vibrate();
                                    decreaseWeight();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ClipOval(
                                      child: Container(
                                        color: themeProvider.isDarkMode
                                            ? Colors.tealAccent[400]
                                            : Colors.blue,
                                        height: height *
                                            0.1, // height of the button
                                        width:
                                            height * 0.1, // width of the button
                                        child: Center(
                                            child: Icon(Icons.remove,
                                                size: height * 0.08)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.vibrate();
                                    increaseWeight();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ClipOval(
                                      child: Container(
                                        color: themeProvider.isDarkMode
                                            ? Colors.tealAccent[400]
                                            : Colors.blue,
                                        height: height *
                                            0.1, // height of the button
                                        width:
                                            height * 0.1, // width of the button
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          size: height * 0.08,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.68,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.005,
                        horizontal: width * 0.02,
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: Text(
                              'Age',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              '$age ' + ((age > 1) ? 'years' : 'year'),
                              style: TextStyle(
                                fontFamily: 'IBM Plex Sans',
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.vibrate();
                                    decreaseAge();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ClipOval(
                                      child: Container(
                                        color: themeProvider.isDarkMode
                                            ? Colors.tealAccent[400]
                                            : Colors.blue,
                                        height: height *
                                            0.1, // height of the button
                                        width:
                                            height * 0.1, // width of the button
                                        child: Center(
                                            child: Icon(
                                          Icons.remove,
                                          size: height * 0.08,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.vibrate();
                                    increaseAge();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ClipOval(
                                      child: Container(
                                        color: themeProvider.isDarkMode
                                            ? Colors.tealAccent[400]
                                            : Colors.blue,
                                        height: height *
                                            0.1, // height of the button
                                        width:
                                            height * 0.1, // width of the button
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          size: height * 0.08,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.94,
          width: width * 0.5,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.03,
                  horizontal: width * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Height :',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            ' $_length cm',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: themeProvider.isDarkMode
                            ? Colors.teal[700]
                            : Colors.blue[700],
                        inactiveTrackColor: themeProvider.isDarkMode
                            ? Colors.teal[100]
                            : Colors.blue[100],
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4.0,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        thumbColor: themeProvider.isDarkMode
                            ? Colors.tealAccent
                            : Colors.blueAccent,
                        overlayColor: themeProvider.isDarkMode
                            ? Colors.teal.withAlpha(32)
                            : Colors.blue.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: themeProvider.isDarkMode
                            ? Colors.teal[700]
                            : Colors.blue[700],
                        inactiveTickMarkColor: themeProvider.isDarkMode
                            ? Colors.teal[100]
                            : Colors.blue[100],
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: themeProvider.isDarkMode
                            ? Colors.tealAccent
                            : Colors.blueAccent,
                        valueIndicatorTextStyle: TextStyle(
                          fontFamily: 'Raleway',
                          color: themeProvider.isDarkMode
                              ? Colors.black38
                              : Colors.white70,
                        ),
                      ),
                      child: Slider(
                        value: _length,
                        min: 60,
                        max: 310,
                        label: '$_length',
                        divisions: 500,
                        onChanged: (value) {
                          setState(
                            () {
                              _length = value;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.43,
                width: width * 0.41,
                child: Card(
                  elevation: 0,
                  child: CupertinoButton(
                    color: Color.fromARGB(255, 73, 232, 108),
                    onPressed: () {},
                    child: Text(
                      'Calculate',
                      style:
                          TextStyle(fontFamily: 'IBM Plex Sans', fontSize: 40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
