//
//  NSAttributedString+.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import UIKit

extension NSAttributedString {
    func apply(_ attributes: [NSAttributedString.Key:Any]) -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: self.string, attributes: self.attributes(at: 0, effectiveRange: nil))
        mutable.addAttributes(attributes, range: NSMakeRange(0, (self.string as NSString).length))
        return mutable
    }
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        self.apply([.foregroundColor : color])
    }
    func background(_ color: UIColor) -> NSAttributedString {
        self.apply([.backgroundColor: color])
    }
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        self.apply([.underlineColor: color, .underlineStyle: style.rawValue])
    }
    func font(_ font: UIFont) -> NSAttributedString {
        self.apply([.font: font])
    }
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        self.apply([.shadow:shadow])
    }
}
