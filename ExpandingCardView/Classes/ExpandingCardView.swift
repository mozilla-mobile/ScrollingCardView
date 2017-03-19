/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

// NOTE: [mcomella] It'd be cool to turn this into a library, which is why it is structured
// as one. Please keep it clean, if possible! :)

// TODO:
// - TODOs in file
// - Option to animate layout changes?
// - Verify access control
// - Warn if contentView not set (crash? log?)
// - Break out into library (test using elsewhere, samples, readme w/ public methods;
//   show how we can use constraint(equalTo:) and constraint(lessThanOrEqualTo:)

/// A floating card view which will expand to display its full content without scrolling.
/// If the height is constrained, the content will automatically be scrollable.
///
/// The content view can be assigned with `expandingCardView.contentView = ...`. To correctly
/// expand, the content view must have a defined height: e.g. a UIStackView, a view with
/// a heightAnchor, or a view with intrinsicContentSize (like UILabel).
public class ExpandingCardView: UIView {

    // MARK: public API

    public override var backgroundColor: UIColor? {
        get { return scrollView.backgroundColor }
        set { scrollView.backgroundColor = newValue }
    }
    public var cornerRadius: CGFloat {
        get { return scrollView.layer.cornerRadius }
        set { scrollView.layer.cornerRadius = newValue }
    }

    public var contentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            for c in contentViewConstraints { c.isActive = false }
            contentViewConstraints.removeAll(keepingCapacity: true)

            guard let contentView = contentView else { return }
            for v in [contentView] + contentView.subviews { // TODO: okay to disable caller autoresize masks?
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            self.scrollView.addSubview(contentView)
            contentViewConstraints += tlbrConstraintsEqual(scrollView, contentView)

            // Constrain the width so we don't scroll horizontally.
            contentViewConstraints.append(scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor))
            NSLayoutConstraint.activate(contentViewConstraints)
        }
    }

    public init() {
        super.init(frame: .zero)
        initStyle()
        initLayout()
    }

    public required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }


    // MARK: implementation.

    fileprivate lazy var heightConstraint: NSLayoutConstraint = {
        // Default constant is high enough to see (for debugging purposes) but low enough
        // that the caller knows they've done something wrong.
        let constraint = self.heightAnchor.constraint(equalToConstant: 1)

        // Slightly less than required so a caller doesn't accidentally override
        // this constraint they don't know about.
        constraint.priority = UILayoutPriorityRequired - 1
        return constraint
    }()

    /// A sequence of constraints from the current user-defined contentView.
    private var contentViewConstraints: [NSLayoutConstraint] = []

    private lazy var scrollView: UIScrollView = {
        let view = ObservableScrollView()
        view.observableScrollViewDelegate = self
        return view
    }()

    private func initStyle() {
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 10

        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
    }

    private func initLayout() {
        addSubview(scrollView)
        // todo: need self? how affect caller?
        for view in [self, scrollView] as [UIView] {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = tlbrConstraintsEqual(self, scrollView) + [heightConstraint]
        NSLayoutConstraint.activate(constraints)
    }
}

// Intentionally not using SnapKit/adding extension - this may be a library.
private func tlbrConstraintsEqual(_ v1: UIView, _ v2: UIView) -> [NSLayoutConstraint] {
    return [
        v1.topAnchor.constraint(equalTo: v2.topAnchor),
        v1.leadingAnchor.constraint(equalTo: v2.leadingAnchor),
        v1.trailingAnchor.constraint(equalTo: v2.trailingAnchor),
        v1.bottomAnchor.constraint(equalTo: v2.bottomAnchor),
    ]
}

extension ExpandingCardView: ObservableScrollViewDelegate {
    func observableScrollView(_ scrollView: ObservableScrollView, onContentSizeUpdate contentSize: CGSize) {
        self.heightConstraint.constant = contentSize.height
    }
}
