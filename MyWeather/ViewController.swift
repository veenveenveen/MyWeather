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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let cellID = "my_cell"
    
    var weatherView: WeatherView!
    
    
    var flowLayout = UICollectionViewFlowLayout()
//
    var collectionView: UICollectionView!
    
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
        
        flowLayout.itemSize = CGSizeMake(screenW, 20)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 5, 0)
        flowLayout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: CGRectMake(0, 201, screenW, screenH - 201 - 51), collectionViewLayout: flowLayout)

        print(collectionView.frame)
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        view.addSubview(weatherView)
        weatherView.addSubview(collectionView)
    }
    
    func queryClick() {
        let url = NSURL(string: "https://op.juhe.cn/onebox/weather/query")
        Alamofire.request(.GET, url!, parameters: ["cityname": "虞城", "key": "c81b96413f9684a29d0ee3d4f2bb1048"], encoding: .URL, headers: nil).responseJSON { (result) in
            if let v = result.result.value {
                //                print(v)
                let json = JSON(v)
                print(json)
            }
        }
    }
    
    
    
    //MARK: - 数据源 与 代理方法
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        let lab = UILabel()
        lab.text = "afdad"
        lab.frame = cell.contentView.bounds
        cell.contentView.addSubview(lab)
        
        return cell
        
    }
    


}

