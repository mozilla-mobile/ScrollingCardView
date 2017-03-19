/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation

extension NSLayoutConstraint {
    static func tlbrConstraintsEqual(_ v1: UIView, _ v2: UIView) -> [NSLayoutConstraint] {
        return [
            v1.topAnchor.constraint(equalTo: v2.topAnchor),
            v1.leadingAnchor.constraint(equalTo: v2.leadingAnchor),
            v1.trailingAnchor.constraint(equalTo: v2.trailingAnchor),
            v1.bottomAnchor.constraint(equalTo: v2.bottomAnchor),
        ]
    }
}
