// import 'package:flutter/material.dart';

// final dropDownButtons = DropdownButton<String>(
//      isExpanded: true,
//      value: dropdownValue.value,
//      // icon: Icon(Icons.arrow_downward),
//      iconSize: 24,
//      elevation: 16,
//      style: TextStyle(color: Colors.black),
//      underline: Container(
//        height: 2,
//        color: Theme.of(context).accentColor,
//      ),
//      onChanged: (String newValue) {
//        setState(() {
//          print(newValue);
//          dropdownValue.value = newValue;
//        });
//      },
//      items: <School>[
//        School('Business', 'business'),
//        School('Design', 'design'),
//        School('Engineering', 'engineering'),
//        School('Applied Science', 'applied_science'),
//        School('Information Technology', 'it')
//      ].map<DropdownMenuItem<String>>((School value) {
//        return DropdownMenuItem<String>(
//          value: value.value,
//          child: Text(value.displayName,
//              style: Theme.of(context).textTheme.subtitle),
//        );
//      }).toList(),
//    );

//    Future _loadCourseAsset() async {
//      print("loading course");
//      if (dropdownValue == 'Business') {
//        return await rootBundle.loadString("assets/business.json");
//      } else if (dropdownValue == 'Engineering') {
//        return await rootBundle.loadString("assets/engineering.json");
//      } else if (dropdownValue == 'Applied Science') {
//        return await rootBundle.loadString("assets/asc.json");
//      }
//    }

//    Future loadCourse() async {
//      String jsonString = await _loadCourseAsset();
//      final jsonResponse = json.decode(jsonString);
//      // print(jsonResponse);
//      return jsonResponse;
//    }

//    final coursesContainer = FutureBuilder(
//        future: loadCourse(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return CircularProgressIndicator();
//          } else {
//            return CourseList(courses: snapshot.data);
//          }
//        });