class ErrorModel {
  final bool success;
  final ErrorServerModel error;

  ErrorModel({
    required this.success,
    required this.error,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        success: json["success"],
        error: ErrorServerModel.fromJson(json["error"]),
      );

  @override
  String toString() => '$success, $error';
}

class ErrorServerModel {
  final int code;
  final String message;

  ErrorServerModel({
    required this.code,
    required this.message,
  });

  factory ErrorServerModel.fromJson(Map<String, dynamic> json) => ErrorServerModel(
        code: json["code"],
        message: json["message"],
      );

  @override
  String toString() => '$code, $message';
}
