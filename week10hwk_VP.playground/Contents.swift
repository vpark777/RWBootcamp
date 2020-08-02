import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


extension UIView {
    static func animate(withDuration duration: TimeInterval, animations:@escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)?) {
        group.enter()
        self.animate(withDuration: duration, animations: animations, completion:{
            (finished) in
             group.leave()
             completion?(finished)
        })
    }
      }//group animate

let animationGroup = DispatchGroup()
/*
DispatchQueue.main.async{
    animationGroup.notify(queue: DispatchQueue.main) {
        print("Animations Completed!")
    }
}
*/

// A red square
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.red
// A yellow box
let box = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))


box.backgroundColor = UIColor.yellow
view.addSubview(box)
// Note: Enable Xcode▸Editor▸Live View to see the animation.
PlaygroundPage.current.liveView = view


UIView.animate(withDuration: 1, animations: {
  // Move box to lower right corner
    box.center = CGPoint(x: 150, y: 150)
},group:animationGroup){ (done) in
    if (done){
        UIView.animate(withDuration: 2, animations: {
            // Rotate box 45 degrees
            box.transform = CGAffineTransform(rotationAngle:  .pi/4)
        },group:animationGroup, completion:nil)
    }
    
}

UIView.animate(withDuration: 4, animations: {
  view.backgroundColor = UIColor.blue
},group:animationGroup,completion:nil)

animationGroup.notify(queue: DispatchQueue.main) {
    print("Animations Completed!")
}

