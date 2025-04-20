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
      
      // Check if the response contains a token
      if (response['token'] != null) {
        return response['token'];
      }
      
      // If no token but registration was successful
      if (response['message'] == 'User registered successfully') {
        return 'registration_successful';
      }
      
      throw Exception('Unexpected response format');
    } catch (e) {
      // If the error is about user already existing
      if (e.toString().contains('user with this email already exists')) {
        throw Exception('Email already exists');
      }
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
}
