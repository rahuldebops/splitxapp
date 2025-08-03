import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/splash/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with BaseScreenView {
  late final SplashViewModel _viewModel;
  late AssetImage myAssetImage;

  @override
  void initState() {
    super.initState();
    myAssetImage = const AssetImage("assets/images/splash.gif");
    _viewModel = ref.read(splashViewModel);
    _viewModel.attachView(this);
    Future.delayed(const Duration(seconds: 3))
        .then((value) async => _viewModel.GoToHome(context, ref));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Hero(
        tag: "splash",
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: myAssetImage,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showSnackbar(String message, {Color? color}) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // TODO: implement showSnackbar
  }

  @override
  void navigateToScreen(AppRoute appRoute, {Map<String, String>? params}) {
    // TODO: implement navigateToScreen
  }

  @override
  void navigateToScreenAsFirst(AppRoute appRoute,
      {Map<String, String>? params}) {
    // TODO: implement navigateToScreenAsFirst
  }
}
