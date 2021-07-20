//
//  Extensions.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/16/21.
//

import Foundation
import UIKit

extension UIColor {
    func imageWithColor() -> UIImage {
        let size = CGSize(width: 1, height: 1)
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UITextField {
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 5, y: 5, width: self.frame.height - 10, height: self.frame.height - 10))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .placeholderText
    }
    
}


extension UIViewController {
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
            view.alpha = hidden ? 0 : 1
        })
    }
}

extension UIView {
    func cornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

