

import Foundation
import UIKit

extension UIViewController{
    
    
    @IBAction func backNavigationact_clicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    func failureMessage (message : String) {
        if message != "" {
            self.showCustomBottomAlertView(message: message  , textColor: .white, backgroundColor: #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3019607843, alpha: 1))
        }
    }
    
    func successMessage (message : String) {
        if message != "" {
            self.showCustomBottomAlertView(message: message  , textColor: .white, backgroundColor: #colorLiteral(red: 0.3137254902, green: 0.7215686275, blue: 0.5215686275, alpha: 1))
        }
    }
       
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

       func showCustomBottomAlertView(message : String, textColor : UIColor, backgroundColor : UIColor) {
           
           let alertMessageView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.view.frame.width, height: 45))
           alertMessageView.backgroundColor = backgroundColor
           
           let alertMessageLbl = UILabel(frame: CGRect(x: 10, y: 10, width: alertMessageView.frame.width - 5 , height: alertMessageView.frame.height - 10 ))
           alertMessageLbl.textColor = textColor
           alertMessageLbl.font = UIFont.systemFont(ofSize: 15)
        alertMessageLbl.text = "\(message)"
           alertMessageLbl.alpha = 1.0
           alertMessageLbl.clipsToBounds  =  true
           alertMessageLbl.numberOfLines = 0
           alertMessageLbl.lineBreakMode = .byWordWrapping
           
        let height = heightForView(text: alertMessageLbl.text ?? "", font: UIFont.systemFont(ofSize: 15) , width: self.view.frame.width)
           alertMessageLbl.frame = CGRect(x: 10, y: 15 , width: alertMessageView.frame.width - 10, height: height + 10)
           alertMessageView.frame = CGRect(x: 0, y: self.view.frame.size.height , width: self.view.frame.width , height: height + 40 )
           alertMessageView.updateConstraintsIfNeeded()
           
    
            if alertmessage == false {

               self.view.addSubview(alertMessageView)
               alertMessageView.addSubview(alertMessageLbl)
               
               guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate, let window:UIWindow = applicationDelegate.window else{
                
                   return
               }
               
               let level1 = window.windowLevel
               window.makeKeyAndVisible()
               window.addSubview(alertMessageView)
               alertMessageView.layer.zPosition = 1
               
               UIView.animate(withDuration: 0.5, animations: {
                   alertmessage = true

                   alertMessageView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - alertMessageView.frame.height , width: self.view.frame.size.width , height: alertMessageView.frame.height)
               }, completion: {val in
                   UIView.animate(withDuration: 0.5, delay: 3, options: [], animations: {
                       alertMessageView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.size.width , height: alertMessageView.frame.height)
                   }, completion: {val in
                       for v in alertMessageView.subviews{
                           v.isHidden = true
                       }
                       alertmessage = false
                       alertMessageView.removeFromSuperview()
                       window.windowLevel = level1
                       window.makeKeyAndVisible()
                   })
               })
            } else {

           }
       }

}

extension UIViewController:ActivityIndicatorDelegate{
    func startActivityIndicator() {
                DispatchQueue.global(qos: .userInitiated).async {
                     DispatchQueue.main.async {
                        
                        if animateLoader == false {
                            animateLoader = true
                            let holdingView = UIView(frame: UIScreen.main.bounds)
                            holdingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
                            var blurredView: UIVisualEffectView!
                            if #available(iOS 13.0, *) {
                                blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                            } else {
                                blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
                            }
                            blurredView.frame =  self.view.bounds
                            //holdingView.addSubview(blurredView)
//                            holdingView.bringSubviewToFront(blurredView)
                            
                            holdingView.tag = self.activityIndicatorHoldingViewTag
                            let spin = SpinnerView()
                            spin.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
                            spin.center = holdingView.center
                            holdingView.addSubview(spin)

                            let img = UIImageView()
                            img.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                            img.layer.cornerRadius = 30
                            img.clipsToBounds = true
                            img.layer.borderColor = UIColor.white.cgColor
                            img.layer.borderWidth = 1.5
                            img.image = UIImage(named: "apple-logo-business-iphone-png-favpng-hyzjSfZY66wqwfvuMkgRbVwFw")
                            img.center = holdingView.center
                            holdingView.addSubview(img)

                            holdingView.bringSubviewToFront(spin)
                            holdingView.bringSubviewToFront(img)

                            self.view.addSubview(holdingView)
                        }
                     }
                }
    }
    
    func stopActivityIndicator() {
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        
                        if let holdingView = self.view.subviews.filter({ $0.tag == self.activityIndicatorHoldingViewTag}).first {
                            animateLoader = false
        //                    KVSpinnerView.dismiss()
                            holdingView.removeFromSuperview()
                        }
                    }
                }

    }
    

    var activityIndicatorHoldingViewTag: Int { return 999999 }

}

@objc protocol ActivityIndicatorDelegate {
   func startActivityIndicator()
   func stopActivityIndicator()
}

let app = UIApplication.shared.delegate as! AppDelegate
var animateLoader = false

@IBDesignable
class SpinnerView : UIView {

    override var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 4
        setPath()
    }

    override func didMoveToWindow() {
        animate()
    }

    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }

    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }

    class var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.7),
                Pose(0.6, 0.500, 0.5),
                Pose(0.6, 1.000, 0.3),
                Pose(0.6, 1.500, 0.1),
                Pose(0.2, 1.875, 0.1),
                Pose(0.2, 2.250, 0.3),
                Pose(0.2, 2.625, 0.5),
                Pose(0.2, 3.000, 0.7),
            ]
        }
    }

    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()

        let poses = type(of: self).poses
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }

        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }

        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])

        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)

        animateStrokeHueWithDuration(duration: totalSeconds * 5)
    }

    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }

    func animateStrokeHueWithDuration(duration: CFTimeInterval) {
        let count = 36
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        animation.keyTimes = (0 ... count).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(count)) }
        animation.values = (0 ... count).map {
            UIColor(hue: CGFloat($0) / CGFloat(count), saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        animation.duration = duration
        animation.calculationMode = .linear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }

}
