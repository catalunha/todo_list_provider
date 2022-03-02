import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null && infoMessage!.isNotEmpty;

  Future<void> loginGoogle() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.loginGoogle();
      if (user != null) {
        success();
      } else {
        _userService.logoutGoogle();
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e, s) {
      _userService.logoutGoogle();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, password);
      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e, s) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu email.';
    } on AuthException catch (e, s) {
      setError(e.message);
    } catch (e) {
      setError('Erro desconhecido ao reset senha.');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
