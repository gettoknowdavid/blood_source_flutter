List<Map> passwordRules = [
  {
    'name': 'Not your name or email',
    'rule': (String password, String name, String email) {
      return !(password.toLowerCase().contains(name.toLowerCase()) ||
          password.toLowerCase().contains(email.toLowerCase()));
    }
  },
  {
    'name': '8 characters & 1 uppercase letter',
    'rule': (String password, String name, String email) {
      return RegExp("^(?=.*?[A-Z]).{8,}\$").hasMatch(password);
    }
  },
  {
    'name': 'A special character & a number',
    'rule': (String password, String name, String email) {
      return !RegExp("^[a-zA-Z0-9 ]*\$").hasMatch(password);
    }
  }
];
