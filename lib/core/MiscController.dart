
import 'package:boilerplate_of_cubit/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';


class MiscController {

  //region Navigation or Routing
  navigateTo({required BuildContext context, dynamic page}) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
  //region Navigation or Routing
  navigateBack({required BuildContext context}) {
    return Navigator.pop(context);
  }
  //endregion
  //region Internet check
  Future<String> checkInternet() async {
    final List<ConnectivityResult> results = await Connectivity().checkConnectivity();

    if (results.contains(ConnectivityResult.mobile)) {
      return 'mobile';
    } else if (results.contains(ConnectivityResult.wifi)) {
      return 'wifi';
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return 'ignore-ethernet';
    } else if (results.contains(ConnectivityResult.vpn)) {
      return 'ignore-vpn';
    } else if (results.contains(ConnectivityResult.bluetooth)) {
      return 'ignore-bluetooth';
    } else if (results.contains(ConnectivityResult.other)) {
      return 'ignore-other';
    } else if (results.contains(ConnectivityResult.none)) {
      return 'ignore-none';
    } else {
      return 'ignore-error';
    }
  }


  internetErrorToast() {
    toast(msg: "Internet Error!\nYou are offline, Please check your internet connection.");
  }
  //endregion

  //region Toast Message
  toast({required String msg, Color? backgroundColor, Color? textColor, double? textSize, Toast? length, ToastGravity? position, int? durationForIOSandWebSec}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length ?? Toast.LENGTH_LONG,
      gravity: position ?? ToastGravity.TOP,
      timeInSecForIosWeb: durationForIOSandWebSec ?? 1,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      textColor: textColor ?? Colors.white,
      fontSize: textSize ?? 16.sp,
    );
  }
  //endregion

  Future showAppExitDialog({required BuildContext context}) {
    return showAlertDialog(
        context: context,
        cancelable: false,
        title: 'Exit',
        subTitle: 'Do you want to exit from the App?',
        okText: 'YES',
        okPressed: () {
          SystemNavigator.pop();
        },
        cancelText: 'NO',
        cancelPressed: () {
          Navigator.pop(context);
        });
  }

  //region Scroll to down
  void scrollDown({required ScrollController scrollController}) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
  //endregion

  //region Scroll to up
  void scrollUp({required ScrollController scrollController}) {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
  //endregion

  //region Dialog
  Future showAlertDialog({required BuildContext context, required bool cancelable, required String title, required String subTitle, required String okText, required Function okPressed, String? cancelText, Function? cancelPressed}){
    return showDialog(
        context: context,
        barrierDismissible: cancelable ? true : false,
        builder: (BuildContext context) {
          return PopScope(
              canPop: cancelable ? true : false,
              child: RFAlertDialog(
                  title: title,
                  subTitle: subTitle,
                  okText: okText,
                  cancelText: cancelText,
                  cancelPressed: cancelPressed,
                  okPressed: okPressed)
          );
        });
  }

  //region error dialog
  Future errorDialog({required BuildContext context, required String message, Function? onOkPressed}) async {
    await showGraphicalDialog(
        context: context,
        cancelable: false,
        // imagePath: 'assets/images/warning.png',
        title: 'Attention Please',
        subTitle: message,
        okText: 'OKAY',
        okPressed: () {
          Navigator.pop(context);
          if(onOkPressed != null) {
            onOkPressed();
          }
        });
  }
  //endregion

  Future showGraphicalDialog({required BuildContext context, required bool cancelable, String? imagePath, String? title, String? subTitle, Color? titleColor, Color? subTitleColor,
    String? okText, Function? okPressed, String? cancelText, Function? cancelPressed}){
    return showDialog(
        context: context,
        barrierDismissible: cancelable ? true : false,
        builder: (BuildContext context) {
          return PopScope(
              canPop: cancelable ? true : false,
              child: RFGraphicalDialog(
                imagePath: imagePath,
                title: title,
                subTitle: subTitle,
                okText: okText,
                cancelText: cancelText,
                titleColor: titleColor,
                subTitleColor: subTitleColor,
                okPressed: okPressed,
                cancelPressed: cancelPressed,
              ));
        });
  }

  Future showCustomWidgetDialog({required BuildContext context, Color? backgroundColor, double? leftPadding, double? rightPadding, required bool cancelable, required Widget dialogContent}){
    return showDialog(
        context: context,
        barrierDismissible: cancelable ? true : false,
        builder: (BuildContext context) {
          return PopScope(
              canPop: cancelable ? true : false,
              child: AlertDialog(
                backgroundColor: backgroundColor ?? Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12).r),
                contentPadding: EdgeInsets.only(left: leftPadding ?? 24, right: rightPadding ?? 24, top: 8).w,
                content: dialogContent,
              ));
        });
  }

  Future showWarningDialog({required BuildContext context, required bool cancelable, String? imagePath, String? title, String? subTitle, Color? titleColor, Color? subTitleColor,
    String? okText, Color? okButtonColor, Color? okButtonBorderColor, Color? okButtonTextColor, Function? okPressed, String? cancelText, Function? cancelPressed}){
    return showDialog(
        context: context,
        barrierDismissible: cancelable ? true : false,
        builder: (BuildContext context) {
          return PopScope(
              canPop: cancelable ? true : false,
              child: RFWarningDialog(
                imagePath: imagePath,
                title: title,
                subTitle: subTitle,
                okText: okText,
                cancelText: cancelText,
                titleColor: titleColor,
                subTitleColor: subTitleColor,
                okButtonTextColor: okButtonTextColor,
                okButtonColor: okButtonColor,
                okButtonBorderColor: okButtonBorderColor,
                okPressed: okPressed,
                cancelPressed: cancelPressed,
              ));
        });
  }

  Future delayed({required int millisecond, Function? onDelayed}) async {
    return await Future.delayed(Duration(milliseconds: millisecond), () {if(onDelayed!=null)onDelayed();});
  }

  Future showProgressDialog({required BuildContext context, String? title, String? subTitle}){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
              canPop: false,
              child: RFProgressDialog(
                  title: title,
                  subTitle: subTitle)
          );
        });
  }

  showBottomSheet ({required BuildContext context, Color? backgroundColor, bool? cancelable, required Widget dialogContent}){
    return showModalBottomSheet(
        context: context,
        backgroundColor: backgroundColor ?? Colors.white,
        isScrollControlled: true,
        isDismissible: cancelable ?? true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))
        ),
        builder: (BuildContext context){
          return dialogContent;
        }
    );
  }

  bottomSheetWarningDialog({
    required BuildContext context,
    String? imagePath,
    String? title,
    Widget? subTitle,
    String? okButtonText,
    Function? onOkPressed,
    String? cancelButtonText,
    Function? onCancelPressed,
  }) {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        cancelable: false,
        dialogContent: Wrap(
          children: [
            PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, Object? result) {
                if(didPop){
                  return;
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24.h,),

                    imagePath != null && imagePath.toString().trim().isNotEmpty
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h,),
                        Image.asset(imagePath, height: 128.h, fit: BoxFit.fitHeight,),
                        SizedBox(height: 24.h,),
                      ],
                    )
                        : const SizedBox(),

                    title != null && title.toString().trim().isNotEmpty
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RFText(text: title, size: 16.sp, weight: FontWeight.w700),
                        SizedBox(height: 10.h,),
                      ],
                    )
                        : const SizedBox(),

                    subTitle != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitle,
                        SizedBox(height: 64.h,),
                      ],
                    )
                        : const SizedBox(),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cancelButtonText != null
                              ? Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: RFButton(
                                  text: cancelButtonText,
                                  buttonRadius: 8.r,
                                  buttonColor: Colors.white,
                                  borderColor: Colors.red,
                                  textColor: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (onCancelPressed != null) {
                                      onCancelPressed();
                                    }
                                  },
                                ),
                              ))
                              : const SizedBox(),
                          okButtonText != null
                              ? Expanded(
                              flex: 1,
                              child: Padding(
                                padding: cancelButtonText != null ? EdgeInsets.symmetric(horizontal:  0.w) : EdgeInsets.symmetric(horizontal:  48.w),
                                child: RFButton(
                                  text: okButtonText,
                                  buttonRadius: 8.r,
                                  buttonColor: Colors.green,
                                  borderColor: Colors.green,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (onOkPressed != null) {
                                      onOkPressed();
                                    }
                                  },
                                ),
                              ))
                              : const SizedBox(),
                        ],),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
  //endregion

  //region Shared preference
  Future<SharedPreferences> pref() async {
    return await SharedPreferences
        .getInstance();
  }

  prefSetString({required SharedPreferences pref, required String key, required String value}){
    pref.setString(key, value);
  }

  prefSetInt({required SharedPreferences pref, required String key, required int value}){
    pref.setInt(key, value);
  }

  prefSetBool({required SharedPreferences pref, required String key, required bool value}){
    pref.setBool(key, value);
  }

  String? prefGetString({required SharedPreferences pref, required String key}) {
    return pref.getString(key);
  }

  int? prefGetInt({required SharedPreferences pref, required String key}){
    return pref.getInt(key);
  }

  bool? prefGetBool({required SharedPreferences pref, required String key}){
    return pref.getBool(key);
  }

  prefRemove({required SharedPreferences pref, required String key}){
    pref.remove(key);
  }

  prefRemoveAll({required SharedPreferences pref}){
    pref.clear();
  }
  //endregion

  //region Device Info
  // Future<String> getDeviceId() async {
  //   String identifier = '';
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     identifier = iosDeviceInfo.identifierForVendor.toString();
  //   } else if(Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     identifier = androidDeviceInfo.id;
  //   }
  //   return identifier;
  // }
  //endregion

  //region utils
  //region get unique Id
  String getUniqueId() {
    //const String pushChars = '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    const String pushChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      //timeStampChars[i] = pushChars[now % 64];
      timeStampChars[i] = pushChars[now % 62];
      //now = (now / 64).floor();
      now = (now / 62).floor();
    }
    if (now != 0) {
      print("Id should be unique");
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        //lastRandChars.add((Random().nextDouble() * 64).floor());
        lastRandChars.add((Random().nextDouble() * 62).floor());
      }
    } else {
      int i = 0;
      //for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
      for (int i = 11; i >= 0 && lastRandChars[i] == 61; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 12; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }
  //endregion

  //region get Current Date
  String getCurrentDate(){
    return DateFormat("yyyy-MM-dd").format(DateTime.now());
  }
  //endregion

  //region get current time
  String getCurrentTime(){
    return DateFormat("hh:mm a").format(DateTime.now());
  }
  //endregion

  //region add time with targeted time
  String addHoursMinuteToTime({required String hhmmaFormatTime, int? hours, int? minutes}){
    String time = "";
    try {
      final DateFormat timeFormat = DateFormat("hh:mm a");
      DateTime inputDate = timeFormat.parse(hhmmaFormatTime).toLocal().add(Duration(hours: hours ?? 0, minutes: minutes ?? 0));
      time = timeFormat.format(inputDate);
    } catch (e) {
      print(e);
    }
    return time;
  }
  //endregion

  //region return formatted date
  String formattedDateString({required var dateString}){
    String outputDate = '';
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('dd MMM yyyy');
    if (dateString!=null) {
      if (dateString.toString().isNotEmpty) {
        try {
          DateTime inputDate = inputFormat.parse(dateString).toLocal();
          outputDate = outputFormat.format(inputDate);
        } catch (e) {
          print(e);
        }
      }
    }
    return outputDate;
  }
  //endregion

  //region return formatted date
  String sqlFormattedDateString({required var dateString}){
    String outputDate = '';
    final DateFormat inputFormat = DateFormat('dd MMM yyyy');
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    if (dateString!=null) {
      if (dateString.toString().isNotEmpty) {
        DateTime inputDate = inputFormat.parse(dateString).toLocal();
        outputDate = outputFormat.format(inputDate);
      }
    }
    return outputDate;
  }
  //endregion

  //region return string from date (yyyy-MM-dd)
  String stringFromDate({required DateTime date}){
    String dateString = '';
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    dateString = outputFormat.format(date);
    return dateString;
  }
  //endregion

  //region return formatted date
  String formattedDateFromUnknownString({required var dateString}){
    String outputDate = '';
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('dd MMM yyyy');
    if (dateString!=null) {
      if (dateString.toString().isNotEmpty) {
        DateTime dateTime = DateUtils.dateOnly(DateTime.parse(dateString));
        String tempDate = stringFromDate(date: dateTime);
        DateTime inputDate = inputFormat.parse(tempDate).toLocal();
        outputDate = outputFormat.format(inputDate);
      }
    }
    return outputDate;
  }
  //endregion

  //region return Date and time from string
  DateTime dateTimeFromString({required var dateString}){
    DateTime dateTime = DateTime.now();
    if(dateString!=null){
      if (dateString.toString().isNotEmpty) {
        dateTime = DateTime.parse(dateString);
      }
    }
    return dateTime;
  }
  //endregion

  //region TimeOfDay from String
  TimeOfDay? timeOfDayFromString({String? timeString}){
    TimeOfDay? timeOfDay;
    if (timeString != null) {
      if (timeString.toString().trim().isNotEmpty) {
        DateTime dateTime = DateFormat("hh:mm a").parse(timeString);
        timeOfDay = TimeOfDay.fromDateTime(dateTime);
      }
    }
    return timeOfDay;
  }
  //endregion

  //region formatted time from String
  String? getFormattedTimeFromString({String? timeString}){
    String? timeText;
    if (timeString != null) {
      if (timeString.toString().trim().isNotEmpty) {
        DateTime dateTime = DateFormat("hh:mm a").parse(timeString).toLocal();
        timeText = DateFormat("hh:mm a").format(dateTime);
      }
    }
    return timeText;
  }
  //endregion

  //region return Date from string
  DateTime dateFromString({required var dateString}){
    DateTime dateTime = DateUtils.dateOnly(DateTime.now());
    if(dateString!=null){
      if (dateString.toString().isNotEmpty) {
        dateTime = DateUtils.dateOnly(DateTime.parse(dateString));
      }
    }
    return dateTime;
  }
  //endregion

  //region return Date string by adding days
  String dateByAddingDays({String? dateString, int? days}){
    DateTime dateTime = DateUtils.dateOnly(DateTime.now());
    if(dateString!=null){
      if (dateString.toString().isNotEmpty) {
        dateTime = DateUtils.dateOnly(DateTime.parse(dateString));
      }
    }
    if (days != null) {
      dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day+days);
    }
    String finalDateString = stringFromDate(date: dateTime);
    return finalDateString;
  }
//endregion


  Future<Map<String, dynamic>> clearPropertyValue({required Map<String, dynamic> jsonMap, required List<String> properties}) async {
    for(String property in properties){
      jsonMap[property] = null;
    }
    return jsonMap;
  }

  Future<String> checkValidation({required Map<String, dynamic> jsonMap, required List<String> properties}) async {
    String warningMessage = ''; int serial = 0;
    for(String property in properties){
      String name = property; String warning = '';
      if(property.contains('-')){
        name = property.split('-').first;
        warning = property.split('-').last;
      }
      if(jsonMap[name] == null || jsonMap[name]==""){
        serial++;
        if(warningMessage.isNotEmpty){
          if(warning.isNotEmpty){
            warningMessage = '$warningMessage, \n($serial) $warning';
          } else {
            warningMessage = '$warningMessage, \n($serial) $name';
          }
        } else {
          if(warning.isNotEmpty){
            warningMessage = '($serial) $warning';
          } else {
            warningMessage = '($serial) $name';
          }
        }
      }
    }
    if(warningMessage.isNotEmpty){
      warningMessage = 'Please provide following information : \n\n$warningMessage';
    }
    return warningMessage;
  }


//endregion

}