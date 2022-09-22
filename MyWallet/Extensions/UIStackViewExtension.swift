//
//  UIStackViewExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 22.09.2022.
//

import Foundation
import UIKit

extension UIStackView {
    func setupStackView(axis: NSLayoutConstraint.Axis ,spacing: CGFloat) {
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
