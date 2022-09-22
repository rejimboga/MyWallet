//
//  UIButtonExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import UIKit

extension UIButton {
    func setupButton(title: String, fontName: Font, backgroundColor: Color, titleColor: Color) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(rgb: backgroundColor.rawValue)
        self.setTitle(title, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont(name: fontName.rawValue, size: 16)
        self.setTitleColor(UIColor(rgb: titleColor.rawValue), for: .normal)
        self.layer.cornerRadius = 22
        self.clipsToBounds = true
    }

}
