// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel{
//   final String? id;
//   final String name;
//   final String course;
//   final String email;

//   const UserModel({
//     this.id,
//     required this.name,
//     required this.course,
//     required this.email


//   });

//   toJson(){
//     return {"Name": name, "Course": course, "Email": email};
//   }

//   factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
//     final data = document.data();
//     return UserModel(name: name, course: course, email: email)
//   }
// }