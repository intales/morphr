import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

class FigmaTreeView extends StatelessWidget {
  const FigmaTreeView({
    super.key,
    required this.document,
    this.title,
    this.initiallyExpanded = false,
  });

  final figma.Document document;
  final String? title;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          _buildDocumentTree(document),
        ],
      ),
    );
  }

  Widget _buildDocumentTree(figma.Document document) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NodeTile(
          node: document,
          depth: 0,
          initiallyExpanded: initiallyExpanded,
        ),
      ],
    );
  }
}

class _NodeTile extends StatefulWidget {
  final figma.Node node;
  final int depth;
  final bool initiallyExpanded;

  const _NodeTile({
    required this.node,
    required this.depth,
    this.initiallyExpanded = false,
  });

  @override
  State<_NodeTile> createState() => _NodeTileState();
}

class _NodeTileState extends State<_NodeTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final children = _getChildNodes(widget.node);
    final hasChildren = children != null && children.isNotEmpty;
    final nodeType = widget.node.runtimeType.toString();

    final nodeId = widget.node.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap:
              hasChildren
                  ? () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }
                  : null,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.0 + (widget.depth * 24.0),
              top: 8.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                if (hasChildren)
                  Icon(
                    _isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 16,
                  )
                else
                  const SizedBox(width: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.node.name ?? 'Unnamed Node',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            nodeType,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'ID: $nodeId',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      if (widget.node is figma.Text)
                        Text(
                          'Text: "${(widget.node as figma.Text).characters ?? ''}"',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded && hasChildren)
          ...children
              .where((child) => child != null)
              .map(
                (child) => _NodeTile(
                  node: child!,
                  depth: widget.depth + 1,
                  initiallyExpanded: widget.initiallyExpanded,
                ),
              ),
      ],
    );
  }

  List<figma.Node?>? _getChildNodes(figma.Node node) {
    if (node is figma.Document) return node.children;
    if (node is figma.Canvas) return node.children;
    if (node is figma.Frame) return node.children;
    if (node is figma.Group) return node.children;
    if (node is figma.Instance) return node.children;
    return null;
  }
}
