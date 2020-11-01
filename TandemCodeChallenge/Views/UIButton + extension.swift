//
//  UIButton + extension.swift
//  TandemCodeChallenge
//
//  Created by Boris Goncharov on 10/26/20.
//

import Foundation
import UIKit

extension UIButton {
    func setupButton(button: UIButton) {
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 26
        button.setTitleColor(.black, for: .normal)
    }
}
