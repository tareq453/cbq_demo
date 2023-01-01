abstract class BaseApiService {
  final String baseUrl = "jsonplaceholder.typicode.com";

  Future<dynamic> getResponse(
      {required String endpoint, Map<String, Object>? query});

  Future<dynamic> postResponse(String endpoint, Map<String, dynamic> data);

  Future<dynamic> patchResponse(String endpoint, Map<String, dynamic> data);

  Future<dynamic> deleteResponse(
      {required String endpoint, required String id});
}
