import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitxapp/domain/provider/router_provider.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/utils/themes.dart';
import 'package:dynamic_color/dynamic_color.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            final lightColorScheme =
                lightDynamic ?? ColorScheme.fromSeed(seedColor: kPrimaryColor);
            final darkColorScheme =
                darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: kPrimaryColor,
                  brightness: Brightness.dark,
                );

            return MaterialApp.router(
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
              routeInformationProvider: goRouter.routeInformationProvider,
              theme: AppThemes.lightTheme.copyWith(
                colorScheme: lightColorScheme,
              ),
              darkTheme: AppThemes.lightTheme.copyWith(
                brightness: Brightness.dark,
                colorScheme: darkColorScheme,
              ),
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
