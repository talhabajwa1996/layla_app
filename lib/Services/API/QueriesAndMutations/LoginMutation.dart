const String loginMutation = r'''mutation SignInWithEmailAndPassword(
    $email: String!, 
    $password: String!,
) {
    customerAccessTokenCreate(input: { 
        email: $email, 
        password: $password,
    }) {
        customerAccessToken {
            accessToken
            expiresAt
        }
        customerUserErrors {
            code
            message
        }
    }
}''';