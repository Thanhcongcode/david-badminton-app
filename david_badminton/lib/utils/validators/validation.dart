class Validation {
  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập Tên đăng nhập';
    }

    final userNameRegExp = RegExp('([a-zA-Z])');

    if (!userNameRegExp.hasMatch(value)) {
      return 'Tên đăng nhập không hợp lệ';
    }

    return null;
  }

  static String? validateEmtyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }

    // if (value.length < 5) {
    //   return '$fieldName phải trên 5 ký tự';
    // }
    return null;
  }
}
