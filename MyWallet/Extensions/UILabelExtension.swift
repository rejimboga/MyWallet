//
//  UILabelExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import UIKit

extension UILabel {
    func setLabel(fontName: String, text: String?, textSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(rgb: 0xFFFFFF)
        label.font = UIFont(name: fontName, size: textSize)
        label.text = text
        return label
    }
}
