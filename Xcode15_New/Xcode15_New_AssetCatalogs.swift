import SwiftUI
import UIKit

/// 向下相容到UIKit iOS11 / SwiftUI iOS13 (來源？)

struct Xcode15_New_AssetCatalogs: View {
    var body: some View {
        VStack(spacing: 32, content: {
            Image(.myEraser)    // Symbol Image
            Image(.myPic)       // Image Set
        })
        .background(.myBrown)   // Color Set
        
    }
}

@available(iOS 17.0, *)
#Preview {
    Xcode15_New_AssetCatalogs()
}


class Xcode15_New_AssetCatalogsV: UIViewController {
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.spacing = 32

//        ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOLS
        stackView.addArrangedSubview(UIImageView(image: UIImage(resource: .myEraser)))
        stackView.addArrangedSubview(UIImageView(image: UIImage(resource: .myPic)))
          
//        ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOLS + ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS
//        stackView.addArrangedSubview(UIImageView(image: .myEraser))
//        stackView.addArrangedSubview(UIImageView(image: .myPic))
//        stackView.backgroundColor = UIColor(resource: .myBrown)
    }
}

@available(iOS 17.0, *)
#Preview {
    Xcode15_New_AssetCatalogsV()
}
