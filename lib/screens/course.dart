import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  final String courseName;
  
  const CourseScreen({Key? key, required this.courseName}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Announcements'),
          StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('Course_details').snapshots(), builder: (context, snapshot){
            String sss="";
            if(snapshot.hasData){
              final course_details = snapshot.data?.docs.reversed.toList();
              
              for(var course in course_details!){
                if(course['Course']==courseName){
                  sss = course['Ann'];
                  //  _buildAnnouncements(course['Ann']);
                }
              }
            }
            return Padding(padding: const EdgeInsets.all(10),
            child: Container(padding: const EdgeInsets.all(16),height: 100, width: 350,decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.8,
              blurRadius: 1,
              offset: Offset(0.5, 0.8), // changes position of shadow
            ),],
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 233, 246, 254).withOpacity(0.9), // Change background color if selected
                        border: Border.all(
                          color:   Color.fromARGB(255, 113, 191, 255),// Border color
                          width: 1, // Border width
                        ),),
            
            child: Text(sss, style: TextStyle(fontSize: 15),),),);
          },
          ),
         
          _buildSectionHeader('Feedback'),
          StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('Course_details').snapshots(), builder: (context, snapshot){
            String sss="";
            if(snapshot.hasData){
              final course_details = snapshot.data?.docs.reversed.toList();
              
              for(var course in course_details!){
                if(course['Course']==courseName){
                  sss = course['Feedback'];
                  //  _buildAnnouncements(course['Ann']);
                }
              }
            }
            return Padding(padding: const EdgeInsets.all(10),
            child: Container(padding: const EdgeInsets.all(16),height: 100, width: 350,decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.8,
              blurRadius: 1,
              offset: Offset(0.5, 0.8), // changes position of shadow
            ),],
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 233, 246, 254).withOpacity(0.9), // Change background color if selected
                        border: Border.all(
                          color:   Color.fromARGB(255, 113, 191, 255),// Border color
                          width: 1, // Border width
                        ),),
            
            child: Text(sss, style: TextStyle(fontSize: 15),),),);
          },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAnnouncements(String ss) {
    
    // Replace this with your logic to fetch and display announcements
    return ListTile(
      title: Text(ss),
    );
  }

  Widget _buildFeedback() {
    // Replace this with your logic to fetch and display feedback
    return ListTile(
      title: Text('No feedback yet.'),
    );
  }
}
