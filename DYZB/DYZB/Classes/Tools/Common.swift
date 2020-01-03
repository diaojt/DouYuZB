//
//  Common.swift
//  DYZB
//
//  Created by Smy_D on 2020/1/3.
//  Copyright © 2020 Smy_D. All rights reserved.
//

import UIKit

// 获取沙盒Document路径
let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
// 获取沙盒Cache路径
let kCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
// 获取沙盒temp路径
let kTempPath = NSTemporaryDirectory()

// 颜色
func kRGBAColor(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat)->UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: a)
}

func kRGBColor(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
}

func kHexColorA(_ HexString: String,_ a: CGFloat ) -> UIColor {
    return UIColor.colorWith(hexString: HexString, alpha: a)
}

func kHexColor(_ HexString: String) -> UIColor {
    return UIColor.colorWith(hexString: HexString)
}

func kRandomColor() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
}

let kColorNil = UIColor.clear
let kColor_000000 = kHexColor("000000")
let kColor_111111 = kHexColor("111111")
let kColor_222222 = kHexColor("222222")
let kColor_333333 = kHexColor("333333")
let kColor_444444 = kHexColor("444444")
let kColor_555555 = kHexColor("555555")
let kColor_666666 = kHexColor("666666")
let kColor_777777 = kHexColor("777777")
let kColor_888888 = kHexColor("888888")
let kColor_999999 = kHexColor("999999")
let kColor_aaaaaa = kHexColor("aaaaaa")
let kColor_bbbbbb = kHexColor("bbbbbb")
let kColor_cccccc = kHexColor("cccccc")
let kColor_dddddd = kHexColor("dddddd")
let kColor_eeeeee = kHexColor("eeeeee")
let kColor_ffffff = kHexColor("ffffff")
let kColor_ff0000 = kHexColor("ff0000")     //大红
let kColor_00ff00 = kHexColor("00ff00")     //大黄
let kColor_0000ff = kHexColor("0000ff")     //大蓝

// 获取屏幕大小
let kScreenSize = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale):UIScreen.main.bounds.size
let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width
let kScreenBounds = UIScreen.main.bounds

//APP版本号
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
//当前系统版本号
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//检测用户版本号
let kiOS13 = (kVersion >= 13.0)
let kiOS12 = (kVersion >= 12.0 && kVersion < 13.0)
let kiOS11 = (kVersion >= 11.0 && kVersion < 12.0)
let kiOS10 = (kVersion >= 10.0 && kVersion < 11.0)
let kiOS9 = (kVersion >= 9.0 && kVersion < 10.0)
let kiOS8 = (kVersion >= 8.0 && kVersion < 9.0)

let kiOS13Later = (kVersion >= 13.0)
let kiOS12Later = (kVersion >= 12.0)
let kiOS11Later = (kVersion >= 11.0)
let kiOS10Later = (kVersion >= 10.0)
let kiOS9Later = (kVersion >= 9.0)
let kiOS8Later = (kVersion >= 8.0)

//获取当前语言
let kAppCurrentLanguage = Locale.preferredLanguages[0]
//判断是否为iPhone
let kDeviceIsiPhone = (UIDevice.current.userInterfaceIdiom == .phone)
//判断是否为iPad
let kDeviceIsiPad = (UIDevice.current.userInterfaceIdiom == .pad)

// 判断iPhone的屏幕尺寸
let kScreen_Max_Light = max(kScreenWidth, kScreenHeight)
let kScreen_Min_Light = min(kScreenWidth, kScreenHeight)

// 适配350 375 414  568 667 736
func kAutoLayoutWidth(_ width: CGFloat) -> CGFloat {
    return width*kScreenWidth / 375
}
func kAutoLayoutHeight(_ height: CGFloat) -> CGFloat {
    return height*kScreenHeight / 667
}

// 机型判断
let kUI_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
let kUI_IPHONE5 = (kUI_IPHONE && kScreen_Max_Light == 568.0)
let kUI_IPHONE6 = (kUI_IPHONE && kScreen_Max_Light == 667.0)
let kUI_IPHOEPLUS = (kUI_IPHONE && kScreen_Max_Light == 736.0)
let kUI_IPHONEX = (kUI_IPHONE && kScreen_Max_Light > 780.0)

//获取状态栏、标题栏、导航栏高度
let kUIStatusBarHeight: CGFloat = (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height)!
let kUINavigationBarHeight: CGFloat =  44
let KUITabBarHeight: CGFloat = kUI_IPHONEX ? 83 : 49

// 注册通知
func kNOTIFY_ADD(observer: Any, selector: Selector, name: String) {
return NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: name), object: nil)
}
// 发送通知
func kNOTIFY_POST(name: String, object: Any) {
return NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
}
// 移除通知
func kNOTIFY_REMOVE(observer: Any, name: String) {
return NotificationCenter.default.removeObserver(observer, name: Notification.Name(rawValue: name), object: nil)
}

//代码缩写
let kApplication = UIApplication.shared
let kAPPKeyWindow = kApplication.windows[0]
let kAppDelegate = kApplication.delegate
let kAppNotificationCenter = NotificationCenter.default
let kAppRootViewController = kAppDelegate?.window??.rootViewController

//字体 字号
func kFontSize(_ a: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: a)
}

func kFontBoldSize(_ a: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: a)
}

func kFontForIPhone5or6Size(_ a: CGFloat, _ b: CGFloat) -> UIFont {
    return kUI_IPHONE5 ? kFontSize(a) : kFontSize(b)
}

/**
字符串是否为空
@param str NSString 类型 和 子类
@return  BOOL类型 true or false
*/
func kStringIsEmpty(_ str: String!) -> Bool {
    
    if str.isEmpty {
        return true
    }
    if str == nil {
        return true
    }
    if str.count < 1 {
        return true
    }
    if str == "(null)" {
        return true
    }
    if str == "null" {
        return true
    }
    return false
}
// 字符串判空 如果为空返回@“”
func kStringNullToempty(_ str: String) -> String {
    let resutl = kStringIsEmpty(str) ? "" : str
    return resutl
}

func kStringNullToReplaceStr(_ str: String,_ replaceStr: String) -> String {
    let resutl = kStringIsEmpty(str) ? replaceStr : str
    return resutl
}

/**
数组是否为空
@param array NSArray 类型 和 子类
@return BOOL类型 true or false
*/
func kArrayIsEmpty(_ array: [String]) -> Bool {
    let str: String! = array.joined(separator: "")
    if str == nil {
        return true
    }
    if str == "(null)" {
        return true
    }
    if array.count == 0 {
        return true
    }
    if array.isEmpty {
        return true
    }
    return false
}

/**
字典是否为空
@param dic NSDictionary 类型 和子类
@return BOOL类型 true or false
*/
func kDictIsEmpty(_ dict: NSDictionary) -> Bool {
    let str: String! = "\(dict)"
    if str == nil {
        return true
    }
    if str == "(null)" {
        return true
    }
    if dict .isKind(of: NSNull.self) {
        return true
    }
    if dict.allKeys.count == 0 {
        return true
    }
    return false
}
