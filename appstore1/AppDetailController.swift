//
//  AppDetailController.swift
//  appstore1
//
//  Created by Rey Matsunaga on 2/8/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            navigationItem.title = app?.Name

            if let id = app?.Id {
                guard let appStoreUrl = URL(string: "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)") else { return }
                
                URLSession.shared.dataTask(with:appStoreUrl) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    do {
                        let decodedApp = try JSONDecoder().decode(App.self, from: data!)
                        self.app? = decodedApp
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    } catch let err {
                        print(err)
                    }
                    }.resume()
            }
        }
    }
    
    private let headerId = "headerId"
    let cellId = "detailCellId"
    let descriptionCellId = "descriptionCellId"
    let informationCellId = "informationCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
        collectionView?.register(AppDetailInformationCell.self, forCellWithReuseIdentifier: informationCellId)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: informationCellId, for: indexPath) as! AppDetailInformationCell
            cell.appInfo = app?.appInformation
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
            cell.app = app
            return cell
        }
    }
    
    private func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0,  attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
        
        if let desc = app?.description {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
            
        }
        return attributedText

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            let size = CGSize.init(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            
            let rect = descriptionAttributedText().boundingRect(with: size, options: options, context: nil)
            return CGSize.init(width: view.frame.width, height: rect.height + 30)
            
        } else if indexPath.item == 2 {
            
            return CGSize.init(width: view.frame.width, height: 210)
        }
        
        
        return CGSize.init(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppDetailHeader
        header.app = self.app
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
}


class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            if let imageName = app?.ImageName {
                imageView.image = UIImage.init(named: imageName)
            }
            if let title = app?.Name {
                nameLabel.text = title
            }
            if let text = app?.Category {
                categoryLabel.text = text
            }
            if let price = app?.Price {
                buyButton.setTitle("$\(String(price))", for: .normal)
            }
            
        }
    }
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 16.0)
        
        return name
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .gray
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.cornerRadius = 5
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(buyButton)
        addSubview(dividerLineView)
        imageView.backgroundColor = .yellow
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|-14-[v0(100)]", views: imageView)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, categoryLabel)
        addConstraintsWithFormat("V:|-14-[v0(20)]-8-[v1(10)]", views: nameLabel, categoryLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat("V:[v0(32)]-15-[v1(34)]-8-|", views: buyButton, segmentedControl)
        
        addConstraintsWithFormat("H:[v0(60)]-14-|", views: buyButton)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(0.5)]|", views: dividerLineView)
        
    }
    
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
