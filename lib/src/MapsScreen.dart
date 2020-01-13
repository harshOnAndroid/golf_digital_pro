import 'package:flutter/widgets.dart';
import 'package:golf_digital_pro/src/Course.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'CourseProvider.dart';
import 'CoursesBloc.dart';

class MapsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapsScreenState();
  }
}

class MapsScreenState extends State<MapsScreen> {
  var _initialTarget = LatLng(40.704026, -74.0655557);
  CoursesBloc _coursesBloc;
  GoogleMapController _mapController;
  Set<Marker> _markers;

  @override
  void initState() {
    _markers = Set();
    _coursesBloc = CoursesBloc.getInstance;
    _coursesBloc.courseListStream.listen((newCourses) {
      setState(() {
        _markers = _getMarkers(newCourses).toSet();
      });

      if (newCourses.isNotEmpty) _animateCamera();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CoursesProvider(
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) =>
            _mapController = controller,
        initialCameraPosition:
            CameraPosition(target: _initialTarget, zoom: 12, tilt: 90),
        mapType: MapType.terrain,
        markers: _markers,
      ),
      coursesBloc: _coursesBloc,
    );
  }

  //for moving google map camera to new position
  _animateCamera() async {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(35.346161, -120.069673),
      zoom: 6,
    )));
  }

  // extracts a list of Markers from the given list of Courses
  List<Marker> _getMarkers(List<Course> courseList) {
    return courseList.map((c) {
      return Marker(
          infoWindow: InfoWindow(
            title: c.course_name,
          ),
          markerId: MarkerId(c.course_name),
          position: LatLng(c.location.lat, c.location.long));
    }).toList();
  }
}
