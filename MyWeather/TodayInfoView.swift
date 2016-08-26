//
//  TodayInfoView.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/26.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import SnapKit

class TodayInfoView: UIView {
    
    lazy var todayLable: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.sizeToFit()
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
        return lab
    }()
    lazy var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0
        return v
    }()
    lazy var lineView2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        v.alpha = 0
        return v
    }()
    lazy var otherInfo: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.sizeToFit()
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
        return lab
    }()
    lazy var otherDay: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.sizeToFit()
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
        return lab
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func setUI() {
        todayLable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(todayLable)
        addSubview(lineView)
        addSubview(otherInfo)
        addSubview(lineView2)
        addSubview(otherDay)
        todayLable.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top).offset(5)
            make.left.equalTo(self.snp_left).offset(15)
            make.right.equalTo(self.snp_right).offset(-15)
        }
        lineView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.top.equalTo(todayLable.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        otherInfo.snp_makeConstraints { (make) in
            make.centerX.equalTo(lineView.snp_centerX)
            make.top.equalTo(lineView.snp_bottom).offset(5)
        }
        lineView2.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.top.equalTo(otherInfo.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        otherDay.snp_makeConstraints { (make) in
            make.left.equalTo(lineView.snp_left).offset(5)
            make.top.equalTo(lineView2.snp_bottom).offset(5)
        }        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
