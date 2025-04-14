import 'package:flutter/material.dart';
import 'package:morphr/components/figma_list_component.dart';
import 'package:morphr/transformers/core/node_selector.dart';
import 'package:morphr/transformers/core/node_transformer.dart';

/// A transformer that converts a Figma node into a dynamic list.
///
/// This transformer uses [FigmaListComponent] to render a scrollable list
/// based on a data source. Each item in the list is rendered using the
/// provided [itemBuilder] function.
class ListTransformer<T> extends NodeTransformer {
  /// The list of data items to display.
  final List<T> items;

  /// The scroll direction of the list.
  final Axis scrollDirection;

  /// Whether the list should shrink to its content.
  final bool shrinkWrap;

  /// Creates a transformer that renders a data list using a Figma node as template.
  ///
  /// The [selector] determines which node will be used as the list container.
  /// The [items] are the data items to display in the list.
  /// The [itemBuilder] builds each list item widget using the provided data.
  /// The [scrollDirection] determines if the list scrolls horizontally or vertically.
  /// Set [shrinkWrap] to true if the list should be sized to its content.
  ListTransformer({
    required super.selector,
    required this.items,
    required Widget Function(BuildContext context, int index, T item)
    itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    super.childTransformers = const [],
  }) : super(
         transform: (context, widget) {
           return FigmaListComponent(
             context.node.name!,
             itemCount: items.length,
             itemBuilder:
                 (listContext, index) =>
                     itemBuilder(listContext, index, items[index]),
             scrollDirection: scrollDirection,
             shrinkWrap: shrinkWrap,
           );
         },
       );

  /// Factory method to create a list transformer for nodes with a specific name.
  factory ListTransformer.byName(
    String name, {
    required List<T> items,
    required Widget Function(BuildContext context, int index, T item)
    itemBuilder,
    Axis scrollDirection = Axis.vertical,
    bool shrinkWrap = false,
    bool exact = true,
  }) {
    return ListTransformer<T>(
      selector: NameSelector(name, exact: exact),
      items: items,
      itemBuilder: itemBuilder,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
    );
  }
}
