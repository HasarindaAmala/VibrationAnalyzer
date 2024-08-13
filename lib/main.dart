import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vibration_analizer/overview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyAQh-NYl_HpFpHaK0u0XsoD-YiAv6seQ5U",
        authDomain: "vibrationanalizer.firebaseapp.com",
        projectId: "vibrationanalizer",
        storageBucket: "vibrationanalizer.appspot.com",
        messagingSenderId: "89501502136",
        appId: "1:89501502136:web:b6d18b3b0c232bc8cc024d"
    ));
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool overview = true;
  bool records = false;
  bool analytics = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B123D),
        foregroundColor: Colors.white,
        leading: const Icon(Icons.account_balance_outlined),
        title: Row(
          children: [
            const Text("Vibration Analyzer"),
            SizedBox(
              width: width * 0.02,
            ),
            const Icon(Icons.horizontal_distribute),
            SizedBox(
              width: width * 0.02,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Overview",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Analytics",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: () {},
                        child: const Text("settings",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Records",
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: width * 0.2,
            child: TextFormField(
              style:  TextStyle(color: Colors.white),
              decoration:  const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search here",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        color: const Color(0xFF161D26),
        child: Stack(
          children: [


            Positioned(
                top: height * 0.03,
                left: width * 0.025,
                child: SizedBox(
                  width: width ,
                  height: height * 0.1,
                  child: Stack(
                    children: [
                      Positioned(
                          top: height * 0.0,
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                                color: Colors.white, fontSize: height * 0.03),
                          )),

                      Positioned(
                          top: height * 0.05,
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      overview = true;
                                      records = false;
                                      analytics = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(width: 1.0,color: Colors.white24),
                                    backgroundColor: overview==true?Color(0xFF0D7BE0) : const Color(0xFF070A1D),
                                    shape: const BeveledRectangleBorder(),
                                  ),
                                  child: Text(
                                    "Overview",
                                    style: TextStyle(
                                        color: overview == true
                                            ? Colors.white
                                            : Colors.white24),
                                  )),
                              SizedBox(
                                width: width * 0.003,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      overview = false;
                                      records = true;
                                      analytics = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(width: 1.0,color: Colors.white24),
                                    backgroundColor: records==true?Color(0xFF0D7BE0) : const Color(0xFF070A1D),
                                    shape: const BeveledRectangleBorder(),
                                  ),
                                  child: Text(
                                    "Records",
                                    style: TextStyle(
                                        color: records == true
                                            ? Colors.white
                                            : Colors.white24),
                                  )),
                              SizedBox(
                                width: width * 0.003,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      overview = false;
                                      records = false;
                                      analytics = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(width: 1.0,color: Colors.white24),
                                    backgroundColor: analytics==true?Color(0xFF0D7BE0) : const Color(0xFF070A1D),
                                    shape: const BeveledRectangleBorder(),
                                  ),
                                  child: Text(
                                    "Analytics",
                                    style: TextStyle(
                                        color: analytics == true
                                            ? Colors.white
                                            : Colors.white24),
                                  )),



                            ],
                          )),
                      Positioned(
                        top: height*0.05,
                        left: width*0.859,
                        child:  ElevatedButton(
                          onPressed: () {
                            setState(() {

                            });
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width*0.09, height*0.035),
                            backgroundColor: Color(0xFF0D7BE0),
                            shape: const BeveledRectangleBorder(),
                          ),
                          child: width*0.09 >112 ? Text(
                            maxLines: 1,
                            "Download",
                            style: TextStyle(
                                color:Colors.white,
                            ),
                          ): Center(child: Icon(Icons.download,color: Colors.white,))),),
                    ],
                  ),
                )),
            overview == true ? const OverView() : Container(),
          ],
        ),
      ),
    );
  }
}
