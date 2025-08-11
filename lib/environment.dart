import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/app.dart';
import 'package:splitxapp/services/shared_preference_service.dart';
import 'package:splitxapp/utils/logger.dart';

enum EnvType {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
}

class Environment {
  Environment() {
    // value = this;
    _init();
  }

  Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferenceService.init();

    try {
      
    } catch (e) {
      Logger.write(e.toString());
    }
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiMode.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    });
  }
}
