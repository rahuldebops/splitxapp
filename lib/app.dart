import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitxapp/domain/provider/router_provider.dart';
import 'package:splitxapp/utils/themes.dart';



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routeInformationParser: goRouter.routeInformationParser,
          routerDelegate: goRouter.routerDelegate,
          routeInformationProvider: goRouter.routeInformationProvider,
          theme: AppThemes.lightTheme.copyWith(
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.light,
          
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}