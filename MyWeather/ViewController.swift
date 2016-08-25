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

class ViewController: UIViewController {
    
    var weatherView: WeatherView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setWeatherView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWeatherView() {
        weatherView = WeatherView(frame: CGRectMake(0, 0, screenW, screenH))
        view.addSubview(weatherView)
        
        weatherView.addCityButton.addTarget(self, action: #selector(queryClick), forControlEvents: .TouchUpInside)
    }
    
    func queryClick() {
        let url = NSURL(string: "https://op.juhe.cn/onebox/weather/query")
        Alamofire.request(.GET, url!, parameters: ["cityname": "虞城", "key": "c81b96413f9684a29d0ee3d4f2bb1048"], encoding: .URL, headers: nil).responseJSON { (result) in
            if let v = result.result.value {
                let json = JSON(v)
                //设置数据
                self.weatherView.setDataWith(json)
            }
        }
    }
    
    
}

