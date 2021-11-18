import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es': {
          /** login */
          'login.signInButton': 'Iniciar sesión',
          'login.signUpButton': 'Inscribirse',
          'login.resetPasswordButton': 'Enviar restablecimiento de contraseña',
          'login.emailFormField': 'Correo electrónico',
          'login.passwordFormField': 'Contraseña',
          'login.nameFormField': 'Nombre',
          'login.signInErrorTitle': 'Error',
          'login.signInError':
              'Error de inicio de sesión: correo electrónico o contraseña incorrecta.',
          'login.resetPasswordLabelButton': '¿Se te olvidó tu contraseña?',
          'login.signUpLabelButton': 'Crea una cuenta',
          'login.signUpErrorTitle': 'Registro fallido.',
          'login.signUpError':
              'Hubo un problema registrándolo. Por favor, inténtelo de nuevo más tarde.',
          'login.signInLabelButton': '¿Tener una cuenta? Iniciar sesión.',
          'login.resetPasswordNoticeTitle':
              'Restablecimiento de contraseña Correo electrónico enviado',
          'login.resetPasswordNotice':
              'Revise su correo electrónico y siga las instrucciones para restablecer su contraseña.',
          'login.resetPasswordFailed':
              'Falló el correo electrónico de restablecimiento de la contraseña',
          'login.signInonResetPasswordLabelButton': 'Iniciar sesión',
          'login.updateUser': 'Actualización del perfil',
          'login.updateUserSuccessNoticeTitle': 'Usuario actualizado',
          'login.updateUserSuccessNotice':
              'Información del usuario actualizada con éxito.',
          'login.updateUserEmailInUse':
              'Esa dirección de correo electrónico ya tiene una cuenta.',
          'login.updateUserFailNotice': 'Error al actualizar el usuario',
          'login.enterPassword': 'Ingresa tu contraseña',
          'login.cancel': 'Cancelar',
          'login.submit': 'Enviar',
          'login.changePasswordLabelButton': 'Cambiar la contraseña',
          'login.resetPasswordTitle': 'Restablecer la contraseña',
          'login.updateProfileTitle': 'Actualización del perfil',
          'login.wrongPasswordNoticeTitle': 'Error de inicio de sesion',
          'login.wrongPasswordNotice':
              'La contraseña no coincide con nuestros registros.',
          'login.unknownError': 'Error desconocido',
          /** validator */
          'validator.email':
              'Por favor, introduce una dirección de correo electrónico válida.',
          'validator.password':
              'La contraseña debe tener al menos 6 caracteres.',
          'validator.name': 'Por favor ingrese un nombre.',
          'validator.number': 'Por favor, introduzca un número.',
          'validator.notEmpty': 'Este es un campo obligatorio.',
          'validator.amount':
              'Por favor ingrese un número I.E. 250 - Sin símbolo de dólar y sin centavos',
          /** settings */
          'settings.title': 'Ajustes',
          'settings.language': 'Idioma',
          'settings.theme': 'Tema',
          'settings.signOut': 'Desconectar',
          'settings.dark': 'Oscuro',
          'settings.light': 'Luz',
          'settings.system': 'Sistema',
          'settings.updateProfile': 'Actualización del perfil',
          /** home */
          'home.title': 'Jugadores',
          'home.namePlayer': 'Nombre Jugador',
          'home.title': 'Inicio',
          /** tournamentDashboard */
          'tournamentDashboard.title': 'Tablero de torneos',
          'tournamentDashboard.date': 'Fecha',
          'tournamentDashboard.hour': 'Hora',
          'tournamentDashboard.numEquipment': 'N° de Equipos',
          'tournamentDashboard.location': 'Ubicación',
          'tournamentDashboard.detail': 'Detalle',
          'tournamentDashboard.saved': 'Guardar',
        },
        'en': {
          /** login */
          'login.signInButton': 'Log in',
          'login.signUpButton': 'Register',
          'login.resetPasswordButton': 'Send reset password',
          'login.emailFormField': 'Email',
          'login.passwordFormField': 'Password',
          'login.nameFormField': 'Name',
          'login.signInErrorTitle': 'Error',
          'login.signInError': 'Logon error: Email or incorrect password.',
          'login.resetPasswordLabelButton': 'Did you forget your password?',
          'login.signUpLabelButton': 'Create an account',
          'login.signUpErrorTitle': 'Sign up failed.',
          'login.signUpError':
              'There was a problem registering it. Please try again later.',
          'login.signInLabelButton': 'Have an account? Log in.',
          'login.resetPasswordNoticeTitle': 'Password restoration Email sent',
          'login.resetPasswordNotice':
              'Review your email and follow the instructions to reset your password.',
          'login.resetPasswordFailed': 'The password restoration email failed',
          'login.signInonResetPasswordLabelButton': 'Log in',
          'login.updateUser': 'Profile update',
          'login.updateUserSuccessNoticeTitle': 'Updated User.',
          'login.updateUserSuccessNotice':
              'User information updated successfully.',
          'login.updateUserEmailInUse':
              'That email address already has an account.',
          'login.updateUserFailNotice': 'Error updating the user',
          'login.enterPassword': 'Enter your password.',
          'login.cancel': 'Cancel',
          'login.submit': 'Send',
          'login.changePasswordLabelButton': 'Change Password',
          'login.resetPasswordTitle': 'Reset your password',
          'login.updateProfileTitle': 'Profile update',
          'login.wrongPasswordNoticeTitle': 'Login error',
          'login.wrongPasswordNotice':
              'The password does not match our records.',
          /** validator */
          'validator.email': 'Please enter a valid email address.',
          'validator.password': 'The password must be at least 6 characters.',
          'validator.name': 'Please enter a name.',
          'validator.number': 'Please enter a number.',
          'validator.notEmpty': 'This is a mandatory field.',
          'validator.amount':
              'Please enter a number i.e. 250 - No symbol of dollar and without cents',
          /** settings */
          'settings.title': 'Settings',
          'settings.language': 'Idiom',
          'settings.theme': 'Theme',
          'settings.signOut': 'Disconnect',
          'settings.dark': 'Dark',
          'settings.light': 'Light',
          'settings.system': 'System',
          'settings.updateProfile': 'Profile update',
        },
      };
}
