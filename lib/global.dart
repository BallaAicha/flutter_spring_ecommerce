

import 'package:flutter/cupertino.dart';

import 'common/service/storage_service.dart';



class Global{
  static late StorageService storageService;
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();//permet de



    storageService = await StorageService().init();

  }
}