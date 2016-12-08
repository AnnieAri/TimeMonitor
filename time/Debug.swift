//
//  Debug.swift
//  SwiftExample
//
//  Created by Ari on 2016/11/16.
//  Copyright © 2016年 Ari. All rights reserved.
//

import UIKit

class Debug: NSObject {
    // TODO: 为调试修改  上架改为false
    private static let debug = true
    
    class  func Log (_ value: Any? = nil , fileName : String = #file, line : Int32 = #line ){
        
        if debug {
            
            print("fileName：\((fileName as NSString).lastPathComponent)  [line]：\(line)")
            if let value = value {
                print("DebugInfo：\(value)  \n")
            }
        }
        
    }
}
