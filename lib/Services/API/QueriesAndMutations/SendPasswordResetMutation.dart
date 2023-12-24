const String sendPasswordResetMutation =
    r'''mutation SendPasswordResetEmail($email: String!) {
  customerRecover(email: $email) {
    customerUserErrors {
      code
      message
    }
    userErrors {
      message
    }
  }
}''';
