//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import TrainingProgramm

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = TrainingTypeView()
        view.addSubview(label)
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40)
        
        self.view = view
    }
}
// Present the view controller in the Live View window

let controller = MyViewController()
PlaygroundPage.current.liveView = controller

func getView(parent view: UIView) -> UIView {
    let label = TrainingTypeView()
    view.addSubview(label)
    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    label.heightAnchor.constraint(equalToConstant: 40).isActive = true
    view.addSubview(label)
    return label
}
