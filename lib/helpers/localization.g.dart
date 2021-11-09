import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es': {
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
        },
        'en': {
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
        },
      };
}
