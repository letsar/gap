import 'package:flutter/material.dart';

import 'widgets/gap.dart';

extension GapPackageListExtension<T extends Widget> on List<T> {
  List<Widget> gap(double mainAxisExtent) {
    return _gap(mainAxisExtent).toList();
  }

  Iterable<Widget> _gap(double mainAxisExtent) sync* {
    final maxIndex = length - 1;
    for (var i = 0; i <= maxIndex; i++) {
      yield elementAt(i);
      if (i != maxIndex) {
        yield Gap(mainAxisExtent);
      }
    }
  }
}
