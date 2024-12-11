import 'package:figma/figma.dart' as figma;

class FigmaService {
  FigmaService._();
  static final instance = FigmaService._();

  late final figma.FigmaClient _client;
  late final figma.Document? _document;
  late final String _fileId;

  Future<void> initialize({
    required final String accessToken,
    required final String fileId,
  }) async {
    _client = figma.FigmaClient(accessToken);
    _fileId = fileId;
    await _loadDocument();
  }

  figma.Node? getComponent(final String componentId) {
    if (_document == null) {
      throw StateError("FigmaService not initialized.");
    }

    return _findComponent(_document, componentId);
  }

  Future<void> _loadDocument() async {
    final file = await _client.getFile(_fileId);
    _document = file.document;
  }

  figma.Node? _findComponent(figma.Node node, String componentId) {
    if (node.name == componentId) {
      return node;
    }

    final nodes = _getChildNodes(node);
    if (nodes != null) {
      for (final child in nodes) {
        if (child == null) continue;

        final result = _findComponent(child, componentId);
        if (result != null) {
          return result;
        }
      }
    }

    return null;
  }

  List<figma.Node?>? _getChildNodes(figma.Node node) {
    if (node is figma.Document) return node.children;
    if (node is figma.Canvas) return node.children;
    if (node is figma.Frame) return node.children;
    return null;
  }

  Future<void> reload() async {
    await _loadDocument();
  }

  void clear() {
    _document = null;
  }
}
