import SwiftUI

// UIViewController包裝成SwiftUI View
struct ViewControllerWrapper<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T
    init(_ builder: () -> T) {
        viewController = builder()
    }
    func makeUIViewController(context: Context) -> T {
        return viewController
    }
    func updateUIViewController(_ uiViewController: T, context: Context) {}
}
// UIView包裝成SwiftUI View
struct ViewWrapper<T: UIView>: UIViewRepresentable {
    let view: T
    init(_ builder: @escaping () -> T) {
        view = builder()
    }
    func makeUIView(context: Context) -> UIView {
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}



// iOS 16前的preview struct
struct Pre_ios17_Preview_ViewController: PreviewProvider {
    static var previews: some View {
        ViewControllerWrapper { Xcode15_ViewController() }
            .ignoresSafeArea()
    }
}
struct Pre_ios17_PreviewView: PreviewProvider {
    static var previews: some View {
        ViewWrapper {
            let model = TitleViewModel(titleName: "spider-title", posterURL: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg")
            let cell = Xcode15_TableViewCell()
            cell.configure(with: model)
            return cell
        }
        .previewLayout(.fixed(width: 498, height: 140))
    }
}

// iOS 17之後
@available(iOS 17.0, *)
#Preview("iOS17_PreviewViewController") {
    // 直接放vc即可
    Xcode15_ViewController()
}
@available(iOS 17.0, *)
#Preview("iOS17_PreviewView", traits: .fixedLayout(width: 498, height: 140), body: {
    let model = TitleViewModel(titleName: "Spider-Man: Across the Spider", posterURL: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg")
    let cell = Xcode15_TableViewCell()
    cell.configure(with: model)
    return cell
})
