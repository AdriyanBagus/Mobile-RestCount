class AppServices {
  static String getBaseUrl() {
    return 'http://192.168.0.175:5000/';
  }

  static String getDeteksiEndpoint() {
    return '${getBaseUrl()}/';
  }


  static String getLoginEndpoint() {
    return '${getBaseUrl()}/login';
  }

  static String getRegistEndpoint() {
    return '${getBaseUrl()}/register';
  }

  static String getAuthEndpoint() {
    return '${getBaseUrl()}/auth';
  }

  static String getProfileEndpoint(){
    return '${getBaseUrl()}/protected';
  }

  static String getLogoutEndpoint(){
    return '${getBaseUrl()}/logout';
  }

  static String getUpdatePasswordEndpoint(){
    return '${getBaseUrl()}/update_password';
  }

  static String getEditProfileEndpoint(){
    return '${getBaseUrl()}/edit_profile';
  }

  static String getChangeEmailEndpoint(){
    return '${getBaseUrl()}/change_email';
  }

  static String getConfirmChangeEmailEndpoint(){
    return '${getBaseUrl()}/corfirm_change_email';
  }


}