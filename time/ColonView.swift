//
//  ColonView.swift
//  time
//
//  Created by Ari on 2016/12/8.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class ColonView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let radius = rect.width / 4
        let CirX = rect.width / 2 - radius
        let firstCirY = rect.height / 3 - radius
        let secCirY = rect.height / 3 * 2 - radius
        let firstCircle = UIBezierPath(ovalIn: CGRect(x: CirX, y: firstCirY, width: radius * 2, height: radius * 2))
        let secCircle = UIBezierPath(ovalIn: CGRect(x: CirX, y: secCirY, width: radius * 2, height: radius * 2))
        Ari_DefaultColor.setFill()
        firstCircle.fill()
        secCircle.fill()
    }
 

}
