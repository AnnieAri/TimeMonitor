//
//  ViewController.swift
//  time
//
//  Created by Ari on 2016/12/5.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var monitor :TimeMonitor!
//    let settingTableView = 
    lazy var settingTableVC: SettingTableViewController = {
        let settingTableVC = SettingTableViewController();
        return settingTableVC
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true;
        
         let bgImageView = UIImageView(image: UIImage(contentsOfFile: Bundle.main.path(forResource: "miku2", ofType: "jpg")!))
        bgImageView.frame = view.bounds
        view.addSubview(bgImageView)
//        let numberView = NumberView(frame: CGRect(x: 20, y: 80, width: 100, height: 160))
//        view.addSubview(numberView)
//        numberView.Number = 8
        let monitor = TimeMonitor(frame: view.bounds)
        monitor.isNeedBlackMask = true
        monitor.maskAlpha = 0.2
        self.monitor = monitor
        view.addSubview(monitor)
        let leftEdgeGes = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(setting))
        leftEdgeGes.edges = .left
        monitor.addGestureRecognizer(leftEdgeGes)
        settingTableVC.view.frame = CGRect(x: -200, y: 0, width: 200, height: UIScreen.main.bounds.height)
        addChildViewController(settingTableVC)
        view.addSubview(settingTableVC.view)
        settingTableVC.clickChangeNumberColor = { [weak self](color) in
            self?.monitor.numberColor = color
        }
    }
    func setting(_ ges:UIPanGestureRecognizer){
        Debug.Log("pan\(ges.location(in: ges.view!))")
        settingTableVC.view.frame.origin.x = ges.location(in: ges.view!).x - 200
        if settingTableVC.view.frame.origin.x > 0 {
            settingTableVC.view.frame.origin.x = 0
        }
        if ges.state == .ended {
            Debug.Log("拖动结束")
            UIView.animate(withDuration: 0.25, animations: { 
                if self.settingTableVC.view.frame.origin.x > -100 {
                    self.settingTableVC.view.frame.origin.x = 0
                } else {
                    self.settingTableVC.view.frame.origin.x  = -200
                }
            }, completion: nil)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if settingTableVC.view.frame.origin.x == 0 {
            UIView.animate(withDuration: 0.25, animations: { 
                self.settingTableVC.view.frame.origin.x = -200
            }, completion: { (completion) in
                Debug.Log(completion)
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        
//    }
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            if size.width < size.height {
                monitor.frame.size = CGSize(width: size.width, height: size.width * size.width / size.height )
            } else {
                monitor.frame.size = size;
            }
    }
}

