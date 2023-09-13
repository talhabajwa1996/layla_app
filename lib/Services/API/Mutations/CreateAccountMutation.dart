const String createAccountMutation = r'''
mutation customerCreate($input: CustomerCreateInput!) {
  customerCreate(input: $input) {
    customerUserErrors {
      code
      field
      message
    }
    customer {
      id
      firstName
      lastName
      email
    }
  }
}
''';