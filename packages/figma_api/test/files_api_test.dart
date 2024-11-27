import 'package:test/test.dart';
import 'package:figma_api/figma_api.dart';


/// tests for FilesApi
void main() {
  final instance = FigmaApi().getFilesApi();

  group(FilesApi, () {
    // Get file JSON
    //
    //Future<GetFile200Response> getFile(String fileKey) async
    test('test getFile', () async {
      // TODO
    });

    // Get images
    //
    //Future<GetImages200Response> getImages(String fileKey, String ids, { num scale, String format }) async
    test('test getImages', () async {
      // TODO
    });

  });
}
