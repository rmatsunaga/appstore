//
//  AppDetailDescription.swift
//  appstore1
//
//  Created by Rey Matsunaga on 2/15/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit

class AppDetailDescriptionCell: BaseCell{
    let textView: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
    }
}
