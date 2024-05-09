import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting

import 'course.dart'; // Import CourseScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _currentDate = DateTime.now();
  List<String> _tasksForSelectedDate = [];
  int _selectedDateIndex = -1;
  Query dbref = FirebaseDatabase.instance.ref().child('course');
  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "My Courses",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Change this to your desired number of courses
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      // Handle tap on course item
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseScreen(
                            courseName: "Course $index",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(10),
                        
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 1, // Border width
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Replace this with your course image
                          const Icon(Icons.book, size: 50),
                          const SizedBox(height: 10),
                          Text(
                            "Course $index",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 0.4,
            thickness: 0.6,
            
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Schedule",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _previousMonth,
                ),
                Text(
                  DateFormat.MMMM().format(_currentDate), // Display current month
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: DateTime(_currentDate.year, _currentDate.month + 1, 0).day, // Total days in current month
              itemBuilder: (context, index) {
                final currentDate = DateTime(_currentDate.year, _currentDate.month, index + 1);
                return Padding(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Handle tap on date item
                      setState(() {
                        _tasksForSelectedDate = ["Task 1", "Task 2"]; // Example tasks for selected date
                        _selectedDateIndex = index;
                      });
                    },
                    child: Container(

                      height: 40,
                      width: 40,
                      //padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.8,
              blurRadius: 1,
              offset: Offset(0.5, 0.8), // changes position of shadow
            ),],
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedDateIndex == index ? Color.fromARGB(255, 255, 87, 185) : Color.fromARGB(255, 233, 246, 254).withOpacity(0.9), // Change background color if selected
                        border: Border.all(
                          color:  _selectedDateIndex == index ? Color.fromARGB(255, 255, 87, 185) : Color.fromARGB(255, 113, 191, 255),// Border color
                          width: 1, // Border width
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${currentDate.day}", // Display first three letters of the day along with date
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: _selectedDateIndex == index ? Colors.white : Colors.black, // Change text color if selected
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          _tasksForSelectedDate.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Tasks for ${_selectedDateIndex+1} ${DateFormat.MMMM().format(_currentDate)}", // Display selected date
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: _tasksForSelectedDate.map((task) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: Text("- $task"),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                )
                
              :const SizedBox(),
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("3:00 PM",
                style: const TextStyle(fontSize: 16, color: Colors.grey),)
                ,
                SizedBox(width: 50, height: 1,),
                Padding(padding: const EdgeInsets.all(16),
                child: Container(height: 50, width: 150,padding: const EdgeInsets.all(10),decoration: BoxDecoration(boxShadow: [
            ],
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 255, 122, 122).withOpacity(1), // Change background color if selected
                        
                      ),
                      child: Text("Guitar\nHSA Players | 3:00-3:30pm", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 10),),
                      
                       )),

              ],
            ),
            
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("4:00 PM",
                style: const TextStyle(fontSize: 16, color: Colors.grey),)
                ,
                SizedBox(width: 50, height: 1,),
            //     Padding(padding: const EdgeInsets.all(16),
            //     child: Container(height: 50, width: 150,padding: const EdgeInsets.all(10),decoration: BoxDecoration(boxShadow: [
            // ],
            //             borderRadius: BorderRadius.circular(10),
            //             color: Color.fromARGB(255, 255, 122, 122).withOpacity(1), // Change background color if selected
                        
            //           ),
            //           child: Text("Guitar\nHSA Players | 3:00-3:30pm", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 10),),
                      
            //            )),

              ],
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("5:00 PM",
                style: const TextStyle(fontSize: 16, color: Colors.grey),)
                ,
                SizedBox(width: 50, height: 1,),
                Padding(padding: const EdgeInsets.all(16),
                child: Container(height: 50, width: 150,padding: const EdgeInsets.all(10),decoration: BoxDecoration(boxShadow: [
            ],
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 103, 147, 230).withOpacity(1), // Change background color if selected
                        
                      ),
                      child: Text("Cricket\nHSA Players | 5:00-6:00pm", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 10),),
                      
                       )),

              ],
            ),
            
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
