class ApiBaseDataModel {
  final bool status;
  final String? errorMessage;
  final String? successMessage;
  final dynamic data;
  final dynamic xmlData;

  ApiBaseDataModel({
    required this.status,
    this.errorMessage,
    this.successMessage,
    this.data,
    this.xmlData,
  });
}