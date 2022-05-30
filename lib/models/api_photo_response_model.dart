class ApiPhotoResponseModel {
  String? error;
  List<dynamic>? data;

  ApiPhotoResponseModel({
    this.data,
    this.error,
  });

  ApiPhotoResponseModel.fromJson(List<dynamic> jsonList, String error) {
    data = jsonList;
    error = error;
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'error': error,
      };
}
