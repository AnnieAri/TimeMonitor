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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true;
//        let numberView = NumberView(frame: CGRect(x: 20, y: 80, width: 100, height: 160))
//        view.addSubview(numberView)
//        numberView.Number = 8
        let monitor = TimeMonitor(frame: view.bounds)
        self.monitor = monitor
        view.addSubview(monitor)
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

