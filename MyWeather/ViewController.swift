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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var weatherView: WeatherView!
    
    var queryView: QueryView!
    
    var lifeView: LifeView!
    
    //出现提示框
    var alertView: UIAlertController!
    
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
        lifeView.alpha = 0
        view.addSubview(lifeView)
        
        queryView.cancelButton.addTarget(self, action: #selector(cancelQuery), forControlEvents: .TouchUpInside)
        
        weatherView.addCityButton.addTarget(self, action: #selector(searchNewCity), forControlEvents: .TouchUpInside)
        weatherView.myLife.addTarget(self, action: #selector(lifeButtonClick), forControlEvents: .TouchUpInside)
        lifeView.backButton.addTarget(self, action: #selector(backButtonClick), forControlEvents: .TouchUpInside)
    }
    
    func searchNewCity() {
        
        UIView.animateWithDuration(0.3) {
            self.queryView.frame.origin.y = 0
            self.weatherView.alpha = 0
            self.queryView.searchBar1.alpha = 1
        }
    }
    
    func cancelQuery() {
        
        queryView.searchBar1.resignFirstResponder()
        UIView.animateWithDuration(0.3) {
            self.queryView.frame.origin.y = self.view.bounds.size.height
            self.weatherView.alpha = 1.0
            self.queryView.searchBar1.alpha = 0
            
        }
    }
    
    func lifeButtonClick() {
        UIView.animateWithDuration(0.3) {
            self.lifeView.frame.origin.y = 0
            self.weatherView.alpha = 0
            self.lifeView.alpha = 1.0
        }
    }
    
    func backButtonClick() {
        UIView.animateWithDuration(0.3) {
            self.lifeView.frame.origin.y = self.view.bounds.size.height
            self.weatherView.alpha = 1
            self.lifeView.alpha = 0
        }
    }
    //代理方法实现 
    func searchWithText(string: String) {
        queryWithtext(string)

    }
    
    func queryWithtext(string: String) {
        weatherView.alpha = 0
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1.0
        let url = NSURL(string: "https://op.juhe.cn/onebox/weather/query")
        Alamofire.request(.GET, url!, parameters: ["cityname": string, "key": "c81b96413f9684a29d0ee3d4f2bb1048"], encoding: .URL, headers: nil).responseJSON { (result) in
            if let v = result.result.value {
                let json = JSON(v)
//                print(json)
//                if let dict = json["result"]["data"]["life"]["info"].dictionaryObject {
//                    let life = LifeModel(dict: dict)
//                    print(life.chuanyi)
//                }
                if json["error_code"].stringValue == "207302" {
                    self.alertView = UIAlertController(title: "提示", message: "查询不到该城市的信息", preferredStyle: .Alert)
                    self.alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(self.alertView, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    return
                }
                if json["error_code"].stringValue == "207301" {
                    self.alertView = UIAlertController(title: "提示", message: "错误的查询城市名", preferredStyle: .Alert)
                    self.alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(self.alertView, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    return
                }
                if json["error_code"].stringValue == "207303" {
                    self.alertView = UIAlertController(title: "提示", message: "网络错误，请检查网络后重试", preferredStyle: .Alert)
                    self.alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(self.alertView, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    return
                }
                self.cancelQuery()
                self.weatherView.alpha = 1.0
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
                //设置数据
                self.weatherView.setDataWith(json)
                self.lifeView.setDataWith(json)
            }
        }
    }
}

