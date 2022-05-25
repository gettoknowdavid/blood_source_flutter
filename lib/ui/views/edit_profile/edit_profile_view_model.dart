import 'dart:io';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/media_service.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends FutureViewModel<BloodSourceUser>
    with ReactiveServiceMixin {
  EditProfileViewModel() {
    listenToReactiveValues([_image]);
  }
  final StoreService _storeService = locator<StoreService>();
  final StorageService _storageService = locator<StorageService>();
  final AuthService _authService = locator<AuthService>();
  final MediaService _mediaService = locator<MediaService>();

  final ReactiveValue<File?> _image = ReactiveValue<File?>(null);
  File? get image => _image.value;

  void getImage() async {
    final _pickedFile = await _mediaService.getImage(fromGallery: true);

    if (_pickedFile != null) {
      _image.value = File(_pickedFile.path);
    } else {
      print('No image selected.');
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {}

  Future<BloodSourceUser> getProfile() async {
    final result = await _storeService.getUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return result!.bSUser!;
  }

  @override
  Future<BloodSourceUser> futureToRun() async => await getProfile();
}
