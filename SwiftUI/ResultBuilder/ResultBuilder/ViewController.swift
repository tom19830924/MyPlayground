//
//  ViewController.swift
//  ResultBuilder
//
//  Created by user on 2024/3/29.
//

import UIKit

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

class ViewController: UIViewController {
    lazy var swiftLeeLogo: UIImageView = {
        let igView = UIImageView(image: .logo)
        igView.backgroundColor = .darkGray
        return igView
    }()
    lazy var label: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.backgroundColor = .lightGray
        lbl.text = "Bet Man"
        return lbl
    }()
    
    var alignLogoTop = true
    var fixedLogoSize: CGSize?// = CGSize(width: 200, height: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
//        view.addSubview(label) { view, label in
//            label.constraintsForAnchoringTo(boundsOf: view)
//        }
//
//        view.addSubview(swiftLeeLogo) { view, swiftLeeLogo in
//            swiftLeeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            
//            if let fixedLogoSize = fixedLogoSize {
//                swiftLeeLogo.widthAnchor.constraint(equalToConstant: fixedLogoSize.width)
//                swiftLeeLogo.heightAnchor.constraint(equalToConstant: fixedLogoSize.height)
//            }
//            
//            if alignLogoTop {
//                swiftLeeLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//            }
//            else {
//                swiftLeeLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            }
//        }
    }
}

