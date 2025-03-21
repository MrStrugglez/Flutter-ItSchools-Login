/// An extension on the `Uri` class that provides predefined endpoints
/// for interacting with the IT School API.
extension UriEndpoints on Uri {
  static Uri get itSchoolLoginPath =>
      Uri.parse('https://app.dev.it.si/unity/api/1.0/login');

  static Uri getItSchoolUserGroupsPath(String username) => Uri.parse(
    "https://app.dev.it.si/unity/api/1.0/users/$username/enrolment",
  );
}
