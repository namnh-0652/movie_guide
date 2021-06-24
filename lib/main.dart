import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movieguide/app_binding.dart';
import 'package:movieguide/data/repository/local/api/db/app_database.dart';
import 'package:movieguide/data/repository/local/api/db/impl/app_database_impl.dart';

import 'presentation/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: find the better way ???
  await Get.put<AppDatabase>(AppDataBaseImpl.instance).init();
  runApp(
    GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
    ),
  );
}
