//
//  ViewController.swift
//  time
//
//  Created by Ari on 2016/12/5.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit
// MARK: - 主代码
class ViewController: UIViewController {
    ///表盘
    internal var monitor :TimeMonitor!
    //手势
    internal var leftEdgeGes:UIScreenEdgePanGestureRecognizer!
    //侧滑选择 tableView
    lazy var settingTableVC: SettingTableViewController = {
        let settingTableVC = SettingTableViewController();
        return settingTableVC
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true;
        //设置布局
        setupUI()
        
        setupMonitor()
        
        setupSettingSlider()
        // 添加侧滑手势
        leftEdgeGes = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(setting))
        leftEdgeGes.edges = .left
        view.addGestureRecognizer(leftEdgeGes)
        
    }
    
    func  setupUI(){
        let bgImageView = UIImageView(image: UIImage(contentsOfFile: Bundle.main.path(forResource: "miku", ofType: "jpeg")!))
        bgImageView.frame = view.bounds
        view.addSubview(bgImageView)
        
        let monitor = TimeMonitor(frame: view.bounds)
        self.monitor = monitor
        view.addSubview(monitor)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    ///旋转屏幕
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width < size.height {
            monitor.frame.size = CGSize(width: size.width, height: size.width * size.width / size.height )
        } else {
            monitor.frame.size = size;
        }
    }
}
// MARK: - 监控器相关
extension ViewController {
    func setupMonitor(){
        monitor.isNeedBlackMask = true
        monitor.maskAlpha = 0.2
    }
}

// MARK: - 侧滑手势 与 弹回手势
extension ViewController {
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
}
// MARK: - 侧滑相关功能
extension ViewController {
    func  setupSettingSlider(){
        settingTableVC.view.frame = CGRect(x: -200, y: 0, width: 200, height: UIScreen.main.bounds.height)
        addChildViewController(settingTableVC)
        view.addSubview(settingTableVC.view)
        settingTableVC.clickChangeNumberColor = { [weak self](color) in
            self?.monitor.numberColor = color
        }
    }
  
}
