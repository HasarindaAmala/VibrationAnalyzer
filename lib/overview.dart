import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


late StreamController graphController;
class OverView extends StatefulWidget {
  const OverView({super.key});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {

  @override
  void initState() {
    graphController = StreamController.broadcast();
    graphController.sink.add(vibrationData1);
    // TODO: implement initState
    super.initState();
  }
  late final bool isShowingMainData;

  List<FlSpot> createSpots(List<double> data) {
    return List.generate(
        data.length, (index) => FlSpot(index.toDouble(), data[index]));
  }

   List<double> vibrationData1 = [0, 3, 1.5, 4, 2, 2.5, 3.5];
   List<double> vibrationData2 = [0, 5, 1.5, 7, 2, 4.5, 1.5];
   List<double> vibrationData3 = [0, 2, 3.2, 1, 3, 5.5, 2.5];
   List<double> vibrationData4 = [0, 2, 4.5, 0.5, 2.5, 3.5, 4.5];

   List<Widget> RecordTiles = [];

  @override
  Widget build(BuildContext context) {
    RecordTiles.clear();
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
      children: [
        Positioned(
            top: height * 0.15,
            left: width * 0.023,
            width: width * 0.86,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.1,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E202D),
                    // border: Border.all(
                    //   color: Colors.white60,
                    //   width: 1.0,
                    // ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.005)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.012,),
                        Text("Total records", style: TextStyle(
                            fontSize: width * 0.011, color: Colors.white),),
                        Text("27", style: TextStyle(
                            fontSize: width * 0.008, color: Colors.white60),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: width*0.008,),
                Container(
                  width: width * 0.1,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E202D),
                    // border: Border.all(
                    //   color: Colors.white60,
                    //   width: 1.0,
                    // ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.005)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.012,),
                        Text("Avarage Vibration", style: TextStyle(
                            fontSize: width * 0.011, color: Colors.white),),
                        Text("72 per min", style: TextStyle(
                            fontSize: width * 0.008, color: Colors.white60),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: width*0.008,),
                Container(
                  width: width * 0.1,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E202D),
                    // border: Border.all(
                    //   color: Colors.white60,
                    //   width: 1.0,
                    // ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.005)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.012,),
                        Text("Sensor Status", style: TextStyle(
                            fontSize: width * 0.011, color: Colors.white),),
                        Text(" Active", style: TextStyle(
                            fontSize: width * 0.008, color: Colors.greenAccent),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: width*0.008,),
                Container(
                  width: width * 0.1,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E202D),
                    // border: Border.all(
                    //   color: Colors.white60,
                    //   width: 1.0,
                    // ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.005)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.012,),
                        Text("Last Update", style: TextStyle(
                            fontSize: width * 0.011, color: Colors.white),),
                        Text("5 min ago", style: TextStyle(
                            fontSize: width * 0.008, color: Colors.white60),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: width*0.01,),
                Container(
                  width: width * 0.176,
                  height: height * 0.09,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E202D),
                    // border: Border.all(
                    //   color: Colors.white60,
                    //   width: 1.0,
                    // ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.005)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Image.asset("images/graph1.png",fit: BoxFit.fill,)
                  ),
                ),
              ],
            )), //top row
        Positioned(
            top: height * 0.26,
            left: width * 0.023,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E202D),
                //border: Border.all(width: 2, color: Colors.white24),
                borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),
              ),
              width: width * 0.3,
              height: height * 0.32,
              child: Padding(
                padding:  EdgeInsets.all(width*0.01),
                child: StreamBuilder(
                  stream:graphController.stream,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return LineChart(
                        LineChartData(
                          backgroundColor: Colors.transparent,
                          borderData: FlBorderData(
                            show: true,
                            // border: Border.all(
                            //   color: Color(0xFF070A1D), // Border color (including axis lines)
                            //   width: 2,
                            // ),
                          ),
                          lineBarsData: [

                            LineChartBarData(
                              spots: createSpots(vibrationData1),
                              isCurved: true,
                              color: Colors.pink,
                              dotData: FlDotData(show: false),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(
                                      color: Colors.white, // Change the left axis labels to white
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(
                                      color: Colors.white, // Change the bottom axis labels to white
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                        ),
                      );
                    }else if (snapshot.hasData){
                      return LineChart(
                        LineChartData(
                          backgroundColor: Colors.transparent,
                          borderData: FlBorderData(
                            show: true,
                            // border: Border.all(
                            //   color: Color(0xFF070A1D), // Border color (including axis lines)
                            //   width: 2,
                            // ),
                          ),
                          lineBarsData: [

                            LineChartBarData(
                              spots: createSpots(snapshot.data[0]),
                              isCurved: true,
                              color: Colors.pink,
                              dotData: FlDotData(show: false),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(
                                      color: Colors.white, // Change the left axis labels to white
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(
                                      color: Colors.white, // Change the bottom axis labels to white
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Text("no data");
                    }

                  }
                ),
              )


            )), // charts
        Positioned(
            top: height * 0.59,
            left: width * 0.023,
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E202D),
                  //border: Border.all(width: 2, color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),
                ),
                width: width * 0.3,
                height: height * 0.32,
                child: Padding(
                  padding:  EdgeInsets.all(width*0.01),
                  child: StreamBuilder(
                      stream:graphController.stream,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              borderData: FlBorderData(
                                show: true,
                                // border: Border.all(
                                //   color: Color(0xFF070A1D), // Border color (including axis lines)
                                //   width: 2,
                                // ),
                              ),
                              lineBarsData: [

                                LineChartBarData(
                                  spots: createSpots(vibrationData2),
                                  isCurved: true,
                                  color: Colors.lightGreen,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the left axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the bottom axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          );
                        }else if (snapshot.hasData){
                          return LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              borderData: FlBorderData(
                                show: true,
                                // border: Border.all(
                                //   color: Color(0xFF070A1D), // Border color (including axis lines)
                                //   width: 2,
                                // ),
                              ),
                              lineBarsData: [

                                LineChartBarData(
                                  spots: createSpots(snapshot.data[1]),
                                  isCurved: true,
                                  color: Colors.lightGreen,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the left axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the bottom axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          );
                        }else{
                          return Text("no data");
                        }

                      }
                  ),
                )


            )),//chart2

        Positioned(
            top: height * 0.26,
            left: width * 0.333,
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E202D),
                  //border: Border.all(width: 2, color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),
                ),
                width: width * 0.3,
                height: height * 0.32,
                child: Padding(
                  padding:  EdgeInsets.all(width*0.01),
                  child: StreamBuilder(
                      stream:graphController.stream,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              borderData: FlBorderData(
                                show: true,
                                // border: Border.all(
                                //   color: Color(0xFF070A1D), // Border color (including axis lines)
                                //   width: 2,
                                // ),
                              ),
                              lineBarsData: [

                                LineChartBarData(
                                  spots: createSpots(vibrationData4),
                                  isCurved: true,
                                  color: Colors.blueAccent,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the left axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the bottom axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          );
                        }else if (snapshot.hasData){
                          return LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              borderData: FlBorderData(
                                show: true,
                                // border: Border.all(
                                //   color: Color(0xFF070A1D), // Border color (including axis lines)
                                //   width: 2,
                                // ),
                              ),
                              lineBarsData: [

                                LineChartBarData(
                                  spots: createSpots(snapshot.data[3]),
                                  isCurved: true,
                                  color: Colors.blueAccent,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the left axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the bottom axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          );
                        }else{
                          return Text("no data");
                        }

                      }
                  ),
                )


            )),//chart4
        Positioned(
            top: height * 0.59,
            left: width * 0.333,
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E202D),
                  //border: Border.all(width: 2, color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),
                ),
                width: width * 0.3,
                height: height * 0.32,
                child: Padding(
                  padding:  EdgeInsets.all(width*0.01),
                  child: StreamBuilder(
                      stream:graphController.stream,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              borderData: FlBorderData(
                                show: true,
                                // border: Border.all(
                                //   color: Color(0xFF070A1D), // Border color (including axis lines)
                                //   width: 2,
                                // ),
                              ),
                              lineBarsData: [

                                LineChartBarData(
                                  spots: createSpots(vibrationData3),
                                  isCurved: true,
                                  color: Colors.orange,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the left axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the bottom axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          );
                        }else if (snapshot.hasData){
                          return LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              borderData: FlBorderData(
                                show: true,
                                // border: Border.all(
                                //   color: Color(0xFF070A1D), // Border color (including axis lines)
                                //   width: 2,
                                // ),
                              ),
                              lineBarsData: [

                                LineChartBarData(
                                  spots: createSpots(snapshot.data[2]),
                                  isCurved: true,
                                  color: Colors.orange,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the left axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Colors.white, // Change the bottom axis labels to white
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          );
                        }else{
                          return Text("no data");
                        }

                      }
                  ),
                )


            )),//chart3

        Positioned(
            top: height * 0.147,
            left: width * 0.645,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E202D),
               // border: Border.all(width: 2, color: Colors.white24),
                borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),

              ),
              width: width * 0.33,
              height: height * 0.77,
              child: Stack(
                children: [

                   Padding(
                     padding:  EdgeInsets.only(top: height*0.025,left: width*0.015,right: width*0.015 ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Records",style: TextStyle(fontSize: width*0.018,color: Colors.white),),
                        ElevatedButton(onPressed: (){

                        }, child: Icon(Icons.refresh))
                      ],
                                       ),
                   ),
                  Padding(
                    padding: EdgeInsets.only(top: height*0.1,left: width*0.01,right: width*0.01,bottom: height*0.03),
                    child: Container(
                      child: FutureBuilder<List<Widget>>(future: listFiles(),builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }else if(snapshot.hasData){
                          return  ListView(
                            children: snapshot.data!,
                          );
                        }else{
                          return const Text("No data .. ");
                        }
                      },),


                    ),
                  ),
                ],
              ),

            )), //records
      ],
    );
  }
  Future<List<Widget>> listFiles() async {

    try {
      // Reference to the folder in Firebase Storage
      Reference folderRef = FirebaseStorage.instance.ref().child('Data_files');

      // List all items (files) in the folder
      ListResult result = await folderRef.listAll();


      RecordTiles.clear();
      // Extract the file names
      List<String> fileNames = result.items.map((item) => item.name).toList();
      for(var doc in fileNames){
           RecordTiles.add(
             Container(
             decoration: BoxDecoration(
               border: Border(bottom: BorderSide(color: Colors.black45,width: 1.0)),
               color:Colors.white.withOpacity(0.05),
             ),
             child: ListTile(
               textColor: Colors.white,
               iconColor: Colors.white,
               onTap: () async {
                 //await readTextFile(doc)
                 await readSensorData(doc);
               },
               leading: Icon(Icons.data_thresholding),
               title: Text(doc),
               trailing:IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
             ),
           ),
           );
      }

      return RecordTiles;
    } catch (e) {
      print("Error listing files: $e");
      return [];
    }
  }


  Future<List<List<double>>> readSensorData(String fileName) async {
    try {
      // Get the download URL
      String downloadURL = await FirebaseStorage.instance
          .ref('Data_files/$fileName')
          .getDownloadURL();

      // Fetch the file content using HTTP
      final response = await http.get(Uri.parse(downloadURL));

      if (response.statusCode == 200) {
        String fileContent = response.body;

        // Process the file content as before
        List<String> lines = fileContent.split('\n');
        List<double> sensor1 = [];
        List<double> sensor2 = [];
        List<double> sensor3 = [];
        List<double> sensor4 = [];

        for (String line in lines) {
          List<String> values = line.split(',');

          if (values.length == 4) {
            sensor1.add(double.parse(values[0]));
            sensor2.add(double.parse(values[1]));
            sensor3.add(double.parse(values[2]));
            sensor4.add(double.parse(values[3]));
          }
        }
        print(sensor1);
        graphController.sink.add([sensor1, sensor2, sensor3, sensor4]);
        return [sensor1, sensor2, sensor3, sensor4];
      } else {
        throw Exception('Failed to load file');
      }
    } catch (e) {
      print("Error reading file: $e");
      return [];
    }
  }


}
