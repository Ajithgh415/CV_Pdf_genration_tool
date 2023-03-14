import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_task/CV%20Generate.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'AppData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'India Mint Stamp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: CvGeneratorApp(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.bounceInOut,
    );

    animationController!.forward();
    startTime();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Center(
            child: ScaleTransition(
          scale: animation!,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              // image: DecorationImage(
              //   invertColors: false,
              //   image: AssetImage(
              //     'assets/bg.png',
              //   ),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: SafeArea(
              child: Center(
                child: ScaleTransition(
                  scale: animation!,
                  child: Image.asset(
                    'assets/logo.jpg',
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 150,
                  ),
                ),
              ),
            ),
          ),
        )),
        bottomNavigationBar: Container(
            child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text(
                "Powered By",
                style: TextStyle(
                    letterSpacing: .6,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text('Lokith Philately',
                style: GoogleFonts.lora(
                    color: Color.fromARGB(255, 183, 12, 69),
                    fontWeight: FontWeight.w700)),
            // child: Image(
            //     width: 220,
            //     height: 50,
            //     image: AssetImage('assets/images/ups.png'),
            //     fit: BoxFit.fitHeight),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 60.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Copyright © 2023 India. All rights reserved",
                    style: TextStyle(
                        letterSpacing: .6,
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ])));
    // Container(
    //   height: MediaQuery.of(context).size.height * 0.50,
    //   child: Padding(
    //     padding: const EdgeInsets.all(5.0),
    //     child: new Image.asset(
    //       'assets/images/splash.png',
    //       fit: BoxFit.contain,
    //     ),
    //   ),
    // ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = 'https://www.indiamintstamp.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 183, 12, 69),
        // backgroundColor: Colors.white,
        title: Text(
          'Lokith Philately',
          style: GoogleFonts.lora(),
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   List<String> filter = ["Select Role", "Executive", "Manager"];
//   FocusNode _focusNode = new FocusNode();
//   String _selectedRole = "Select Role";
//   TextEditingController _fNameController = TextEditingController();
//   TextEditingController _lNameController = TextEditingController();
//   TextEditingController _oFEmailController = TextEditingController();
//   TextEditingController _PEmailController = TextEditingController();
//   TextEditingController _mobileNoController = TextEditingController();
//   TextEditingController _alMobNoController = TextEditingController();
//   TextEditingController _waMobNocontroller = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _landmarkController = TextEditingController();
//   TextEditingController _cityController = TextEditingController();
//   TextEditingController _StateController = TextEditingController();
//   TextEditingController _pinCodeController = TextEditingController();
//   TextEditingController _CTCController = TextEditingController();
//   TextEditingController _bNameController = TextEditingController();
//   TextEditingController _bAcnoController = TextEditingController();
//   TextEditingController _bIfscController = TextEditingController();
//   TextEditingController _panController = TextEditingController();
//   TextEditingController _workLocController = TextEditingController();
//   TextEditingController _documentNameController = TextEditingController();

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   showUpdateDataAlert(
//     BuildContext context,
//   ) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, innerState) {
//             return AlertDialog(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     10.0,
//                   ),
//                 ),
//               ),
//               contentPadding: const EdgeInsets.all(15),
//               titlePadding: const EdgeInsets.all(0),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     Navigator.pop(context);
//                   //   },
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.all(8.0),
//                   //     child: Align(
//                   //         alignment: Alignment.topRight,
//                   //         child: Image(
//                   //           image: Svg('assets/img_close.svg'),
//                   //           height: 20,
//                   //           width: 20,
//                   //         )),
//                   //   ),
//                   // ),
//                   Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           "ADD EMPLOYEE",
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.info,
//                                 color: Colors.blue,
//                               ),
//                               Text(
//                                 "Please scroll down to add",
//                                 style: TextStyle(
//                                     fontSize: 14.0,
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               content: StatefulBuilder(builder: (context, innerState) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   width: double.infinity,
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             const Text("Role",
//                                 style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600)),
//                             const Text(" : ",
//                                 style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600)),
//                             SizedBox(
//                                 height: 50,
//                                 // width: double.infinity,
//                                 // decoration: BoxDecoration(
//                                 //   border: Border.all(color: Colors.grey),
//                                 //   borderRadius: BorderRadius.circular(5.0),
//                                 //   color: Colors.white,
//                                 // ),
//                                 child: DropdownButton(
//                                   value: _selectedRole,
//                                   focusNode: _focusNode,
//                                   items: filter.map((valueid) {
//                                     return DropdownMenuItem<String>(
//                                       enabled: true,
//                                       child: Text(valueid),
//                                       value: valueid!,
//                                     );
//                                   }).toList(),
//                                   onChanged: (newValue) {
//                                     innerState(() {
//                                       _selectedRole = newValue!;
//                                     });
//                                   },
//                                 )),
//                           ],
//                         ),
//                         AppData.row1(
//                             "FirstName", "First Name", _fNameController,
//                             ((value) {
//                           innerState(() {
//                             _fNameController.text = value;
//                           });
//                         })),
//                         AppData.row1("LastName", "Last Name", _lNameController,
//                             ((value) {
//                           innerState(() {
//                             _lNameController.text = value;
//                           });
//                         })),
//                         AppData.row1("Official Email", "Official Email ",
//                             _oFEmailController, ((value) {
//                           innerState(() {
//                             _oFEmailController.text = value;
//                           });
//                         })),
//                         AppData.row1("Personal Email", "Personal Email",
//                             _PEmailController, ((value) {
//                           innerState(() {
//                             _PEmailController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Mobile Number", "Mobile No", _mobileNoController,
//                             ((value) {
//                           innerState(() {
//                             _mobileNoController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Alternate Mobile Number",
//                             "Alternate Mobile No",
//                             _alMobNoController, ((value) {
//                           innerState(() {
//                             _alMobNoController.text = value;
//                           });
//                         })),
//                         AppData.row1("Whatsapp Mobile Number",
//                             "Whatsapp Mobile No", _waMobNocontroller, ((value) {
//                           innerState(() {
//                             _waMobNocontroller.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Password", "Password", _passwordController,
//                             ((value) {
//                           innerState(() {
//                             _passwordController.text = value;
//                           });
//                         })),
//                         AppData.row1("Confirm Password", "Confirm Password",
//                             _confirmPasswordController, ((value) {
//                           innerState(() {
//                             _confirmPasswordController.text = value;
//                           });
//                         })),
//                         AppData.row1("Address", "Address", _addressController,
//                             ((value) {
//                           innerState(() {
//                             _addressController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Landmark", "landmark", _landmarkController,
//                             ((value) {
//                           innerState(() {
//                             _landmarkController.text = value;
//                           });
//                         })),
//                         AppData.row1("City", "City", _cityController, ((value) {
//                           innerState(() {
//                             _cityController.text = value;
//                           });
//                         })),
//                         AppData.row1("State", "State", _StateController,
//                             ((value) {
//                           innerState(() {
//                             _StateController.text = value;
//                           });
//                         })),
//                         AppData.row1("Pincode", "Pincode", _pinCodeController,
//                             ((value) {
//                           innerState(() {
//                             _pinCodeController.text = value;
//                           });
//                         })),
//                         AppData.row1("CTC", "CTC", _CTCController, ((value) {
//                           innerState(() {
//                             _CTCController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Bank A/c No", "Bank A/C No", _bAcnoController,
//                             ((value) {
//                           innerState(() {
//                             _bAcnoController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Mobile Number", "Mobile No", _mobileNoController,
//                             ((value) {
//                           innerState(() {
//                             _mobileNoController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Mobile Number ", "Mobile No", _mobileNoController,
//                             ((value) {
//                           innerState(() {
//                             _mobileNoController.text = value;
//                           });
//                         })),
//                         AppData.row1(
//                             "Mobile Number :", "Mobile No", _mobileNoController,
//                             ((value) {
//                           innerState(() {
//                             _mobileNoController.text = value;
//                           });
//                         })),
//                         // Container(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Text(
//                         //     'Document Type',
//                         //     style: TextStyle(
//                         //         color: Colors.grey,
//                         //         fontSize: 14,
//                         //         fontWeight: FontWeight.w600),
//                         //   ),
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Container(
//                         //     height: 50,
//                         //     width: double.infinity,
//                         //     decoration: BoxDecoration(
//                         //       border: Border.all(color: Colors.grey),
//                         //       borderRadius: BorderRadius.circular(5.0),
//                         //       color: Colors.white,
//                         //     ),
//                         //     child: Container(
//                         //       padding: const EdgeInsets.all(6.0),
//                         //       child: Text(
//                         //         "",
//                         //         style: TextStyle(
//                         //             color: Colors.grey,
//                         //             fontSize: 14,
//                         //             fontWeight: FontWeight.w600),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         // Container(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Text(
//                         //     'Driver Name',
//                         //     style: TextStyle(
//                         //         color: Colors.grey,
//                         //         fontSize: 14,
//                         //         fontWeight: FontWeight.w600),
//                         //   ),
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Container(
//                         //     height: 50,
//                         //     width: double.infinity,
//                         //     decoration: BoxDecoration(
//                         //       border: Border.all(color: Colors.grey),
//                         //       borderRadius: BorderRadius.circular(5.0),
//                         //       color: Colors.white,
//                         //     ),
//                         //     child: Container(
//                         //       padding: const EdgeInsets.all(6.0),
//                         //       child: Text(
//                         //         "",
//                         //         style: TextStyle(
//                         //             color: Colors.grey,
//                         //             fontSize: 14,
//                         //             fontWeight: FontWeight.w600),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         // Container(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Text(
//                         //     'Remarks',
//                         //     style: TextStyle(
//                         //         color: Colors.grey,
//                         //         fontSize: 14,
//                         //         fontWeight: FontWeight.w600),
//                         //   ),
//                         // ),
//                         // Container(
//                         //     height: 78,
//                         //     padding: const EdgeInsets.all(6.0),
//                         //     child: TextField(
//                         //       controller: null,
//                         //       decoration: InputDecoration(
//                         //           border: const OutlineInputBorder(),
//                         //           contentPadding:
//                         //               const EdgeInsets.only(top: 12, left: 12),
//                         //           hintText: 'Update remarks',
//                         //           hintStyle: TextStyle(color: Colors.grey)),
//                         //       keyboardType: TextInputType.multiline,
//                         //       maxLines: 10,
//                         //       maxLength: 500,
//                         //     )),
//                         // Container(
//                         //     height: 38,
//                         //     padding: const EdgeInsets.all(5.0),
//                         //     child: GestureDetector(
//                         //       child: Row(children: [
//                         //         Icon(Icons.file_present_rounded),
//                         //         SizedBox(width: 4),
//                         //         Text("Choose File",
//                         //             style: TextStyle(
//                         //                 fontWeight: FontWeight.bold,
//                         //                 color: Colors.black87,
//                         //                 fontSize: 14.0)),
//                         //         SizedBox(width: 4),
//                         //         Icon(Icons.arrow_forward_outlined),
//                         //       ]),
//                         //       onTap: () {},
//                         //     )),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Text(
//                         //     'Upload JPG, PNG and PDF Format',
//                         //     style: TextStyle(
//                         //       fontSize: 14,
//                         //       color: Colors.grey,
//                         //     ),
//                         //   ),
//                         // ),
//                         // const SizedBox(
//                         //   height: 10,
//                         // ),
//                         Container(
//                           width: double.infinity,
//                           height: 50,
//                           padding: const EdgeInsets.all(5.0),
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.blue,
//                               // fixedSize: Size(250, 50),
//                             ),
//                             child: const Text(
//                               "ADD",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             );
//           });
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   showUpdateDataAlert(context);
//                 },
//                 child: const Text("Add Employee"))
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
