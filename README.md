# ExpandingCardView

[![CI Status](http://img.shields.io/travis/mcomella/ExpandingCardView.svg?style=flat)](https://travis-ci.org/mcomella/ExpandingCardView)
[![Version](https://img.shields.io/cocoapods/v/ExpandingCardView.svg?style=flat)](http://cocoapods.org/pods/ExpandingCardView)
[![License](https://img.shields.io/cocoapods/l/ExpandingCardView.svg?style=flat)](http://cocoapods.org/pods/ExpandingCardView)
[![Platform](https://img.shields.io/cocoapods/p/ExpandingCardView.svg?style=flat)](http://cocoapods.org/pods/ExpandingCardView)

ExpandingCardView is an iOS card view widget will hug its content, growing
until its height is constrained. At this point, scrolling will automatically
be enabled, alowing the user to read all the widget's content.

In the following example, the card view height is constrained to be less
than or equal to the screen size. First, the content does not fill the screen
and neither does the card view:

<div align="center">
<img src="docs/short-text.png" width="300px"/>
</div>

As the content grows, the card view will expand until the screen size,
at which point scrolling is enabled, as demonstrated below:

<div align="center">
<img src="docs/long-text.png" width="300px"/>
</div>

The card's corner radius, background color, and shadow are customizable.

## Motivation
We wanted a card view widget that hugs its content until the card view was
as large as the screen, then it would allow the user to scroll its content
to ensure all of it was visible. As far as we could find, this library
doesn't exist.

We could repurpose an existing card view library and build the
growing/scrolling functionality on top of it, but this could be fragile
and hard-to-extend.

ExpandingCardView was originally created for use in [Mozilla's Project
Prox][prox].

## Usage
```swift
// 1. Create your view, enable autolayout, and add it to the view hierarchy.
let cardView = ExpandingCardView()
cardView.translatesAutoresizingMaskIntoConstraints = false
parentView.addSubview(cardView) // e.g. parent could be the ViewController's view


// 2. Constrain the card view as you would any other view.
NSLayoutConstraint.activate([
    cardView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 16),
    cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

    // If you don't constrain the height, the card will grow to match its
    // intrinsic content size.

    // Or use lessThanOrEqualTo to allow your card view to grow only until a
    // certain size, e.g. the size of the screen.
    cardView.bottomAnchor.constraint(lessThanOrEqualTo: bottomLayoutGuide.topAnchor, constant: -16),

    // Or you can constrain it to a particular height:
    // cardView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -16),
    // cardView.heightAnchor.constraint(equalToConstant: 300),
])


// 3. Set your card view's content.
let content = UILabel()
content.text = "Hello world!"
content.numberOfLines = 0

cardView.contentView = content
```

The content can be any view with intrinsic height, or, if you supply a
`heightAnchor`, any view.

You can also customize your card view's appearance:

```swift
cardView.backgroundColor = .white

cardView.cornerRadius = 2

cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
cardView.layer.shadowRadius = 2
cardView.layer.shadowOpacity = 0.4
```

To see this in action, run the example project!

### Requirements
* iOS 9.0+

### Installation
ExpandingCardView is *not yet* available through [CocoaPods](http://cocoapods.org).
When it is, to install it, simply add the following line to your Podfile:

```ruby
pod "ExpandingCardView"
```

### Notes
* This project is not tested with Interface Builder
* This project is unlikely to work with non-constraint based layouts

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

[prox]: https://github.com/mozilla-mobile/prox
