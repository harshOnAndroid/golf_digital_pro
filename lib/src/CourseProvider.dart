import 'package:flutter/widgets.dart';

import 'CoursesBloc.dart';

class CoursesProvider extends InheritedWidget{
  final CoursesBloc coursesBloc;

  CoursesProvider({Key key, @required this.coursesBloc, Widget child}) : super (key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CoursesBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(CoursesProvider) as CoursesProvider)
          .coursesBloc;
}