/* import 'package:flutter/material.dart';

class FruitColorizer extends TextEditingController {
  final Map<String, TextStyle> mapping;
  final Pattern pattern;
  final 

  FruitColorizer(this.mapping)
      : pattern =
            RegExp(mapping.keys.map((key) => RegExp.escape(key)).join('|'));

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];
    // splitMapJoin is a bit tricky here but i found it very handy for populating children list
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        children.add(
            TextSpan(text: match[0], style: style.merge(mapping[match[0]])));
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
      },
    );
    return TextSpan(style: style, children: children);
  }
}
 */