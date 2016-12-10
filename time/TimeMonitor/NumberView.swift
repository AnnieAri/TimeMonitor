//
//  NumberView.swift
//  time
//
//  Created by Ari on 2016/12/5.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class NumberView: UIView {
    var numberColor :UIColor = Ari_DefaultColor {
        didSet {
            resetNumberViewWithNumber(Number!)
        }
    }
    var shadowNumberColor :UIColor = Ari_DefaultShadowColor {
        didSet {
            resetNumberViewWithNumber(Number!)
        }
    }
    
    var Number: Int? {
        didSet {
                resetNumberViewWithNumber(Number)
        }
    }
    override var frame: CGRect {
        didSet {
            viewSide = frame.size.width * 0.2
        }
    }
    /// 每个小组件的宽度
    private var viewSide: CGFloat = 0
    private var topView :NumberViewComponents!
    private var bottomView :NumberViewComponents!
    private var leftTopView :NumberViewComponents!
    private var leftBottomView :NumberViewComponents!
    private var rightTopView :NumberViewComponents!
    private var rightBottomView :NumberViewComponents!
    private var middleView :NumberViewComponents!
    private var componentsArr: [NumberViewComponents]?
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(chageColor), name: NSNotification.Name(rawValue: Ari_changeNumberColorNotification), object: nil)
    
    }
    @objc func chageColor(_ noti:Notification){
        numberColor = noti.userInfo![Ari_changeNumberColorKey] as! UIColor
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    override func layoutSubviews() {
         super.layoutSubviews()
        topView.frame = CGRect(x: 0, y: 0, width:self.bounds.width, height: viewSide)
        middleView.frame = CGRect(x: 0, y: (self.bounds.height - viewSide) * 0.5, width:self.bounds.width, height: viewSide)
        bottomView.frame = CGRect(x: 0, y: self.bounds.height - viewSide, width:self.bounds.width, height: viewSide)
        leftTopView.frame = CGRect(x: 0, y: 0, width: viewSide, height: (self.bounds.height) * 0.5)
        leftBottomView.frame = CGRect(x: 0, y: (self.bounds.height) * 0.5, width: viewSide, height: (self.bounds.height) * 0.5)
        rightTopView.frame = CGRect(x: self.bounds.width - viewSide, y: 0, width: viewSide, height: (self.bounds.height) * 0.5)
        rightBottomView.frame =  CGRect(x: self.bounds.width - viewSide, y: (self.bounds.height) * 0.5, width: viewSide, height: (self.bounds.height) * 0.5)
    }
// MARK: - 数字设置
    private func resetNumberViewWithNumber(_ number: Int?){
        func setComponentColorWithPosition(_ position:Int...){
            for view in componentsArr! {
              view.componentsColor = numberColor
            }

            position.forEach { (position) in
                componentsArr![position].componentsColor = shadowNumberColor
            }
        }
        guard let num = number else {
            setComponentColorWithPosition(0,2,3,4,5,6)
            return
        }
        switch num {
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
