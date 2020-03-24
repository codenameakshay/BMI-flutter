import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
              ? MainScreenP()
              : MainScreenL();
        },
      ),
    );
  }
}

class MainScreenP extends StatefulWidget {
  @override
  _MainScreenPState createState() => _MainScreenPState();
}

class _MainScreenPState extends State<MainScreenP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Radio();
        },
      ),
    );
  }
}

class MainScreenL extends StatefulWidget {
  @override
  _MainScreenLState createState() => _MainScreenLState();
}

class _MainScreenLState extends State<MainScreenL> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Text('Width greater Than Height');
        },
      ),
    );
  }
}
