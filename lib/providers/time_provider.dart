// import 'package:flutter/material.dart';

// class TimeProvider extends StatefulWidget {
//   final DateTime time;
//   final Widget child;

//   TimeProvider({required this.time, required this.child});

//   @override
//   _TimeProviderState createState() => _TimeProviderState();

//   static _TimeProviderState? of(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<_InheritedTimeProvider>()
//         ?.data;
//   }
// }

// class _TimeProviderState extends State<TimeProvider> {
//   late DateTime time;

//   @override
//   void initState() {
//     super.initState();
//     time = widget.time;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _InheritedTimeProvider(
//       data: this,
//       child: widget.child,
//     );
//   }
// }

// class _InheritedTimeProvider extends InheritedWidget {
//   final _TimeProviderState data;

//   _InheritedTimeProvider({required this.data, required Widget child})
//       : super(child: child);

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';

class TimeProvider with ChangeNotifier {
  DateTime _time = DateTime.now();

  DateTime get time => _time;

  void updateTime(DateTime newTime) {
    _time = newTime;
    notifyListeners();
  }
}
