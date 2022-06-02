//
//  HSA_Moudle.swift
//  HSA_Moudle
//
//  Created by jikuan zhang on 2022/6/1.
//

import Foundation
import HSRouter

public class HSA_Moudle: RouterMoudleProtocol {
    public var moudle: String {"HSA_Moudle"}
    
    public var scheme: String {"hsapps"}
    
    public var pathDic: [String : String] {
        ["path/a":"HSA_Controller",
         "path/a/detail":"HSA_DetailController"]
    }
    
    public class func registerPages(){
        HSA_Moudle().registerPages()
    }
}
