//
//  UIButtonExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import UIKit

extension UIButton {
    func setupButton(title: String, image: String, padding: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(rgb: 0xFFFFFF)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        self.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        self.layer.cornerRadius = 22
        self.clipsToBounds = true
        self.setImage(UIImage(named: image), for: .normal)
        self.tintColor = UIColor(rgb: 0x000000)
        self.semanticContentAttribute = .forceRightToLeft
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0)
    }

}
