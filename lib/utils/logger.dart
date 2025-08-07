import 'dart:convert';

class Logger {
  static void write(String text, {bool isError = false}) {
    print('** $text [$isError]');
  }

  static String buildCurlCommand({
    required String method,
    required String url,
    required Map<String, String> headers,
    dynamic body,
  }) {
    final buffer = StringBuffer();
    buffer.write("curl -X $method");

    headers.forEach((key, value) {
      buffer.write(" -H '${key}: $value'");
    });

    if (body != null) {
      final encodedBody = body is String ? body : jsonEncode(body);
      buffer.write(" -d '${encodedBody.replaceAll("'", r"'\''")}'");
    }

    buffer.write(" '$url'");

    return buffer.toString();
  }
}
