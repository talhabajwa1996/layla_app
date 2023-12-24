const String getUserDetailsMutation = r'''
  mutation {
    user {
      id
      email
      firstName
      lastName
    }
  }
''';
