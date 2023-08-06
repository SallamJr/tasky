import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'injector.dart' as injector;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = storage;
  runApp(
    const MyApp(),
  );
}
