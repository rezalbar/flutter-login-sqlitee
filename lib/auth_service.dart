import 'database_helper.dart';

class AuthService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<String> signUp(String email, String password) async {
    try {
      await _dbHelper.insertUser(email, password);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    bool isValid = await _dbHelper.validateUser(email, password);
    if (isValid) {
      return {'status': 'Success', 'email': email};
    } else {
      // Check if user exists
      final user = await _dbHelper.getUser(email);
      if (user == null) {
        return {'status': 'User not found'};
      } else {
        return {'status': 'Invalid password'};
      }
    }
  }
}