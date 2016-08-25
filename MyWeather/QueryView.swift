//
//  QueryView.swift
//  MyWeather
//
//  Created by 黄启明 on 16/8/25.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchEnabled {
    func searchWithText(string: String)
}

class QueryView: UIView, UISearchBarDelegate {
    
    var delegate: SearchEnabled!
    
    lazy var searchBar1: UISearchBar = {
        let sear = UISearchBar()
        sear.delegate = self
        sear.searchBarStyle = .Minimal
        return sear
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = UIColor(colorLiteralRed: 75/255.0, green: 132/255.0, blue: 177/255.0, alpha: 0.98)
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(searchBar1)
        addSubview(cancelButton)
        
        searchBar1.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top).offset(statusBarHeight)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right).offset(-60)
        }
        
        cancelButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(searchBar1.snp_centerY)
            make.right.equalTo(self.snp_right).offset(-15)
        }
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        delegate.searchWithText(searchText)
        searchBar.text = nil
    }

}
