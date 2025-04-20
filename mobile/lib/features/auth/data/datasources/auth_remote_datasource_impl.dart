import 'package:mobile/core/network/api_client.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _apiClient.post('/login', {
        'email': email,
        'password': password,
      });
      return response['token'];
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }

  @override
  Future<String> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post('/register', {
        'username': username,
        'email': email,
        'password': password,
      });
      return response['token'];
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
}
