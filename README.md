# ExpandingCardView

[![CI Status](http://img.shields.io/travis/mcomella/ExpandingCardView.svg?style=flat)](https://travis-ci.org/mcomella/ExpandingCardView)
[![Version](https://img.shields.io/cocoapods/v/ExpandingCardView.svg?style=flat)](http://cocoapods.org/pods/ExpandingCardView)
[![License](https://img.shields.io/cocoapods/l/ExpandingCardView.svg?style=flat)](http://cocoapods.org/pods/ExpandingCardView)
[![Platform](https://img.shields.io/cocoapods/p/ExpandingCardView.svg?style=flat)](http://cocoapods.org/pods/ExpandingCardView)

## Requirements
* iOS 9.0+

## Installation
ExpandingCardView is available through [CocoaPods](http://cocoapods.org). To
install it, simply add the following line to your Podfile:

```ruby
pod "ExpandingCardView"
```

## Example
To run the example project:

```
pushd Example/
pod install
popd
open Example/ExpandingCardView.xcworkspace
```

Xcode will open: run from there.

## Development
Follow the instructions above to open the example project. The library files
can be found in:

Pods -> Development Pods -> ExpandingCardView -> ExpandingCardView -> Classes

### Testing against external applications
If you're developing against an external application, you can specify a
relative path from the application's podfile to your fork of this library:

```ruby
pod "ExpandingCardView", :path => "../ExpandingCardView"
```

Run `pod install` in the external application's directory.
