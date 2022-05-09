List<Map> passwordRules = [
  {
    'name': 'Must not contain your name or email',
    'rule': (String password, String name, String email) {
      return !(password.toLowerCase().contains(name.toLowerCase()) ||
          password.toLowerCase().contains(email.toLowerCase()));
    }
  },
  {
    'name': 'Must have 8 characters with one uppercase letter',
    'rule': (String password, String name, String email) {
      return RegExp("^(?=.*?[A-Z]).{8,}\$").hasMatch(password);
    }
  },
  {
    'name': 'Must contain a special character and a number',
    'rule': (String password, String name, String email) {
      return !RegExp("^[a-zA-Z0-9 ]*\$").hasMatch(password);
    }
  }
];
