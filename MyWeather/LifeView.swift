//
//  LifeView.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/25.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import SwiftyJSON

extension UILabel {
    convenience init(color: UIColor) {
        self.init()
        textColor = color
        textAlignment = .Left
        if screenH < 600 {
            font = UIFont.systemFontOfSize(13, weight: UIFontWeightLight)
        }
        else {
            font = UIFont.systemFontOfSize(15, weight: UIFontWeightLight)
        }
        numberOfLines = 0
        sizeToFit()
    }
}

class LifeView: UIView {
    
    private lazy var title: UILabel = {
        let lab = UILabel()
        lab.text = "生活指数"
        lab.textColor = UIColor.whiteColor()
        return lab
    }()
    
    lazy var backButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("返回", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(16)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        return btn
    }()
    
    private var ganmao: UILabel = UILabel(color: UIColor.whiteColor())
    
    private var kongtiao: UILabel = UILabel(color: UIColor.whiteColor())
    
    private var chuanyi: UILabel = UILabel(color: UIColor.whiteColor())
    
    private var yundong: UILabel = UILabel(color: UIColor.whiteColor())
    
    private var ziwaixian: UILabel = UILabel(color: UIColor.whiteColor())
    
    private var wuran: UILabel = UILabel(color: UIColor.whiteColor())
    
    private var xiche: UILabel = UILabel(color: UIColor.whiteColor())
    
    private lazy var topLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line1: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line3: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line4: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line5: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line6: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    
    private lazy var line7: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0.6
        return v
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = UIColor.clearColor()
//        backgroundColor = UIColor(colorLiteralRed: 75/255.0, green: 132/255.0, blue: 177/255.0, alpha: 1.0)
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    
        addSubview(title)
        addSubview(backButton)
        addSubview(topLine)
        addSubview(ganmao)
        addSubview(ganmao)
        addSubview(kongtiao)
        addSubview(chuanyi)
        addSubview(yundong)
        addSubview(ziwaixian)
        addSubview(wuran)
        addSubview(xiche)
        addSubview(line1)
        addSubview(line2)
        addSubview(line3)
        addSubview(line4)
        addSubview(line5)
        addSubview(line6)
        addSubview(line7)
        
        title.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top).offset(statusBarHeight + 5)
        }
        topLine.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom).offset(10)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(1)
        }
        backButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(title.snp_centerY)
            make.right.equalTo(self.snp_right).offset(-15)
        }
        ganmao.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(topLine.snp_bottom).offset(5)
        }
        line1.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(ganmao.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        kongtiao.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(line1.snp_bottom).offset(5)
        }
        line2.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(kongtiao.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        chuanyi.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(line2.snp_bottom).offset(5)
        }
        line3.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(chuanyi.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        yundong.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(line3.snp_bottom).offset(5)
        }
        line4.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(yundong.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        ziwaixian.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(line4.snp_bottom).offset(5)
        }
        line5.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(ziwaixian.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        wuran.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(line5.snp_bottom).offset(5)
        }
        line6.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(wuran.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        xiche.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(line6.snp_bottom).offset(5)
        }
        line7.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(xiche.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
    }
    //MARK: - 设置数据
    func setDataWith(json: JSON) {
        ganmao.text = getTextWith("感冒指数", str2: "ganmao", js: json)
        kongtiao.text = getTextWith("空调指数", str2: "kongtiao", js: json)
        chuanyi.text = getTextWith("穿衣指数", str2: "chuanyi", js: json)
        yundong.text = getTextWith("运动指数", str2: "yundong", js: json)
        ziwaixian.text = getTextWith("紫外线", str2: "ziwaixian", js: json)
        wuran.text = getTextWith("污染指数", str2: "wuran", js: json)
        xiche.text = getTextWith("洗车指数", str2: "xiche", js: json)
    }
    
    func getTextWith(str1: String, str2: String, js: JSON) -> String {
        return "\(str1)\(":") \(js["result"]["data"]["life"]["info"][str2][0].stringValue)\n\t\t\t\t\t\t\t\(js["result"]["data"]["life"]["info"][str2][1].stringValue)"
    }
}
