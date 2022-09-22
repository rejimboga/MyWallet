//
//  UILabelExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import UIKit

extension UILabel {
    func setupLabel(fontName: Font, text: String?, textSize: CGFloat, color: Color) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor(rgb: color.rawValue) 
        self.font = UIFont(name: fontName.rawValue, size: textSize)
        self.text = text
    }
}

enum Font: String {
    case regular = "Montserrat-Regular"
    case semiBold = "Montserrat-SemiBold"
    case medium = "Montserrat-Medium"
}

enum Color: Int {
    case whiteColor = 0xFFFFFF
    case blackColor = 0x000000
    case nobelColor = 0x9D9D9D
    case limeColor = 0x21C531
    case nightRiderColor = 0x353535
    case redColor = 0xEF2F2F
}

