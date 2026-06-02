abstract final class Validators {
  static bool isValidEmail(String email) {
    final pattern = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,}$');
    return pattern.hasMatch(email.trim());
  }

  static bool isValidPassword(String password) => password.length >= 6;

  static bool isNotEmpty(String value) => value.trim().isNotEmpty;

  static bool isPositive(double value) => value > 0;

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'El correo es obligatorio';
    if (!isValidEmail(value)) return 'Correo electrónico inválido';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
    return null;
  }
}