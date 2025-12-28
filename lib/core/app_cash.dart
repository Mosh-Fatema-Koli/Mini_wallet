import 'package:boilerplate_of_cubit/library.dart';

import '../data/model/UserInfo.dart';



class AppCache {

  UserInfo? userInfo;

  static final AppCache _inst = AppCache._internal();

  AppCache._internal();

  factory AppCache({

    UserInfo? userInfo, }) {
    if(userInfo != null){
      _inst.userInfo = userInfo;
    }
    return _inst;
  }

}