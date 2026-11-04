## 3.1.0
### Added
- `AnimatedGap` and `SliverAnimatedGap` (See https://github.com/letsar/gap/pull/8)

### Fixed
- Gap can be used directly inside a `Wrap` (See https://github.com/letsar/gap/issues/22). A Gap inside a Wrap inside a scrollable now follows the Wrap's direction instead of the scrollable's.
- Gap can be used inside a `WidgetSpan` (See https://github.com/letsar/gap/issues/27). It is always horizontal there, even inside a vertical scrollable.

### Changed
- Documented how `MaxGap` shares space with other flexible children (See https://github.com/letsar/gap/pull/32)

## 3.0.1
### Changed
- Remove the usage of AbstractNode so that it can be used in 3.12.0-8.0.pre.21 (See https://github.com/letsar/gap/issues/16)

## 3.0.0
### Changed
- Set minimum Flutter version to 3.7.0

## 2.0.2
### Fixed
- Use Scrollable.maybeOf instead of Scrollable.of

## 2.0.1
### Fixed
- Issue with Scrollable.of in master channel

## 2.0.0
### Added
- Null safety

## 1.2.0
### Added
- Compatibility with `Scrollable` widgets (such as `ListViews`).

## 1.1.1
### Fixed
- Typo in Readme.

## 1.1.0
### Added
- `SliverGap` the sliver version of `Gap`.

## 1.0.1
### Fixed
- Fix debug properties in `Gap` widget.

## 1.0.0
- Initial Open Source release.