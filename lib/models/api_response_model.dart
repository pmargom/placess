class ApiResponseModel {
  String? error;
  dynamic results;

  ApiResponseModel({
    this.results,
    this.error,
  });

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() => {
        'results': results,
        'error': error,
      };
}
