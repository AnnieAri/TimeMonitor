//
//  NumberViewComponents.swift
//  time
//
//  Created by Ari on 2016/12/5.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit
enum Position {
    case top
    case middle
    case bottom
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
}
class NumberViewComponents: UIView {
    private var position :Position?
    var margin :CGFloat
    var componentsColor: UIColor?  {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    convenience init?(frame: CGRect , _ position:Position) {
        self.init(frame: frame)
        self.position = position
    }
    override init(frame: CGRect) {
        let side = frame.size.width <  frame.size.height  ? frame.size.width : frame.size.height
        margin = side * 0.1
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = UIColor.clear
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let position = self.position  else {
            return
        }
        var point1:CGPoint?
        var point2:CGPoint?
        var point3:CGPoint?
        var point4:CGPoint?
        var point5:CGPoint?
        var point6:CGPoint?
        var lineWidth: CGFloat?
//        let singleMargin = margin
        let doubleMargin = margin * 2
        switch  position {
        case Position.top:
            point1 = CGPoint(x: 0 + doubleMargin, y: margin)
            point2 = CGPoint(x: rect.width - doubleMargin, y: margin)
            point3 = CGPoint(x: rect.width - rect.height , y: rect.height - margin)
            point4 = CGPoint(x: rect.height, y:  rect.height - margin)
            point5 = point4
            point6 = point4
            
        case Position.middle:
            lineWidth = rect.height - doubleMargin
            point1 = CGPoint(x: rect.height, y: margin)
            point2 = CGPoint(x: rect.width - rect.height, y: margin)
            point3 = CGPoint(x: rect.width - rect.height + lineWidth! * 0.5, y: rect.height * 0.5)
            point4 = CGPoint(x: rect.width - rect.height , y: rect.height - margin)
            point5 = CGPoint(x: rect.height, y:  rect.height - margin)
            point6 = CGPoint(x: rect.height - lineWidth! * 0.5, y: rect.height * 0.5)
            
        case Position.bottom:
            point1 = CGPoint(x: doubleMargin, y: rect.height - margin)
            point2 = CGPoint(x: rect.width - doubleMargin, y: rect.height - margin)
            point3 = CGPoint(x: rect.width - rect.height , y: margin)
            point4 = CGPoint(x: rect.height, y:  margin)
            point5 = point4
            point6 = point4
            
        case Position.leftTop:
            lineWidth = rect.width - doubleMargin
            point1 = CGPoint(x: 0 + margin, y: doubleMargin)
            point2 = CGPoint(x: 0 + margin, y: rect.height - margin - lineWidth! * 0.4)
            point3 = CGPoint(x: 0 + margin + lineWidth! * 0.4 , y: rect.height - margin)
            point4 = CGPoint(x: rect.width - margin, y: rect.height - margin - lineWidth! * 0.6)
            point5 = CGPoint(x: rect.width - margin, y: lineWidth! + doubleMargin)
            point6 = point5
            
        case .leftBottom:
            lineWidth = rect.width - doubleMargin
            point1 = CGPoint(x: margin, y: rect.height - doubleMargin)
            point2 = CGPoint(x: margin, y: lineWidth! * 0.4 + margin)
            point3 = CGPoint(x: margin + lineWidth! * 0.4 , y: margin)
            point4 = CGPoint(x: rect.width - margin, y: lineWidth! * 0.6 + margin)
            point5 = CGPoint(x: rect.width - margin, y: rect.height - doubleMargin - lineWidth!)
            point6 = point5
            
        case Position.rightTop:
            lineWidth = rect.width - doubleMargin
            point1 = CGPoint(x: rect.width - margin, y: doubleMargin)
            point2 = CGPoint(x: rect.width - margin, y: rect.height - margin - lineWidth! * 0.4)
            point3 = CGPoint(x: rect.width -  margin - lineWidth! * 0.4, y: rect.height - margin)
            point4 = CGPoint(x: margin, y: rect.height - margin - lineWidth! * 0.6)
            point5 = CGPoint(x: margin, y: lineWidth! + doubleMargin)
            point6 = point5
            
        case Position.rightBottom:
            lineWidth = rect.width - doubleMargin
            point1 = CGPoint(x: rect.width - margin, y: rect.height - doubleMargin)
            point2 = CGPoint(x: rect.width - margin, y: lineWidth! * 0.4 + margin)
            point3 = CGPoint(x: rect.width -  margin - lineWidth! * 0.4, y: margin)
            point4 = CGPoint(x: margin, y: lineWidth! * 0.6 + margin)
            point5 = CGPoint(x: margin, y: rect.height - doubleMargin - lineWidth!)
            point6 = point5
        }
        let path = UIBezierPath()
        path.lineJoinStyle = .round
        path.move(to: point1!)
        path.addLine(to: point2!)
        path.addLine(to: point3!)
        path.addLine(to: point4!)
        path.addLine(to: point5!)
        path.addLine(to: point6!)
        path.close()
        if let color = componentsColor{
            color.setFill()
        } else {
            Ari_DefaultColor.setFill()
        }
        path.fill()

    }
 

}
