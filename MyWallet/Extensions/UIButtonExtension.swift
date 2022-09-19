//
//  UIButtonExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import UIKit

extension UIButton {
    func setButton(title: String, image: String, padding: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb: 0xFFFFFF)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        button.setImage(UIImage(named: image), for: .normal)
        button.tintColor = UIColor(rgb: 0x000000)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0)
        return button
    }

}
