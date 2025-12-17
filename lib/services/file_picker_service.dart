
import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<FilePickerResult?> pickFiles() async {
    return await FilePicker.platform.pickFiles();
  }
}
