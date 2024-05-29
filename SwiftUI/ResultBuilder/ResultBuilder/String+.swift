//
//  String+.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import UIKit

extension String {
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.foregroundColor : color])
    }
    func background(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.backgroundColor: color])
    }
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.underlineColor: color, .underlineStyle: style.rawValue])
    }
    func font(_ font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: font])
    }
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.shadow: shadow])
    }
    var attributed: NSAttributedString {
        NSAttributedString(string: self)
    }
}
