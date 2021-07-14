//
//  UIFont+Extension.swift
//  CatchMe
//
//  Created by SHIN YOON AH on 2021/07/06.
//

import UIKit

struct AppFontName {
    static let numberRegular = "DINPro-Regular"
    static let numberMedium = "DINPro-Medium"
    static let numberBold = "DINPro-Bold"
    static let catchuRegular = "NanumSquareRoundOTFEB"
    static let stringRegular = "SpoqaHanSansNeo-Regular"
    static let stringMedium = "SpoqaHanSansNeo-Medium"
    static let stringBold = "SpoqaHanSansNeo-Bold"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    @objc class func numberRegularSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.numberRegular, size: size)!
    }
    
    @objc class func numberMediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.numberMedium, size: size)!
    }
    
    @objc class func numberBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.numberBold, size: size)!
    }
    
    @objc class func catchuRegularSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.catchuRegular, size: size)!
    }
    
    @objc class func stringRegularSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.stringRegular, size: size)!
    }
    
    @objc class func stringMediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.stringMedium, size: size)!
    }
    
    @objc class func stringBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.stringBold, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AppFontName.stringRegular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.stringMedium
                case "CTFontObliqueUsage":
                    fontName = AppFontName.stringBold
                default:
                    fontName = AppFontName.stringRegular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }

    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(stringRegularSystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(stringMediumSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(stringBoldSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}
