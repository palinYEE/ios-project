//
//  AnimationViewController.swift
//  YYJ_ANIMATION
//
//  Created by yoon-yeoungjin on 2022/10/30.
//

import UIKit

func drawCircleView() -> UIView {
      let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: UIScreen.main.bounds.midY - 50), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
      
      let shapeLayer = CAShapeLayer()
      shapeLayer.path = circlePath.cgPath
      
      shapeLayer.fillColor = UIColor.red.cgColor
      shapeLayer.strokeColor = UIColor.red.cgColor
      shapeLayer.lineWidth = 3.0
      
      let view = UIView()
      view.layer.addSublayer(shapeLayer)
      
      return view
}


class AnimationViewController: UIViewController {
    
    fileprivate let duration = 1.5
    fileprivate let scale = 1.2
    fileprivate let delay = 0.2
    
    var myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    var animationTitite: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRect()
    }
    
    fileprivate func setupRect() {
        if animationTitite == "BezierCurve Position" {
            myView = drawCircleView()
            myView.backgroundColor = .red
        } else if animationTitite == "View Fade In" {
            myView = UIImageView(image: UIImage(named: "whatsapp"))
            myView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2.0, height: UIScreen.main.bounds.height / 4.0)
            myView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 50)
        }else {
            myView.backgroundColor = .red
            myView.center = view.center
        }
        view.addSubview(myView)
    }

    // "Simple 2D Rotation", "Multicolor", "BezierCurve Position", "Color and Frame Change", "View Fade in", "Pop"
    @IBAction func playAnimation(_ sender: Any) {
        switch animationTitite {
        case "2-Color":
            twoColorAnimation(.blue)
        case "Simple 2D Rotation":
            Simpler2Rotation()
        case "Multicolor":
            multiColor(.blue, .gray)
        case "Multi Point Position":
            multiPointPosition(CGPoint(x: myView.frame.origin.x, y:100), CGPoint(x: myView.frame.origin.x, y: 350))
        case "BezierCurve Position":
            var contPoint1 = self.myView.center
            contPoint1.y -= 125.0
            var contPoint2 = contPoint1
            contPoint2.x += 40.0
            contPoint2.y -= 125.0
            var endPoint = self.myView.center
            endPoint.x += 75.0
            curvePath(endPoint, contPoint1: contPoint1, contPoint2: contPoint2)
            break
        case "Color and Frame Change":
            let currentFrame = self.myView.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.orange, UIColor.yellow, UIColor.green)
            break
        case "View Fade in":
            viewFaidIn()
        case "Pop":
            Pop()
        default:
            print("not animation")
        }
    }
    
    func twoColorAnimation(_ color: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.myView.backgroundColor = color
        }, completion: nil)
    }
    
    func Simpler2Rotation() {
        UIView.animate(withDuration: self.duration) {
            self.myView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.myView.backgroundColor = firstColor
        }) { finished in
            self.twoColorAnimation(secondColor)
        }
    }
    
    func multiPointPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
        func simplePosition(_ pos: CGPoint) {
            UIView.animate(withDuration: self.duration) {
                self.myView.frame.origin = pos
            }
        }
        
        UIView.animate(withDuration: self.duration, animations: {
            self.myView.frame.origin = firstPos
        }) { finished in
            simplePosition(secondPos)
        }
    }
    
    func curvePath(_ endPoint: CGPoint, contPoint1: CGPoint, contPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.myView.center)
        
        path.addCurve(to: endPoint, controlPoint1: contPoint1, controlPoint2: contPoint2)
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        anim.path = path.cgPath
        anim.duration = self.duration
        self.myView.layer.add(anim, forKey: "animate position along path")
        self.myView.center = endPoint
    }
    
    func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect, _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.myView.backgroundColor = firstColor
            self.myView.frame = firstFrame
        }, completion: { finished in
            UIView.animate(withDuration: self.duration, animations: {
                self.myView.backgroundColor = secondColor
                self.myView.frame = secondFrame
            }, completion: { finished in
                UIView.animate(withDuration: self.duration) {
                    self.myView.backgroundColor = thirdColor
                    self.myView.frame = thirdFrame
                }
            })

        })
    }
    
    func viewFaidIn() {
        let secondView = UIImageView(image: UIImage(named: "facebook"))
        secondView.frame = self.myView.frame
        secondView.alpha = 0.0
        
        view.insertSubview(secondView, aboveSubview: self.myView)
        
        UIView.animate(withDuration: self.duration, delay: delay ,options: .curveEaseOut) {
            secondView.alpha = 1.0
            self.myView.alpha = 0.0
        }
    }
    
    fileprivate func Pop() {
      UIView.animate(withDuration: duration / 4,
        animations: {
        self.myView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
        }, completion: { finished in
          UIView.animate(withDuration: self.duration / 4, animations: {
            self.myView.transform = CGAffineTransform.identity
          })
      })
    }
}
