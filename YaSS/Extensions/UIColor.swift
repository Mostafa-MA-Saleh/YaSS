//
//  UIColor.swift
//  YaSS
//
//  Created by Mostafa Saleh on 3/16/19.
//  Copyright © 2019 Mostafa Saleh. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Float = 1) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
}
