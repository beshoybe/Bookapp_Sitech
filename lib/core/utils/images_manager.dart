import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

String iconsPath = "assets/icons";

class IconsManager {
  static String search = "$iconsPath/search.png";
  static String sort = "$iconsPath/sort.png";
  static String bookmark = "$iconsPath/bookmark.png";
}

class ImagesManager {
  static Future<File> fileFromImageUrl(String url, String id) async {
    final response = await http.get(Uri.parse(url));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, '$id.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }
}
