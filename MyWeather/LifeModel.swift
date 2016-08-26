//
//  LifeModel.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/26.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

//生活指数
class LifeModel: NSObject {
    
    var ganmao: Array<String>?
    
    var kongtiao: Array<String>?
    
    var chuanyi: Array<String>?
    
    var yundong: Array<String>?
    
    var ziwaixian: Array<String>?
    
    var wuran: Array<String>?
    
    var xiche: Array<String>?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
