//
//  TimeMonitor.swift
//  time
//
//  Created by Ari on 2016/12/8.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class TimeMonitor: UIView {
    
    
    var hourViewTD:NumberView!
    var hourViewSD:NumberView!
    var minutViewTD:NumberView!
    var minutViewSD:NumberView!
    var secondViewTD:NumberView!
    var secondViewSD:NumberView!
    var firstColon:ColonView!
    var secColon:ColonView!
    var timer: Timer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = UIColor.black
        hourViewTD = NumberView(frame: CGRect(x: 20, y: 80, width: 100, height: 160))
        self.addSubview(hourViewTD)
        hourViewSD = NumberView(frame: CGRect(x: 130, y: 80, width: 100, height: 160))
        self.addSubview(hourViewSD)
        firstColon = ColonView(frame: CGRect(x: 230, y: 80, width: 30, height: 160))
        self.addSubview(firstColon)
        minutViewTD = NumberView(frame: CGRect(x: 260, y: 80, width: 100, height: 160))
        self.addSubview(minutViewTD)
        minutViewSD = NumberView(frame: CGRect(x: 370, y: 80, width: 100, height: 160))
        self.addSubview(minutViewSD)
        secColon = ColonView(frame: CGRect(x: 470, y: 160, width: 20, height: 80))
        self.addSubview(secColon)
        secondViewTD = NumberView(frame: CGRect(x: 490, y: 160, width: 50, height: 80))
        self.addSubview(secondViewTD)
        secondViewSD = NumberView(frame: CGRect(x: 550, y: 160, width: 50, height: 80))
        self.addSubview(secondViewSD)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        func inputNumber(_ view:NumberView,_ number: Int){
            if view.Number != number{
                view.Number = number
            }
        }
        
        let date = Date()
        let dayTime = (Int(date.timeIntervalSince1970) + (8 * 3600)) % (3600 * 24)
        Debug.Log(dayTime)
        let hour = dayTime / 3600
        let hourtd = hour / 10        //时十分位
        let hoursd = hour % 10      //时个位
        
        let minut = dayTime % 3600 / 60
        let minuttd = minut / 10  //分钟十分位
        let minutsd = minut % 10 //分钟个位
        
        let second = dayTime % 3600 % 60
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
}
