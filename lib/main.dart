import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './theme_provider.dart';
import 'package:provider/provider.dart';

var weightValue = TextEditingController();
var ageValue = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    genderValue = 0;
    weight = 45;
    age = 20;
    weightValue.text = weight.toString();
    ageValue.text = age.toString();
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
      weightValue.text = weight.toString();
      print(weight);
    });
  }

  void decreaseWeight() {
    setState(() {
      weight--;
      weightValue.text = weight.toString();
      print(weight);
    });
  }

  void increaseAge() {
    setState(() {
      age++;
      ageValue.text = age.toString();
      print(age);
    });
  }

  void decreaseAge() {
    setState(() {
      age--;
      ageValue.text = age.toString();
      print(age);
    });
  }

  _MainScreenPState(this.height, this.width);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(width: width*0.98,height: height*0.17,
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
                    Text('Male'),
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
                    Text('Female'),
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
                  children: <Widget>[Padding(
                    padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                    child: Text('Weight (in Kg)'),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: TextField(
                        enabled: false,
                        controller: weightValue,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: weightValue.text,
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
                                  color: Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(child: Text('-')),
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
                                  color: Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(child: Text('+')),
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
                  children: <Widget>[Padding(
                    padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                    child: Text('Age (in Years)'),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: TextField(
                        enabled: false,
                        controller: ageValue,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: ageValue.text,
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
                                  color: Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(child: Text('-')),
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
                                  color: Colors.blue,
                                  height: width * 0.1, // height of the button
                                  width: width * 0.1, // width of the button
                                  child: Center(child: Text('+')),
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

  @override
  void initState() {
    super.initState();
    genderValue = 0;
  }

  void changeGenderValue(int val) {
    setState(
      () {
        genderValue = val;
      },
    );
  }

  _MainScreenLState(this.height, this.width);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(
            vertical: height * 0.04,
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
                  Text('Male'),
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
                  Text('Female'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
