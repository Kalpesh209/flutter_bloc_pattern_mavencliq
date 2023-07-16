

abstract class MavenAPIResponse {
  int statusCode;
  String message;
  MavenAPIResponse({
    required this.statusCode,
    required this.message,
  });
}
