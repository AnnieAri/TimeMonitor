//
//  NumberView.swift
//  time
//
//  Created by Ari on 2016/12/5.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class NumberView: UIView {
    
    var Number: Int? {
        didSet {
            if let num = Number {
                resetNumberViewWithNumber(num)
            }
        }
    }
    
    /// 每个小组件的宽度
    private var viewSide: CGFloat
    private var topView :NumberViewComponents!
    private var bottomView :NumberViewComponents!
    private var leftTopView :NumberViewComponents!
    private var leftBottomView :NumberViewComponents!
    private var rightTopView :NumberViewComponents!
    private var rightBottomView :NumberViewComponents!
    private var middleView :NumberViewComponents!
    private var componentsArr: [NumberViewComponents]?
    override init(frame: CGRect) {
        viewSide = frame.size.width * 0.2
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        //顶部
        topView = NumberViewComponents(frame: CGRect(x: 0, y: 0, width:self.bounds.width, height: viewSide), .top)
        self.addSubview(topView)
        //中部 
        middleView = NumberViewComponents(frame: CGRect(x: 0, y: (self.bounds.height - viewSide) * 0.5, width:self.bounds.width, height: viewSide), .middle)
        self.addSubview(middleView)
        //底部
        bottomView = NumberViewComponents(frame: CGRect(x: 0, y: self.bounds.height - viewSide, width:self.bounds.width, height: viewSide), .bottom)
        self.addSubview(bottomView)
        //
        //左上
        leftTopView = NumberViewComponents(frame: CGRect(x: 0, y: 0, width: viewSide, height: (self.bounds.height) * 0.5), .leftTop)
        self.addSubview(leftTopView)
        //左下
        leftBottomView = NumberViewComponents(frame: CGRect(x: 0, y: (self.bounds.height) * 0.5, width: viewSide, height: (self.bounds.height) * 0.5), .leftBottom)
        self.addSubview(leftBottomView)
        //右上
        rightTopView = NumberViewComponents(frame: CGRect(x: self.bounds.width - viewSide, y: 0, width: viewSide, height: (self.bounds.height) * 0.5), .rightTop)
        self.addSubview(rightTopView)
        //右下
        rightBottomView = NumberViewComponents(frame: CGRect(x: self.bounds.width - viewSide, y: (self.bounds.height) * 0.5, width: viewSide, height: (self.bounds.height) * 0.5), .rightBottom)
        self.addSubview(rightBottomView)
        componentsArr = [topView,middleView,bottomView,leftTopView,leftBottomView,rightTopView,rightBottomView]
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
// MARK: - 数字设置
    private func resetNumberViewWithNumber(_ number: Int){
        func setComponentColorWithPosition(_ position:Int...){
            for view in componentsArr! {
              view.componentsColor = Ari_DefaultColor
            }

            position.forEach { (position) in
                componentsArr![position].componentsColor = Ari_DefaultShadowColor
            }
        }
        switch number {
        case 0:setComponentColorWithPosition(1)
        case 1:setComponentColorWithPosition(0,1,2,3,4)
        case 2: setComponentColorWithPosition(3,6)
        case 3: setComponentColorWithPosition(3,4)
        case 4: setComponentColorWithPosition(0,2,4)
        case 5: setComponentColorWithPosition(4,5)
        case 6: setComponentColorWithPosition(5)
        case 7: setComponentColorWithPosition(1,2,3,4)
        case 8: setComponentColorWithPosition()
        case 9: setComponentColorWithPosition(4)
        default: break
        }
    }
}
