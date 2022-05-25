import 'package:image_picker/image_picker.dart';

class MediaService {
  ImagePicker picker = ImagePicker();

  Future<XFile?> getImage({required bool fromGallery}) {
    return picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
  }
}
