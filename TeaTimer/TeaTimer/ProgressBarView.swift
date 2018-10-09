//
//  ProgressBar.swift
//  TeaTimer
//
//  Created by Lucky Tran  on 10/9/18.
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit

class ProgressBarView: UIView{
    var bgPath: UIBezierPath!
    var shapeLayer:CAShapeLayer!
    var progressLayer: CAShapeLayer!
    
    private func createCirclePath(){
        let x = self.frame.width/2
        let y = self.frame.height/2
        let center = CGPoint(x: x, y: y)
        bgPath.addArc(withCenter: center, radius: x/CGFloat(2), startAngle: CGFloat(0), endAngle: CGFloat(6.28), clockwise: true)
        bgPath.close()
        
    }
    func simpleShape(){
        createCirclePath()
        
        //background layer
        shapeLayer = CAShapeLayer()
        shapeLayer.path = bgPath.cgPath
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        //foreground layer
        progressLayer = CAShapeLayer()
        progressLayer.path = bgPath.cgPath
        progressLayer.lineWidth = 15
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.fillColor =  nil
        progressLayer.strokeColor = UIColor.blue.cgColor
        progressLayer.strokeEnd = 0.0
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    var progress: Float = 0{
        willSet(newValue){
            progressLayer.strokeEnd = CGFloat(newValue)
        }
    }
}


