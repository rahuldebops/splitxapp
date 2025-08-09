// services/token_manager.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/core/api_client.dart'; // We'll need ApiClient for the refresh call
import 'package:splitxapp/domain/provider/api_client_provider.dart';
import 'package:splitxapp/services/token_service.dart';

// We need to pass the ref to the provider to access other providers
final tokenManagerProvider = Provider<TokenManager>((ref) {
  return TokenManager(ref);
});

class TokenManager {
  final Ref _ref;
  TokenManager(this._ref);

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await TokenService.saveTokens(
        accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<String?> getToken() async => await TokenService.getAccessToken();

  Future<void> clearTokens() async => await TokenService.clearTokens();

  /// Proactively refreshes the token. Returns true on success.
  /// This can be called from the splash screen or anywhere else.
  Future<bool> refreshToken() async {
    // We get a fresh instance of ApiClient to make the call
    final apiClient = _ref.read(apiClientProvider);
    // The actual refresh logic is already in ApiClient, we just expose it
    // Note: We're calling the internal method here. A cleaner way would be to
    // extract the refresh logic from ApiClient into this TokenManager entirely.
    // For simplicity, we'll call it this way.
    // Let's create a public method in ApiClient for this.
    return await apiClient.tryRefreshToken();
  }

  
}
