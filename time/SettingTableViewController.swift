//
//  SettingTableViewController.swift
//  time
//
//  Created by Ari on 2016/12/9.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    private lazy var name: [String] = {
        let name = ["数字颜色","数字阴影颜色"];
        return name
    }()
    //点击了更换颜色选项
    var clickChangeNumberColor: ((_ color: UIColor)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return name.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        var tableViewCell :UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") {
            tableViewCell = cell
        } else {
            tableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: "settingCell")
        }
        
        tableViewCell?.textLabel?.text = name[indexPath.row]
        

        return tableViewCell!
    }
}
extension SettingTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Debug.Log(indexPath.row)
        if indexPath.row == 0 {
            let randomColor = UIColor.init(red: CGFloat(arc4random_uniform(255)) / 255, green: CGFloat(arc4random_uniform(255)) / 255, blue: CGFloat(arc4random_uniform(255)) / 255, alpha: 1)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Ari_changeNumberColorNotification), object: nil, userInfo: [Ari_changeNumberColorKey : randomColor])
            self.clickChangeNumberColor?(randomColor)
        }
    }
}

