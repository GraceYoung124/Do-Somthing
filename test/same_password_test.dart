import 'package:flutter_test/flutter_test.dart';
import 'package:do_something/signup_page.dart';

void main() {
  test(
    'Test that the password and the repeat password label are the same password',
        () {
      String pass = 'password';
      String otherPass = 'password';
      String otherPassWrong = 'pasword';
      bool test1 = testSamePass(pass, otherPassWrong);
      bool test2 = testSamePass(pass, otherPass);
      expect(test1, false);
      expect(test2, true);
    },
  );
}
