//
//  AttributedStringBuilder.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import UIKit

@resultBuilder
struct AttributedStringBuilder {
    // 基本方法
    static func buildBlock(_ parts: NSAttributedString...) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        parts.forEach(result.append)
        return result
    }
    
    // String 转成 NSAttributedString
    static func buildExpression(_ text: String) -> NSAttributedString {
        NSAttributedString(string: text)
    }
    
    // 转 UIImage
    static func buildExpression(_ image: UIImage) -> NSAttributedString {
        NSAttributedString(attachment: NSTextAttachment(image: image))
    }
    
    // 转自己，不是很清楚为什么一定要这个方法，感觉有上面几个就够了呀，但是实践上没有这个会报错
    static func buildExpression(_ attrString: NSAttributedString) -> NSAttributedString {
        attrString
    }
    
    // 支持 if 语句
    static func buildIf(_ attrString: NSAttributedString?) -> NSAttributedString {
        attrString ?? NSAttributedString()
    }
    
    // 支持 if/else 语句
    static func buildEither(first: NSAttributedString) -> NSAttributedString {
        first
    }
    static func buildEither(second: NSAttributedString) -> NSAttributedString {
        second
    }
}

extension NSAttributedString {
    // 帮助加 Attributes
    func withAttributes(_ attrs: [NSAttributedString.Key : Any]) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        result.addAttributes(attrs, range: NSRange(location: 0, length: self.length))
        return result
    }
    
    // 以 DSL 方式来初始化
    convenience init(@AttributedStringBuilder builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
}
