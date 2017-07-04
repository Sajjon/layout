//
//  UIColor+Hex.swift
//  SampleApp
//
//  Created by Nick Lockwood on 05/05/2017.
//  Copyright © 2017 Nick Lockwood. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init?(hexString: String) {
        if hexString.hasPrefix("#") {
            var string = String(hexString.characters.dropFirst())
            switch string.characters.count {
            case 3:
                string += "f"
                fallthrough
            case 4:
                let chars = string.characters
                let red = chars[chars.index(chars.startIndex, offsetBy: 0)]
                let green = chars[chars.index(chars.startIndex, offsetBy: 1)]
                let blue = chars[chars.index(chars.startIndex, offsetBy: 2)]
                let alpha = chars[chars.index(chars.startIndex, offsetBy: 3)]
                string = "\(red)\(red)\(green)\(green)\(blue)\(blue)\(alpha)\(alpha)"
            case 6:
                string += "ff"
            case 8:
                break
            default:
                return nil
            }
            if let rgba = Double("0x" + string).flatMap({ UInt32(exactly: $0) }) {
                let red = CGFloat((rgba & 0xFF000000) >> 24) / 255
                let green = CGFloat((rgba & 0x00FF0000) >> 16) / 255
                let blue = CGFloat((rgba & 0x0000FF00) >> 8) / 255
                let alpha = CGFloat((rgba & 0x000000FF) >> 0) / 255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        return nil
    }
}