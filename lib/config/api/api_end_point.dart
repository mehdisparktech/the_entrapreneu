class ApiEndPoint {
  static const baseUrl = "http://10.10.7.46:5001/api/v1";
  static const imageUrl = "http://10.10.7.46:5000";
  static const socketUrl = "http://10.10.7.46:5001";

  static const signUp = "users/sign-up";
  static const verifyEmail = "users/verify-email";
  static const signIn = "auth/login";
  static const forgotPassword = "auth/forgot-password";
  static const verifyOtp = "auth/verify-email";
  static const resetPassword = "users/reset-password";
  static const changePassword = "users/change-password";
  static const user = "user/profile";
  static const notifications = "notifications";
  static const privacyPolicies = "privacy-policies";
  static const termsOfServices = "terms-and-conditions";
  static const chats = "chats";
  static const messages = "messages";
}
