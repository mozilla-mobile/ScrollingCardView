/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import ExpandingCardView

private let horizontalMargin: CGFloat = 16

class ViewController: UIViewController {

    private lazy var cardView = ExpandingCardView()

    private lazy var cardViewContent: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = text
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        styleCardView()
        setupGestureRecognizers()
    }

    private func styleCardView() {
        cardView.backgroundColor = .white
        cardView.cornerRadius = 2

        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOpacity = 0.4
    }

    private func setupViews() {
        view.translatesAutoresizingMaskIntoConstraints = false
        for subview in [buttonContainer, cardView] as [UIView] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }

        cardView.contentView = cardViewContent // notably, this was not previously added as a subview.

        var constraints = [
            cardView.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),

            // This could be `cardView.bottomAnchor.constraint(equalTo: ...` if we wanted to keep the
            // card view height a constant.
            cardView.bottomAnchor.constraint(lessThanOrEqualTo: bottomLayoutGuide.topAnchor, constant: -16),
        ]

        // Constraints for this example, but not important to understand the card view.
        constraints += [
            buttonContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 16),
            buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            buttonContainer.heightAnchor.constraint(equalToConstant: 32),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @objc private func onShortTextTap() {
        cardViewContent.text = text
    }

    @objc private func onLongTextTap() {
        cardViewContent.text = longText
    }


    // MARK: Vars & functions to manipulate this example, but not important to understand the card view.
    private lazy var buttonContainer: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.shortTextButton,
            self.longTextButton
        ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()

    private let shortTextButton = button(forTitle: "Short text")
    private let longTextButton = button(forTitle: "Long text")

    private func setupGestureRecognizers() {
        shortTextButton.addTarget(self, action: #selector(onShortTextTap), for: .touchUpInside)
        longTextButton.addTarget(self, action: #selector(onLongTextTap), for: .touchUpInside)
    }
}

private func button(forTitle title: String) -> UIButton {
    let view = UIButton(type: .system)
    view.setTitle(title, for: .normal)
    view.setTitleColor(.black, for: .normal)
    view.titleLabel?.font = UIFont.systemFont(ofSize: 16)

    view.backgroundColor = UIColor(white: 0.9, alpha: 1)
    view.layer.cornerRadius = 8
    return view
}

private let text = "Dolores est culpa eum. Ab ipsum non corrupti deleniti enim perspiciatis quo sit. Nemo consectetur nemo et quia quidem cumque cumque nihil. Voluptatibus quidem ut magnam explicabo assumenda veniam ut. Et consequatur ea explicabo."

private let longText: String = {
    var outText: [String] = []
    for i in 1...10 {
        outText += [text]
    }
    return outText.joined(separator: "\n\n")
}()
