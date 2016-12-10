//
//  TimeMonitor.swift
//  time
//
//  Created by Ari on 2016/12/8.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class TimeMonitor: UIView {
    
    ///是否需要半透明黑色背景
    var isNeedBlackMask: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    ///黑色背景透明度
    var maskAlpha: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    ///修改控件的颜色
    var numberColor :UIColor? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Ari_changeNumberColorNotification), object: nil, userInfo: [Ari_changeNumberColorKey : numberColor ?? Ari_DefaultColor])
        }
    }
    
    private var hourViewTD:NumberView!
    private var hourViewSD:NumberView!
    private var minutViewTD:NumberView!
    private var minutViewSD:NumberView!
    private var secondViewTD:NumberView!
    private var secondViewSD:NumberView!
    private var firstColon:ColonView!
    private var secColon:ColonView!
    private var timer: Timer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var ratioX: CGFloat!
    private var ratioY: CGFloat!
    private var marginX: CGFloat!
    private var marginY: CGFloat!
    private var numberMargin: CGFloat!
    private func configure(){
        ratioX = frame.width / 620.0
        ratioY = frame.height / 240.0
        marginX = 20 * ratioX
        marginY = 20 * ratioY
        numberMargin = marginX * 0.5
    }
    private func setupUI(){
        backgroundColor = UIColor.clear
        hourViewTD = NumberView()
        hourViewSD = NumberView()
        firstColon = ColonView()
        minutViewTD = NumberView()
        minutViewSD = NumberView()
        secColon = ColonView()
        secondViewTD = NumberView()
        secondViewSD = NumberView()
        self.addSubview(hourViewTD)
        self.addSubview(hourViewSD)
        self.addSubview(firstColon)
        self.addSubview(minutViewTD)
        self.addSubview(minutViewSD)
        self.addSubview(secColon)
        self.addSubview(secondViewTD)
        self.addSubview(secondViewSD)
        self.updateTime()
        timer = Timer.init(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    private func resetSubviewsFrame(){
        //620.0  240.0
        //frame.width  frame.height
        let bigerViewWidth = ratioX * 100
        let smallerViewWidth = ratioX * 50
        let bigerColonWidth = ratioX * 30
        let smallerColonWidth = ratioX * 20
        let bigerHeight = ratioY * 200
        let smallerHeight = bigerHeight * 0.5
        
        hourViewTD.frame = CGRect(x: marginX, y: marginY, width: bigerViewWidth, height: bigerHeight)
        
        let hourViewSDX = marginX + bigerViewWidth + numberMargin
        hourViewSD.frame = CGRect(x: hourViewSDX, y: marginY, width: bigerViewWidth, height: bigerHeight)
        
        let firstColonX = hourViewSDX + bigerViewWidth
        firstColon.frame = CGRect(x: firstColonX, y: marginY, width: bigerColonWidth, height: bigerHeight)
        
        let minutViewTDX = firstColonX + bigerColonWidth
        minutViewTD.frame = CGRect(x: minutViewTDX, y: marginY, width: bigerViewWidth, height: bigerHeight)
        
        let minutViewSDX = minutViewTDX + bigerViewWidth + numberMargin
        minutViewSD.frame = CGRect(x: minutViewSDX, y: marginY, width: bigerViewWidth, height: bigerHeight)
        
        let smallerViewY = marginY + smallerHeight
        let secColonX = minutViewSDX + bigerViewWidth
        secColon.frame =  CGRect(x: secColonX, y: smallerViewY , width: smallerColonWidth, height: smallerHeight)
        
        let secondViewTDX = secColonX + smallerColonWidth
        secondViewTD.frame = CGRect(x: secondViewTDX, y: smallerViewY, width: smallerViewWidth, height: smallerHeight)
        
        let secondViewSDX = secondViewTDX + smallerViewWidth + numberMargin
        secondViewSD.frame = CGRect(x: secondViewSDX, y: smallerViewY, width: smallerViewWidth, height: smallerHeight)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configure()
        self.resetSubviewsFrame()
    }
    
    @objc private func updateTime(){
        func inputNumber(_ view:NumberView,_ number: Int){
            if view.Number != number{
                view.Number = number
            }
        }
        
        let date = Date()
        let calendar = Calendar.init(identifier: .gregorian)
        Debug.Log(calendar)
        let dateComponents = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second,.nanosecond], from: date)
//        let dayTime = (Int(date.timeIntervalSince1970) + (8 * 3600)) % (3600 * 24)
        let hour = dateComponents.hour!
        let hourtd = hour / 10        //时十分位
        let hoursd = hour % 10      //时个位
        
        let minut = dateComponents.minute!
        let minuttd = minut / 10  //分钟十分位
        let minutsd = minut % 10 //分钟个位
        
        let second = dateComponents.second!
        let secondtd = second / 10  //秒十分位
        let secondsd = second % 10 //秒个位
        if secondViewSD.Number != secondsd {
            firstColon.isHidden = !firstColon.isHidden
            secColon.isHidden = !secColon.isHidden
        }
        inputNumber(hourViewTD, hourtd)
        inputNumber(hourViewSD, hoursd)
        inputNumber(minutViewTD, minuttd)
        inputNumber(minutViewSD, minutsd)
        inputNumber(secondViewTD, secondtd)
        inputNumber(secondViewSD, secondsd)
    }
    override func removeFromSuperview() {
        timer.invalidate()
        timer = nil
        super.removeFromSuperview()
    }
    override func draw(_ rect: CGRect) {
        if !isNeedBlackMask {
            return
        }
        let path = UIBezierPath(rect: rect)
        UIColor.init(white: 0, alpha: maskAlpha).setFill()
        path.fill()        
    }
}
