import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AuthService with ReactiveServiceMixin {
  AuthService() {
    listenToReactiveValues([_isAuth]);
  }

  final Logger? _log = Logger();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final StoreService _storeService = locator<StoreService>();
  // final StorageService _storageService = locator<StorageService>();

  final ReactiveValue<bool?> _isAuth = ReactiveValue<bool?>(null);
  bool? get isAuth => _isAuth.value;

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  String? get userUid {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<String>? get userToken {
    return _firebaseAuth.currentUser?.getIdToken();
  }

  Future<AuthResult> signIn(String email, String password) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        _isAuth.value = true;
        final _storeResult = await _populateBloodSourceUser(value.user);
        return AuthResult(user: value.user, bSUser: _storeResult);
      }).timeout(const Duration(seconds: 6));
    } on FirebaseAuthException catch (e) {
      _log?.e('A firebase exception has occurred. $e');
      return AuthResult.error(
        exceptionCode: e.code.toLowerCase(),
        errorMessage: getErrorMessage(e),
      );
    } on Exception catch (e) {
      _log?.e('A general exception has occurred. $e');
      return AuthResult.error(
        errorMessage: 'Seems like we an issue. Please try again.',
      );
    }
  }

  Future<AuthResult> signUp({
    required String name,
    required String email,
    required String password,
    UserType userType = UserType.donor,
    bool isDonorFormComplete = false,
    Gender gender = Gender.none,
  }) async {
    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((result) async {
        _isAuth.value = true;

        await _firebaseAuth.currentUser!.updateDisplayName(name);

        final _user = BloodSourceUser(
          uid: result.user!.uid,
          name: name,
          email: email,
          userType: userType,
          isDonorFormComplete: isDonorFormComplete,
          gender: gender,
          initEdit: 0,
        );

        final _storeResult = await _storeService.createBloodSourceUser(_user);

        return AuthResult(user: result.user, bSUser: _storeResult.bSUser);
      }).timeout(const Duration(seconds: 8));
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(
        errorMessage: getErrorMessage(e),
        exceptionCode: e.code,
      );
    } on Exception catch (e) {
      _log?.e('A general exception has occurred. $e');
      return AuthResult.error(
        errorMessage: 'Seems like we an issue. Please try again.',
      );
    }
  }

  Future<bool?> isSignedIn() async {
    bool? value;
    _firebaseAuth.authStateChanges().listen((User? user) async {
      await _populateBloodSourceUser(user);
      if (user != null) {
        value = true;
        _isAuth.value = value;
      }

      if (user == null) {
        value = false;
        _isAuth.value = value;
      }
    });
    return value;
  }

  bool get hasUser {
    return _firebaseAuth.currentUser != null;
  }

  Future singOut() async {
    _log?.i('');

    try {
      await _firebaseAuth.signOut();
      _isAuth.value = false;
    } catch (e) {
      _log?.e('Could not sign out. $e');
    }
  }

  Future<BloodSourceUser?> _populateBloodSourceUser(User? user) async {
    if (user != null) {
      StoreResult? _result = await _storeService.getUser(user.uid);
      return _result!.bSUser;
    }
    return null;
  }
}

class AuthResult {
  /// Firebase user
  final User? user;
  final BloodSourceUser? bSUser;

  /// Contains the error message for the request
  final String? errorMessage;
  final String? exceptionCode;

  AuthResult({this.user, this.bSUser})
      : errorMessage = null,
        exceptionCode = null;

  AuthResult.error({this.errorMessage, this.exceptionCode})
      : user = null,
        bSUser = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}

String getErrorMessage(FirebaseAuthException exception) {
  switch (exception.code.toLowerCase()) {
    case 'email-already-in-use':
      return 'An account with this email already exists.\n Try signing in.';
    case 'invalid-email':
      return 'The email you\'re using is invalid. Please use a valid email.';
    case 'operation-not-allowed':
      return 'The authentication is not enabled on Firebase.';
    case 'weak-password':
      return 'Your password is too weak. Please use a stronger password.';
    case 'wrong-password':
      return "Urm, wrong email or password";
    case 'user-not-found':
      return 'Oops! We have no record of this user';
    default:
      return exception.message ??
          'Something went wrong on our side. Please try again';
  }
}
