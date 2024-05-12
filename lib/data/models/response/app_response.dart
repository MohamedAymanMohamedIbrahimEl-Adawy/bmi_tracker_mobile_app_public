class AppResponse {
  dynamic data;
  final bool hasError;
  String? message;

  AppResponse({
    this.data,
    required this.hasError,
    this.message,
  });

  factory AppResponse.withSuccess({
    dynamic data,
    String? message,
  }) {
    return AppResponse(
      hasError: false,
      data: data,
      message: message,
    );
  }

  factory AppResponse.withError({
    dynamic data,
    String? message,
  }) {
    return AppResponse(
      hasError: true,
      data: data,
      message: message,
    );
  }
}
