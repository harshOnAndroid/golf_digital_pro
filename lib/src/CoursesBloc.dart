import 'package:golf_digital_pro/src/Course.dart';
import 'package:rxdart/subjects.dart';

class CoursesBloc{
  static var _instance;
  final _coursesSubject = BehaviorSubject<List<Course>>();
  Stream<List<Course>> get courseListStream => _coursesSubject.stream;

  final _scrollPositionSubject = BehaviorSubject<int>();
  Stream<int> get scrollPosition => _scrollPositionSubject.stream;

  CoursesBloc._(){
    _instance = this;
  }

  static CoursesBloc get getInstance => _instance??CoursesBloc._();

  updateCourseList(List<Course> courses){
    _coursesSubject.sink.add(courses);
  }

  onCoursesFetched(List<Course> list){
   _coursesSubject.add(list);
  }

  scrollToPosition(int position){
    _scrollPositionSubject.add(position);
  }

  void dispose() {
    _coursesSubject.close();
    _scrollPositionSubject.close();
  }
}