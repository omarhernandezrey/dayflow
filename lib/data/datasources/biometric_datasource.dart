import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

/// Datasource for biometric authentication using local_auth.
class BiometricDatasource {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if device supports biometric authentication.
  Future<bool> isDeviceSupported() async {
    return await _localAuth.isDeviceSupported();
  }

  /// Check if any biometrics are enrolled (fingerprint, face, etc.).
  Future<bool> areBiometricsEnrolled() async {
    final available = await _localAuth.getAvailableBiometrics();
    return available.isNotEmpty;
  }

  /// Check if biometrics can be checked.
  Future<bool> canCheckBiometrics() async {
    return await _localAuth.canCheckBiometrics;
  }

  /// Authenticate user with biometrics.
  /// Returns true if authentication succeeded.
  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Autentícate para acceder a DayFlow',
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Verificación biométrica',
            cancelButton: 'Cancelar',
            biometricHint: 'Confirma tu identidad',
            biometricNotRecognized: 'No reconocido, intenta de nuevo',
            biometricRequiredTitle: 'Se requiere biometría',
            biometricSuccess: 'Éxito',
            deviceCredentialsRequiredTitle: 'Credenciales requeridas',
            deviceCredentialsSetupDescription: 'Configura credenciales del dispositivo',
            goToSettingsButton: 'Ir a Configuración',
            goToSettingsDescription: 'Configura biometría en tu dispositivo',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancelar',
            goToSettingsButton: 'Ir a Configuración',
            goToSettingsDescription: 'Configura Face ID/Touch ID en tu dispositivo',
            lockOut: 'Demasiados intentos. Usa contraseña.',
          ),
        ],
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}
