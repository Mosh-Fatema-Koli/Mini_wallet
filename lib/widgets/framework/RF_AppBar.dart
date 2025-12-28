//
// import 'package:boilerplate_of_cubit/widgets/framework/rf_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:boilerplate_of_cubit/library.dart';
// import '../../view/Profile/cubit/Theme/theme_change_cubit.dart';
//
//
// class RFAppBar extends StatelessWidget {
//   const RFAppBar({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeCubit = context.watch<ThemeCubit>();
//     final isDark = themeCubit.state.themeMode == ThemeMode.dark;
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('EEEE, dd MMM yyyy').format(now);
//
//     final MiscController _miscController = MiscController();
//     return AppBar(
//       toolbarHeight: 80.w,
//       backgroundColor:isDark?Colors.grey: AppColors.primaryColor,
//       automaticallyImplyLeading: false,
//       title:ListTile(
//       contentPadding: EdgeInsets.only(top: 15),
//         leading:
//         // SizedBox(
//         //   height: 40.h,
//         //       width: 40.h,
//         //   child: ClipOval(
//         //     child: Image.asset(
//         //       "assets/images/man.png",
//         //       fit: BoxFit.cover,
//         //       height: 70.h,
//         //       width: 70.h,
//         //     ),
//         //   ),
//         // ),
//         AppCache().userInfo!.avatarUrl != null
//             ? GestureDetector(
//           onTap: () {
//             // _miscController.navigateTo(
//             //     context: context, page: NavbarPage(initialIndex: 1));
//           },
//           child: Container(
//             height: 40.h,
//             width: 40.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white, width: 2),
//             ),
//             child: ClipOval( // Use ClipOval for a perfect circle
//               child:
//
//               CachedNetworkImage(
//                 imageUrl: "${AppCache().userInfo!.avatarUrl}",
//                 fit: BoxFit.cover, // Cover to fill the circular space
//                 placeholder: (context, url) => Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 errorWidget: (context, url, error) =>
//                     Image.asset("assets/images/man.png", fit: BoxFit.cover),
//               ),
//             ),
//           ),
//         )
//             : ClipOval(
//           child: Image.asset(
//             "assets/images/man.png",
//             fit: BoxFit.cover,
//             height: 70.h,
//             width: 70.h,
//           ),
//         ),
//         title: RFText(text: "Welcome, ${AppCache().userInfo!.name}",size: 14.sp,weight: FontWeight.bold,color: AppColors.save_white,),
//         subtitle: RFText(
//           text: formattedDate.toString(),
//           size: 20.sp,
//           color: AppColors.save_white,
//         ),
//       ) ,
//
//     );
//
//
//   }
// }