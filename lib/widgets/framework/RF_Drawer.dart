// import 'package:attendance/view/widgets/framework/rf_dashedLine.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../common_controller/MiscController.dart';
// import '../../../api_service/colors.dart';
// import '../../all/Login/cubit/logout.dart';
// import '../../pages/Login/cubit/logout.dart';
// import '../../pages/Onboard/SplashPage.dart';
// import '../../pages/Profile/profile_page.dart';
// import '../../pages/password_change/password_change.dart';
//
//
//
// class RFDrawer extends StatefulWidget {
//    RFDrawer({Key? key}) : super(key: key);
//
//   @override
//   State<RFDrawer> createState() => _RFDrawerState();
// }
//
// class _RFDrawerState extends State<RFDrawer> {
//   final logoutController = Logout();
//   @override
//   Widget build(BuildContext context) {
//     final MiscController _miscController = MiscController();
//     return Drawer(
//
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.save_black,
//               AppColors.lightGreyColor,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           children: [
//
//             ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 trailing: IconButton(
//                   onPressed: () => Scaffold.of(context).closeDrawer(),
//                   icon: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//
//             SizedBox(height: 20.h),
//
//             ListTile(
//               title: Text(
//                 'Profile',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {
//                 _miscController.navigateTo(context: context,page: ProfilePage());
//               },
//             ),
//             RFDashedLine(),
//             ListTile(
//               title: Text(
//                 'Change Password',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {
//                 _miscController.navigateTo(context: context,page: PasswordChange());
//               },
//             ),
//             RFDashedLine(),
//             ListTile(
//               title: Text(
//                 'About Us',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {},
//             ),
//             RFDashedLine(),
//             ListTile(
//               title: Text(
//                 'Notification',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {},
//             ),
//             RFDashedLine(),
//             ListTile(
//               title: Text(
//                 'FAQ',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {},
//             ),
//             RFDashedLine(),
//             ListTile(
//               title: Text(
//                 'Privacy Policy',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {},
//             ),
//            RFDashedLine(),
//             GestureDetector(
//               onTap: () {
//                 logoutController.logout(context: context, onLogout: (){
//                   _miscController.navigateTo(context: context, page: SplashPage());
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 80, top: 20),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Colors.green,
//                           Colors.amberAccent,
//                         ],
//                       )),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.logout_rounded,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "LOG OUT",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 60),
//           ],
//         ),
//       ),
//     );
//   }
// }
