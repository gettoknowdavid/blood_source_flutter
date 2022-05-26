import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class MediaService with ReactiveServiceMixin {
  MediaService() {
    listenToReactiveValues([_image]);
  }

  final ImagePicker _picker = ImagePicker();

  final ReactiveValue<XFile?> _image = ReactiveValue<XFile?>(null);
  XFile? get image => _image.value;

  Future<XFile?> getImage({required bool fromGallery}) async {
    _image.value = await _picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
    return _image.value;
  }
}
