import 'package:flutter/foundation.dart';
import '../../../core/utils/dependency_injection.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authRepository.signInWithEmailAndPassword(
        email,
        password,
      );
      _isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authRepository.registerWithEmailAndPassword(
        email,
        password,
      );
      _isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

