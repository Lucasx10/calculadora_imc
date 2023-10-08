import 'package:dioproject/models/imc_hive_model.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(ImcHiveModelAdapter());
  runApp(const MyApp());
}