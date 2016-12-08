//
//  ViewController.swift
//  time
//
//  Created by Ari on 2016/12/5.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let numberView = NumberView(frame: CGRect(x: 20, y: 80, width: 100, height: 160))
//        view.addSubview(numberView)
//        numberView.Number = 8
        let monitor = TimeMonitor(frame: view.bounds)
        UIApplication.shared.isIdleTimerDisabled = true;
        view.addSubview(monitor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

