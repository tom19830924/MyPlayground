import SwiftUI

// iOS 16以前寫法
//struct UIView_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewPreviewWrapper {
//            let model = TitleViewModel(titleName: "spider-title", posterURL: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg")
//            let cell = Xcode15_TableViewCell()
//            cell.configure(with: model)
//            return cell
//        }
//        .previewLayout(.fixed(width: 498, height: 140))
//    }
//}
//struct UIViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreviewWrapper { Xcode15_ViewController() }
//            .ignoresSafeArea()
//    }
//}

@available(iOS 17.0, *)
#Preview {
    Xcode15_ViewController()
}
@available(iOS 17.0, *)
#Preview("iOS17_PreviewView", traits: .fixedLayout(width: 498, height: 140), body: {
    let model = TitleViewModel(titleName: "Spider-Man: Across the Spider", posterURL: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg")
    let cell = Xcode15_TableViewCell()
    cell.configure(with: model)
    return cell
})
