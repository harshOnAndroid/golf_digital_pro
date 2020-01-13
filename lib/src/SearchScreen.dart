import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golf_digital_pro/src/Course.dart';
import 'CourseProvider.dart';
import 'CoursesBloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  var _listFlex = 0;
  FocusNode _searchFocusNode;
  CoursesBloc _coursesBloc;
  bool _isMapMode = true;
  BorderRadius _radius = BorderRadius.all(Radius.circular(20));
  List<Course> courseList = List();
  double _carouselHeight = 80.0;

  @override
  void initState() {
    super.initState();
    _coursesBloc = CoursesBloc.getInstance;
    _setCourseListListener();
    _setSearchFieldFocusListener();
  }

  _setCourseListListener() {
    _coursesBloc.courseListStream.listen((data) {
      setState(() {
        courseList = data;
        _isMapMode = courseList.isEmpty;
        _carouselHeight = courseList.isEmpty ? 80 : 260;
        _radius = _isMapMode
            ? BorderRadius.all(Radius.circular(20))
            : BorderRadius.all(Radius.circular(8));
      });
    });
  }

  _setSearchFieldFocusListener() {
    _searchFocusNode = FocusNode(
      canRequestFocus: false,
    );
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus && _listFlex == 0) {
        setState(() {
          _listFlex = 1;
        });
      } else if (!_searchFocusNode.hasFocus && _listFlex == 1)
        setState(() {
          _listFlex = 0;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        _courseListContainer,
        _searchBar,
      ]),
    );
  }

  get _courseListContainer => AnimatedContainer(
        height:
            _isMapMode ? _carouselHeight : MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 80),
        color: Colors.black.withOpacity(_isMapMode ? 0.2 : 0),
        child: CoursesProvider(
          child: ListView.builder(
            reverse: !_isMapMode,
            shrinkWrap: true,
            scrollDirection: _isMapMode ? Axis.horizontal : Axis.vertical,
            itemCount: courseList.length,
            itemBuilder: (BuildContext context, int index) =>
                _courseListItem(courseList[index]),
          ),
          coursesBloc: _coursesBloc,
        ),
        duration: Duration(milliseconds: 400),
      );

  _courseListItem(Course course) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Stack(
        children: [
          Container(
            height: 120,
            margin: EdgeInsets.only(left: 10, right: 5, top: 30, bottom: 10),
            padding: EdgeInsets.only(right: 10, bottom: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0x5aFb7D52),
                      blurRadius: 12,
                      offset: Offset(6, 10.0))
                ],
                gradient: LinearGradient(colors: <Color>[
                  Colors.orangeAccent,
                  Colors.orangeAccent.withOpacity(0.5)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.elliptical(130, 80))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            "assets/golf.png",
                            height: 12,
                            width: 15,
                            fit: BoxFit.fill,
                            color: Colors.white,
                          ),
                          Text(
                            course.holes.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, top: 8),
                      child: Text(
                        course.avg_cost,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                Container(
                  width: 2,
                  margin: EdgeInsets.only(left: 10, top: 30),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.orangeAccent,
                    Colors.white,
                    Colors.orangeAccent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(4),
                          child: Text(
                            course.course_name,
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        margin: EdgeInsets.only(left: 10, bottom: 6),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.orangeAccent,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.orangeAccent,
                            ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15, top: 4),
                        child: Text(
                          course.address,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15, top: 4),
                        child: Text(
                          "${course.city}, ${course.state}",
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            child: Image.network(
              course.logo,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            left: 5,
          ),
        ],
      ),
    );
  }

  get _searchBar => Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            const EdgeInsets.only(right: 20.0, left: 10, top: 20, bottom: 20),
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            _modeSelector,
            _searchField,
          ],
        ),
      ));

  get _searchField => Expanded(
        child: Container(
          height: 40,
          decoration: new BoxDecoration(
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 2)
            ],
          ),
          child: TextFormField(
            autofocus: false,
            focusNode: _searchFocusNode,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.top,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'My Favorite Golf Course...',
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1),
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
            onChanged: (newText) => _onSearchTextChanged(newText),
          ),
        ),
      );

  get _modeSelector => GestureDetector(
        onTap: () {
          if (courseList.isNotEmpty)
            setState(() {
              _isMapMode = !_isMapMode;
              _carouselHeight = courseList.isEmpty ? 80 : 260;
              _radius = _isMapMode
                  ? BorderRadius.all(Radius.circular(20))
                  : BorderRadius.all(Radius.circular(8));
            });
        },
        child: AnimatedContainer(
          height: 40,
          width: 40,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          margin: EdgeInsets.all(5),
          decoration: new BoxDecoration(
            color: courseList.isEmpty ? Colors.grey : Colors.orange,
            borderRadius: _radius,
          ),
          child: Container(
            child: Center(
              child: Image.asset(
                'assets/${_isMapMode ? 'map' : 'list'}.png',
                color: _isMapMode ? null : Colors.white,
                fit: BoxFit.scaleDown,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      );

  _onSearchTextChanged(String newText) {
    if (newText.length > 2) {
      _filterSearch();
    } else
      _coursesBloc.onCoursesFetched(List());
  }

  _filterSearch() {
    _getCourses();
  }

  _getCourses() async {
    try {
      String strJson = await DefaultAssetBundle.of(context)
          .loadString('assets/courses.json');

      var json = jsonDecode(strJson);

      var l = List<Course>.from(json.map((_) => Course.fromJson(_)));
      print("list =>" + l.toString());
      _coursesBloc.onCoursesFetched(l);
    } catch (Exception) {
      print('errror =>' + Exception.toString());
      _coursesBloc.onCoursesFetched(List<Course>());
    }
  }
}
