class ApiException implements Exception {
  final int statusCode;

  final String message;

  ApiException({this.statusCode, this.message});

  String errorMessage() {
    return "Request Error: $statusCode - $message";
  }

  @override
  String toString() {
    return "Request Error: $statusCode - $message";
  }
}