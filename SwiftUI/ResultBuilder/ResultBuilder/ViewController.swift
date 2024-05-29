//
//  ViewController.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import UIKit
import SwiftUI

extension UIView {
    func constraintsForAnchoringTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}

struct Foo {
    @Builder var abc: String {
        "Getter: "
        "ABC"
    }
    
    @Builder subscript(_ anything: String) -> String {
        "sbscript"
        "ABC"
    }
}

class ViewController: UIViewController {
    lazy var swiftLeeLogo: UIImageView = {
        let igView = UIImageView(image: .logo)
        igView.backgroundColor = .darkGray
        return igView
    }()
    lazy var label: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.backgroundColor = .lightGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var alignLogoTop = true
    let optional = true
    var fixedLogoSize: CGSize?// = CGSize(width: 200, height: 200)
    
    @Builder func abc() -> String {
        "Mehotd: "
        "ABC"
    }
    func acceptBuilder(@Builder _ builder: () -> String) -> Void {
        print(builder())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(abc())
        print(Foo().abc)
        print(Foo()[""])
        acceptBuilder {
            "Closure Argument: "
            "ABC "
        }
        // Do any additional setup after loading the view.
        
        //        var constraints: [NSLayoutConstraint] = [
        //            // Single constraint
        //            swiftLeeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        //        ]
        //
        //        // Boolean check
        //        if alignLogoTop {
        //            constraints.append(swiftLeeLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        //        } else {
        //            constraints.append(swiftLeeLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        //        }
        //
        //        // Unwrap an optional
        //        if let fixedLogoSize = fixedLogoSize {
        //            constraints.append(contentsOf: [
        //                swiftLeeLogo.widthAnchor.constraint(equalToConstant: fixedLogoSize.width),
        //                swiftLeeLogo.heightAnchor.constraint(equalToConstant: fixedLogoSize.height)
        //            ])
        //        }
        //
        //        // Add a collection of constraints
        //        constraints.append(contentsOf: label.constraintsForAnchoringTo(boundsOf: view)) // Returns an array
        //
        //        // Activate
        //        NSLayoutConstraint.activate(constraints)
        
        //        @AutoLayoutBuilder var constraints: [NSLayoutConstraint] {
        //            swiftLeeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        //
        //            label.constraintsForAnchoringTo(boundsOf: view)
        //
        //            // Unwrapping an optional, buildOptional
        //            if let fixedLogoSize = fixedLogoSize {
        //                swiftLeeLogo.widthAnchor.constraint(equalToConstant: fixedLogoSize.width)
        //                swiftLeeLogo.heightAnchor.constraint(equalToConstant: fixedLogoSize.height)
        //            }
        //
        //            // Conditional check, buildEither
        //            if alignLogoTop {
        //                swiftLeeLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        //            }
        //            else {
        //                swiftLeeLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        //            }
        //
        //            for _ in (0..<Int.random(in: 0..<10)) {
        //                swiftLeeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor) // Single constraint
        //            }
        //        }
        
        
        
        view.addSubview(label) { view, label in
            label.constraintsForAnchoringTo(boundsOf: view)
        }
        
        
        label.attributedText =
        NSAttributedString {
            NSAttributedString {
                "Folder"
                UIImage(systemName: "folder")!
            }
            NSAttributedString {}
            "\n"
            NSAttributedString {
                "Document"
                UIImage(systemName: "doc")!
            }
            .withAttributes([
                .font : UIFont.systemFont(ofSize: 32),
                .foregroundColor : UIColor.red
            ])
            "\n"
            "Blue One"
                .foregroundColor(.blue)
                .background(.gray)
                .underline(.cyan)
                .font(.systemFont(ofSize: 20))
            "\n"
            if optional {
//                NSAttributedString {
                    "Hello "
                        .foregroundColor(.red)
                        .font(UIFont.systemFont(ofSize: 10.0))
                    "World"
                        .foregroundColor(.green)
                        .underline(.orange, style: .thick)
//                }
                UIImage(systemName: "rays")!
            }
            "\n"
            if optional {
                "It's True"
                    .foregroundColor(.magenta)
                    .font(UIFont.systemFont(ofSize: 28))
            } else {
                "It's False"
                    .foregroundColor(.purple)
            }
        }
        
        view.addSubview(swiftLeeLogo) { view, swiftLeeLogo in
            swiftLeeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            if let fixedLogoSize = fixedLogoSize {
                swiftLeeLogo.widthAnchor.constraint(equalToConstant: fixedLogoSize.width)
                swiftLeeLogo.heightAnchor.constraint(equalToConstant: fixedLogoSize.height)
            }
            
            if alignLogoTop {
                swiftLeeLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            }
            else {
                swiftLeeLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            }
        }
    }
}

#Preview {
    ViewController()
}
