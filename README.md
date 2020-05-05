# Gap
Flutter widgets for easily adding gaps inside Flex widgets such as Columns and Rows.

[![Pub](https://img.shields.io/pub/v/gap.svg)](https://pub.dartlang.org/packages/gap)

### Introduction

When it comes to add empty space between widgets inside a `Column` or a `Row`, we have multiple options:
- We can either add a `Padding` around these widgets but it's very verbose
- Or we can add `SizedBox` widgets between them.

`Gap` is another option. It's like `SizedBox` but you don't have to know if it's inside a `Row` or a `Column`. So that it's less verbose than using a `SizedBox`.

## Getting started

In your library add the following import:

```dart
import 'package:gap/gap.dart';
```

Then you just have to add a `Gap` inside a `Column` or a `Row` with the specified extent.

```dart
return Column(
  children: <Widget>[
    Container(color: Colors.red, height: 20),
    const Gap(20), // Adds an empty space of 20 pixels.
    Container(color: Colors.red, height: 20),
  ],
);
```

### MaxGap

This package also comes with a `MaxGap` widget.
The `MaxGap` widget will try to fill the available space in a `Column` or a `Row` with the specified size. If the available space
is lesser than the specified size, the `MaxGap` widget will only take the available space.

It's useful when you want to have a gap that shrinks to avoid an overflow otherwise.

### Other parameters

By default a `Gap` will have no extent in the opposite direction of the `Flex` parent.
If you want the `Gap` to have a color, you'll have to set the `color` and the `crossAxisExtent` parameters.
You can also use the `Gap.expand` constructor to expand the `Gap` in the opposite direction of the `Flex` parent.

## Changelog

Please see the [Changelog](https://github.com/letsar/gap/blob/master/CHANGELOG.md) page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/letsar/gap/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/letsar/gap/pulls).

