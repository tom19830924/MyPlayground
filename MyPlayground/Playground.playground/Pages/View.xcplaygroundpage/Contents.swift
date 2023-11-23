//: [Previous](@previous)
//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyTextField: UITextField {
    override func resignFirstResponder() -> Bool {
        self.endOfDocument
        return super.resignFirstResponder()
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.frame = CGRectMake(0, 0, 300, 300)
        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField1 = MyTextField(frame: CGRectMake(0, 0, 100, 30))
        textField1.borderStyle = .roundedRect
        textField1
        
        view.addSubview(textField1)
        
        let textField2 = UITextField(frame: CGRectMake(0, 50, 100, 30))
        textField2.borderStyle = .roundedRect
        view.addSubview(textField2)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
//: [Next](@next)

