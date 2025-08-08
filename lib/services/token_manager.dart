import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/services/token_service.dart';

final tokenManagerProvider = Provider<TokenManager>((ref) => TokenManager());

class TokenManager {
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await TokenService.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<String?> getToken() async => await TokenService.getAccessToken();

  Future<void> clearTokens() async => await TokenService.clearTokens();
}
