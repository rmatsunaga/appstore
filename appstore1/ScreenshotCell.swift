//
//  ScreenshotCell.swift
//  appstore1
//
//  Created by Rey Matsunaga on 2/13/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit

class ScreenshotCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    private let cellId = "cellId"
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        addSubview(dividerLineView)
        addConstraintsWithFormat("V:|[v0][v1(1)]|", views: collectionView, dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = app?.Screenshots?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        if let imageName = app?.Screenshots?[indexPath.item] {
            cell.image.image = UIImage.init(named: imageName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 240, height: frame.height - 28)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class ScreenshotImageCell: BaseCell {
        
        let image: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = .green
            return iv
        }()
        
        override func setupViews() {
            super.setupViews()
            layer.masksToBounds = true
            
            addSubview(image)
            addConstraintsWithFormat("V:|[v0]|", views: image)
            addConstraintsWithFormat("H:|[v0]|", views: image)
        }
        
    }
}
