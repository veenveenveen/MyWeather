//
//  WeatherView.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class WeatherView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "my_cell"
    
    private var flowLayout = UICollectionViewFlowLayout()
    
    private var collectionView: UICollectionView!
    
    var todayInfo = TodayInfoView()
    
    //添加新城市
    lazy var addCityButton: UIButton = {
        let btn = UIButton(type: UIButtonType.ContactAdd)
        return btn
    }()
    //我的生活
    lazy var myLife: UIButton = {
        let btn = UIButton()
        btn.setTitle("生活指数", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        btn.titleLabel?.font = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
        return btn
    }()
    //城市名
    private lazy var cityNameLable: UILabel = {
        let lab = UILabel()
        lab.text = "西安"
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
        return lab
    }()
    //更新时间
    private lazy var updateTime: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.lightGrayColor()
        lab.font = UIFont.systemFontOfSize(15, weight: UIFontWeightThin)
        return lab
    }()
    //农历moonDate
    private lazy var moonDate: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(15, weight: UIFontWeightThin)
        return lab
    }()
    //PM2.5
    private lazy var pm25: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(15, weight: UIFontWeightThin)
        return lab
    }()
    //空气质量
    private lazy var quality: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)
        lab.layer.cornerRadius = 3
        lab.layer.masksToBounds = true
        lab.textAlignment = .Center
        return lab
    }()
    //天气信息
    private lazy var weatherInfoLable: UILabel = {
        let lab = UILabel()
        lab.text = "多云转晴"
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        return lab
    }()
    //当前天气
    private lazy var currentTemp: UILabel = {
        let lab = UILabel()
        lab.text = "27°"
        lab.textColor = UIColor.whiteColor()
        lab.font = UIFont.systemFontOfSize(40, weight: UIFontWeightLight)
        return lab
    }()
    
    private lazy var upView: UIView = {
        let vv = UIView()
        vv.backgroundColor = UIColor.whiteColor()
        vv.alpha = 0.6
        return vv
    }()
    
    private var downView: UIView = {
        let vv = UIView()
        vv.backgroundColor = UIColor.whiteColor()
        vv.alpha = 0.6
        return vv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - 设置界面
    private func setUI() {
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
        addSubview(updateTime)
        addSubview(pm25)
        addSubview(quality)
        addSubview(moonDate)
        
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
            make.centerY.equalTo(upView.snp_centerY).multipliedBy(0.5).offset(-28)
        }
        moonDate.snp_makeConstraints { (make) in
            make.centerX.equalTo(cityNameLable.snp_centerX)
            make.top.equalTo(cityNameLable.snp_bottom).offset(10)
        }
        pm25.snp_makeConstraints { (make) in
            make.centerX.equalTo(cityNameLable.snp_centerX).offset(-17)
            make.top.equalTo(moonDate.snp_bottom).offset(10)
        }
        quality.snp_makeConstraints { (make) in
            make.centerY.equalTo(pm25.snp_centerY).offset(1.5)
            make.left.equalTo(pm25.snp_right).offset(10)
            make.width.equalTo(25)
            make.height.equalTo(17)
        }
        weatherInfoLable.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1.5).offset(-10)
            make.centerY.equalTo(upView.snp_centerY).multipliedBy(0.5).offset(-30)
        }
        currentTemp.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1.5).offset(-10)
            make.centerY.equalTo(upView.snp_centerY).multipliedBy(0.5).offset(30)
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
        updateTime.snp_makeConstraints { (make) in
            make.centerY.equalTo(myLife.snp_centerY)
            make.left.equalTo(self.snp_left).offset(15)
        }
    }
    
    //MARK: - 设置collectionView
    private func setCollectionView() {
        flowLayout.itemSize = CGSizeMake(screenW, 200)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 5, 0)
        flowLayout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: CGRectMake(0, 201, screenW, frame.size.height - 201 - 51), collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.clearColor()
        //设置代理
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(WeatherCollectionCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(collectionView)
    }
    
    //MARK: - 设置数据
    func setDataWith(json: JSON) {
//        print(json)
        cityNameLable.text = json["result"]["data"]["realtime"]["city_name"].stringValue
        weatherInfoLable.text = json["result"]["data"]["realtime"]["weather"]["info"].stringValue
        currentTemp.text = json["result"]["data"]["realtime"]["weather"]["temperature"].stringValue + "°"
        
        let timeStr = (json["result"]["data"]["realtime"]["time"].stringValue as NSString)
        let subTimeStr = timeStr.substringToIndex(timeStr.length - 3)
        updateTime.text = "\(subTimeStr)" + " 更新"
        
        pm25.text = "PM2.5 [" + json["result"]["data"]["pm25"]["pm25"]["pm25"].stringValue + "]"
        moonDate.text = "农历 : " + json["result"]["data"]["realtime"]["moon"].stringValue
        let qualityText = json["result"]["data"]["pm25"]["pm25"]["quality"].stringValue
        if qualityText == "优" {
            quality.backgroundColor = UIColor(red: 111/255.0, green: 196/255.0, blue: 68/255.0, alpha: 1.0)
            quality.text = qualityText
        }
        else {
            quality.backgroundColor = UIColor.orangeColor()
            quality.text = qualityText
        }
        todayInfo.lineView.alpha = 0.6
        let str1 = "今天：最高气温 \(json["result"]["data"]["weather"][0]["info"]["day"][2].stringValue)°，"
        let str2 = "最低气温 \(json["result"]["data"]["weather"][0]["info"]["night"][2].stringValue)°。"
        todayInfo.todayLable.text = str1 + str2
        let richu = "日出： \(json["result"]["data"]["weather"][0]["info"]["day"][5].stringValue)\n"
        let riluo = "日落： \(json["result"]["data"]["weather"][0]["info"]["night"][5].stringValue)\n"
        let shidu = "湿度： \(json["result"]["data"]["realtime"]["weather"]["humidity"].stringValue)%\n"
        let fengsu = "风速： \(json["result"]["data"]["realtime"]["wind"]["direct"].stringValue)  \(json["result"]["data"]["realtime"]["wind"]["power"].stringValue)"
        todayInfo.otherInfo.text = richu + riluo + shidu + fengsu
        todayInfo.lineView2.alpha = 0.6
        
        let day1 = getDayWithNumber(1, json: json)
        let day2 = getDayWithNumber(2, json: json)
        let day3 = getDayWithNumber(3, json: json)
        let day4 = getDayWithNumber(4, json: json)
        todayInfo.otherDay.text = day1 + day2 + day3 + day4
    }
    
    func getDayWithNumber(num: Int, json: JSON) -> String {
        let aa1 = "星期\(json["result"]["data"]["weather"][num]["week"].stringValue)    "
        let aa2 = "\(json["result"]["data"]["weather"][num]["info"]["day"][1].stringValue)    "
        let aa3 = "\(json["result"]["data"]["weather"][num]["info"]["day"][2].stringValue)/"
        let aa4 = "\(json["result"]["data"]["weather"][num]["info"]["night"][2].stringValue)    "
        return aa1 + aa3 + aa4 + aa2 + "\n"
    }
    
    //MARK: - 数据源 与 代理方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! WeatherCollectionCell
        todayInfo.frame = cell.contentView.bounds
        cell.contentView.addSubview(todayInfo)
        return cell
        
    }
}
//MARK: - 自定义cell
class WeatherCollectionCell: UICollectionViewCell {
    
//    var lab = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        lab.text = "afdad"
//        lab.textAlignment = .Center
//        lab.textColor = UIColor.whiteColor()
//        lab.frame = contentView.bounds
//        contentView.addSubview(lab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
