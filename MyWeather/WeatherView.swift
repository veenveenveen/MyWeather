//
//  WeatherView.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import SnapKit

class WeatherView: UIView {
    //添加新城市
    lazy var addCityButton: UIButton = {
        let btn = UIButton(type: UIButtonType.ContactAdd)
        return btn
    }()
    //我的生活
    lazy var myLife: UIButton = {
        let btn = UIButton()
        btn.setTitle("生活", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        btn.titleLabel?.font = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
        return btn
    }()
    //城市名
    lazy var cityNameLable: UILabel = {
        let lab = UILabel()
        lab.text = "西安"
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
        return lab
    }()
    //天气信息
    lazy var weatherInfoLable: UILabel = {
        let lab = UILabel()
        lab.text = "多云转晴"
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        return lab
    }()
    //当前天气
    lazy var currentTemp: UILabel = {
        let lab = UILabel()
        lab.text = "27°"
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(40, weight: UIFontWeightLight)
        return lab
    }()
    
    lazy var upView: UIView = {
        let vv = UIView()
        vv.backgroundColor = UIColor.whiteColor()
        vv.alpha = 0.6
        return vv
    }()
    
    var downView: UIView = {
        let vv = UIView()
        vv.backgroundColor = UIColor.whiteColor()
        vv.alpha = 0.6
        return vv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        for subView in subviews {
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(upView)
        addSubview(downView)
        addSubview(cityNameLable)
        addSubview(weatherInfoLable)
        addSubview(currentTemp)
        addSubview(myLife)
        addSubview(addCityButton)
        
        upView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.top.equalTo(self.snp_top).offset(200)
            make.height.equalTo(1)
        }
        downView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(self.snp_bottom).offset(-50)
            make.height.equalTo(1)
        }
        cityNameLable.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).multipliedBy(0.5).offset(10)
            make.centerY.equalTo(upView.snp_centerY).multipliedBy(0.5)
            
        }
        weatherInfoLable.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1.5).offset(-10)
            make.centerY.equalTo(cityNameLable.snp_centerY).offset(-30)
        }
        currentTemp.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1.5).offset(-10)
            make.centerY.equalTo(cityNameLable.snp_centerY).offset(30)
        }
        myLife.snp_makeConstraints { (make) in
            make.centerY.equalTo(downView.snp_centerY).offset(25)
            make.right.equalTo(downView.snp_right).offset(-15)
        }
        addCityButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(myLife.snp_centerY)
            make.centerX.equalTo(self.snp_centerX)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
}
