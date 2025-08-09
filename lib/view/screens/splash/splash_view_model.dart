import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:splitxapp/domain/provider/user_session_provider.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/models/user_model.dart';
import 'package:splitxapp/services/token_manager.dart';

// Define the enum here or in a separate file
enum SplashNavigation {
  loading,
  goToLogin,
  goToHome,
}

final splashViewModel = ChangeNotifierProvider((ref) => SplashViewModel(ref));

class SplashViewModel extends BaseViewModel {
  final Ref _ref;
  SplashViewModel(this._ref);

  SplashNavigation _navigation = SplashNavigation.loading;
  SplashNavigation get navigation => _navigation;

  // This method now has no BuildContext
  Future<void> checkAuthStatus() async {
    final tokenManager = _ref.read(tokenManagerProvider);
    final token = await tokenManager.getToken();

    if (token == null || token.isEmpty) {
      _navigation = SplashNavigation.goToLogin;
      notifyListeners();
      return;
    }

    if (JwtDecoder.isExpired(token)) {
      final refreshed = await tokenManager.refreshToken();
      if (refreshed) {
        final newToken = await tokenManager.getToken();
        if (newToken != null && await _decodeAndSetUser(newToken)) {
          _navigation = SplashNavigation.goToHome;
        } else {
          _navigation = SplashNavigation.goToLogin;
        }
      } else {
        _navigation = SplashNavigation.goToLogin;
      }
    } else {
      if (await _decodeAndSetUser(token)) {
        _navigation = SplashNavigation.goToHome;
      } else {
        await tokenManager.clearTokens();
        _navigation = SplashNavigation.goToLogin;
      }
    }
    notifyListeners();
  }
  
  Future<bool> _decodeAndSetUser(String token) async {
    try {
      final decoded = JwtDecoder.decode(token);
      final user = UserModel.fromJwt(decoded, token, "");
      _ref.read(userSessionProvider.notifier).setUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
