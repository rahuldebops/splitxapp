import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:splitxapp/models/user_model.dart';
import 'package:splitxapp/domain/provider/user_session_provider.dart';

Future<bool> decodeAndSetUserFromToken({
  required String token,
  required Ref ref, 
}) async {
  try {
    if (JwtDecoder.isExpired(token)) return false;

    final decoded = JwtDecoder.decode(token);
    final user = UserModel.fromJwt(decoded, token, "");

    ref.read(userSessionProvider.notifier).setUser(user); // Still valid
    return true;
  } catch (_) {
    return false;
  }
}

