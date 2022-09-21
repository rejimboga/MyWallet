//
//  UILabelExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import UIKit

extension UILabel {
    func setupLabel(fontName: String, text: String?, textSize: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor(rgb: 0xFFFFFF)
        self.font = UIFont(name: fontName, size: textSize)
        self.text = text
    }
}
