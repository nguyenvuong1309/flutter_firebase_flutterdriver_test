// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Todo App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    //login screen
    final usernameField = find.byValueKey('username');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('signIn');
    final createAccountButton = find.byValueKey('createAccount');

    //home screen
    final signOutButton = find.byValueKey('signOut');
    final addField = find.byValueKey('addField');
    final addButton = find.byValueKey('addButton');

    const timeInterval = 1000; // 1s
    const duration = 20; // 10s
    const emailTest = "tadas@gmail.com";
    const passwordTest = "123456";

    FlutterDriver? driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: duration)}) async {
      try {
        await driver?.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver?.tap(signOutButton);
      }

      await driver?.tap(usernameField);
      await Future.delayed(const Duration(microseconds: timeInterval));

      await driver?.enterText(emailTest);
      await Future.delayed(const Duration(microseconds: timeInterval));

      await driver?.tap(passwordField);
      await Future.delayed(const Duration(microseconds: timeInterval));

      await driver?.enterText(passwordTest);
      await Future.delayed(const Duration(microseconds: timeInterval));

      await driver?.tap(createAccountButton);
      await Future.delayed(const Duration(microseconds: timeInterval));

      await driver?.waitFor(find.text("Your Todos"));
      await Future.delayed(const Duration(microseconds: timeInterval));

    });

    test('login', () async {
      if (await isPresent(signOutButton)) {
        await driver?.tap(signOutButton);
      }
      
      await Future.delayed(const Duration(microseconds: timeInterval));
      await driver?.tap(usernameField);
      await driver!.enterText(emailTest);

      await Future.delayed(const Duration(microseconds: timeInterval));
      await driver!.tap(passwordField);
      await driver!.enterText(passwordTest);

      await Future.delayed(const Duration(microseconds: timeInterval));
      await driver!.tap(signInButton);
      await driver!.waitFor(find.text("Your Todos"));
    });

    test('add a todo', () async {
      if (await isPresent(signOutButton)) {

        await Future.delayed(const Duration(microseconds: timeInterval));
        await driver!.tap(addField);
        await driver!.enterText("make an integration test video");

        await Future.delayed(const Duration(microseconds: timeInterval));
        await driver!.tap(addButton);

        await driver!.waitFor(find.text("make an integration test video"),
            timeout: const Duration(seconds: 3));
      }
    });
  });
}
