//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by Smy_D on 2020/1/3.
//  Copyright © 2020 Smy_D. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //扩充为类函数
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    // 扩充便利构造函数: 1>convenience开头 2>在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName: String, highImageName: String="", size: CGSize=CGSize.zero) {
        
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
