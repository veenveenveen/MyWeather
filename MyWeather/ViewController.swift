//
//  ViewController.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, SearchEnabled {
    
    var weatherView: WeatherView!
    
    var queryView: QueryView!
    
    var lifeView: LifeView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setWeatherView()
        queryWithtext("西安")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWeatherView() {
        weatherView = WeatherView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        view.addSubview(weatherView)
        
        queryView = QueryView(frame: CGRectMake(0, view.bounds.height, view.bounds.width, view.bounds.height))
        view.addSubview(queryView)
        queryView.delegate = self
        
        lifeView = LifeView(frame: CGRectMake(0, view.bounds.height, view.bounds.width, view.bounds.height))
        view.addSubview(lifeView)
        
        queryView.cancelButton.addTarget(self, action: #selector(cancelQuery), forControlEvents: .TouchUpInside)
        
        weatherView.addCityButton.addTarget(self, action: #selector(searchNewCity), forControlEvents: .TouchUpInside)
        weatherView.myLife.addTarget(self, action: #selector(lifeButtonClick), forControlEvents: .TouchUpInside)
        lifeView.backButton.addTarget(self, action: #selector(backButtonClick), forControlEvents: .TouchUpInside)
    }
    
    func searchNewCity() {
        UIView.animateWithDuration(0.3) {
            self.queryView.frame.origin.y = 0
        }
    }
    
    func cancelQuery() {
        queryView.searchBar1.resignFirstResponder()
        UIView.animateWithDuration(0.3) {
            self.queryView.frame.origin.y = self.view.bounds.size.height
        }
    }
    
    func lifeButtonClick() {
        print("qq")
        UIView.animateWithDuration(0.3) {
            self.lifeView.frame.origin.y = 0
        }
    }
    
    func backButtonClick() {
        UIView.animateWithDuration(0.3) {
            self.lifeView.frame.origin.y = self.view.bounds.size.height
        }
    }
    //代理方法实现 
    func searchWithText(string: String) {
        queryWithtext(string)
        cancelQuery()
    }
    
    func queryWithtext(string: String) {
        let url = NSURL(string: "https://op.juhe.cn/onebox/weather/query")
        Alamofire.request(.GET, url!, parameters: ["cityname": string, "key": "c81b96413f9684a29d0ee3d4f2bb1048"], encoding: .URL, headers: nil).responseJSON { (result) in
            if let v = result.result.value {
                let json = JSON(v)
                //设置数据
                self.weatherView.setDataWith(json)
                self.lifeView.setDataWith(json)
            }
        }
    }
    
    
}

