import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickAvatar() async {
  var res = await ImagePicker().getImage(source: ImageSource.gallery);

  return res != null ? File(res.path) : null;
}
