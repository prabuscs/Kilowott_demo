//
//  Extensions.swift
//  Kilowott Demo
//
//  Created by Clorida on 27/08/21.
//

import Foundation
import UIKit
// MARK: UIImageView extesions
extension UIImageView{
    /// Method for make imageview as circle
    public func maskCircle() {
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}

