import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImage({required bool fromGallery}) async {
    final image = await _picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
    return image;
  }
}
