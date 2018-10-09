//
//  ProgressBarView.swift
//  progressBar
//
//  Created by ashika shanthi on 1/4/18.
//  Copyright © 2018 ashika shanthi. All rights reserved.
//

import UIKit
class ProgressBarView: UIView {
    
    var bgPath: UIBezierPath!
    var shapeLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    
    var progress: Float = 0 {
        willSet(newValue)
        {
            progressLayer.strokeEnd = CGFloat(newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgPath = UIBezierPath()
        self.simpleShape()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bgPath = UIBezierPath()
        self.simpleShape()
    }
    
    func simpleShape()
    {
        createCirclePath()
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = frame
        shapeLayer.position = self.center
        shapeLayer.path = bgPath.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = frame
        progressLayer.position = self.center
        progressLayer.path = bgPath.cgPath
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = 10
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.gray.cgColor
        progressLayer.strokeEnd = 0.0
        
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    private func createCirclePath()
    {
        
        let x = self.frame.width/2
        let y = self.frame.height/2
        let center = CGPoint(x: x, y: y)
        print(x,y,center)
        bgPath.addArc(withCenter: center, radius: x, startAngle: CGFloat(0), endAngle: CGFloat(6.28), clockwise: true)
        bgPath.close()
    }
}

