// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class FakePushNotificationScreen extends StatefulWidget {
//   @override
//   _FakePushNotificationScreenState createState() =>
//       _FakePushNotificationScreenState();
// }
//
// class _FakePushNotificationScreenState
//     extends State<FakePushNotificationScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _slideAnimation;
//
//   bool _isNotificationVisible = false;
//
//   String _notificationTitle = "Weekly Progress";
//   String _notificationMessage =
//       "You have reached 80% of your daily goal. Keep it up!";
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, -1),
//       end: Offset(0, 0),
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOut,
//     ));
//
//     // Trigger the fake push notification
//     _showFakeNotification();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _showFakeNotification() async {
//     setState(() {
//       _isNotificationVisible = true;
//     });
//
//     // Slide the notification in
//     _animationController.forward();
//
//     // Automatically hide notification after 3 seconds
//     await Future.delayed(Duration(seconds: 3));
//     _hideFakeNotification();
//   }
//
//   void _hideFakeNotification() async {
//     if (!_isNotificationVisible) return;
//
//     // Slide the notification out
//     await _animationController.reverse();
//     setState(() {
//       _isNotificationVisible = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main Content
//           Center(
//             child: ElevatedButton(
//               onPressed: _showFakeNotification,
//               child: Text("Show Fake Notification"),
//             ),
//           ),
//
//           // Fake Notification
//           if (_isNotificationVisible)
//             SlideTransition(
//               position: _slideAnimation,
//               child: GestureDetector(
//                 onTap: _hideFakeNotification,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   margin: EdgeInsets.only(
//                     top: 10,
//                     left: MediaQuery.of(context).size.width * 0.05,
//                     right: MediaQuery.of(context).size.width * 0.05,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blueAccent,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.notifications, color: Colors.white, size: 24),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               _notificationTitle,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 2),
//                             Text(
//                               _notificationMessage,
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 12,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.close, color: Colors.white, size: 20),
//                         onPressed: _hideFakeNotification,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
