//
//  UIColor+Extension.swift
//  DYZB
//
//  Created by Smy_D on 2020/1/3.
//  Copyright © 2020 Smy_D. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    /// 传入一个16进制的字符串，返回该16进制代表的颜色（默认alpha位1）
    /// - Parameter hexString:代表颜色的16进制字符串
    /// - Returns:该16进制表示的颜色
    static func colorWith(hexString: String) -> UIColor {
        return UIColor.colorWith(hexString: hexString, alpha: 1.0)
    }
    
    
    
    /// 传入一个16进制的字符串，返回该16进制代表的颜色
    /// - Parameter hexString: 代表颜色的16进制字符串,支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    /// - Parameter alpha: 颜色的透明度
    /// - Returns: 该16进制表示的颜色
    static func colorWith(hexString: String, alpha: CGFloat) -> UIColor {
        // 删除字符传中的空格
        var cString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if cString.hasPrefix("0X") {
            cString = ((cString as NSString).substring(from: 2) as NSString) as String
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if cString.hasPrefix("#") {
            cString = ((cString as NSString).substring(from: 1) as NSString) as String
        }
        // String should be 6 or 8 characters
        if cString.count < 6 {
            print("colorWithHexString is wrong!")
            return UIColor.clear
        }
        // Sepatate into r, g, b substrings
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
    
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
        
    }
}
