//
//  AppDetailInformationCell.swift
//  appstore1
//
//  Created by Rey Matsunaga on 2/15/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit

class AppDetailInformationCell: BaseCell {
    var appInfo: [AppInformation]? {
        didSet {
            self.setupViews()
        }
    }

    let textView: UILabel = {
        let tv = UILabel()
        tv.text = "Information"
        tv.font = tv.font.withSize(14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func configureStack(_ stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
    }
    
    private func createCell(_ cell: AppInformation) -> [UILabel] {
        // Initialize Labels within section
        let cellName: UILabel = {
            let name = UILabel()
            name.translatesAutoresizingMaskIntoConstraints = false
            if let cellName = cell.Name {
                name.text = cellName + ": "
            }
            name.textColor = UIColor.lightGray
            name.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.thin)
            return name
        }()
        
        let cellValue: UILabel = {
            let value = UILabel()
            value.translatesAutoresizingMaskIntoConstraints = false
            value.text = cell.Value
            value.textColor = .gray
            value.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.thin)
//            value.font = UIFont.init(name: "HelveticaNeue-Thin", size: 10)


            return value
        }()
        

        

        
        return [cellName, cellValue]
        
    }
    
    override func setupViews() {
        super.setupViews()
        // Configure CellHolders
        let cellStack = UIStackView()
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        cellStack.axis = .vertical
        cellStack.spacing = 5
        cellStack.distribution = .fillEqually
        guard let count = appInfo?.count else { return }
        for index in 0...(count - 1) {
            let info = appInfo?[index]
            let row = UIStackView(arrangedSubviews: createCell(info!))
            configureStack(row)
            cellStack.addArrangedSubview(row)
        }
        // Configure row
        addSubview(dividerLineView)
        addSubview(textView)
        addSubview(cellStack)
        
        // Vertical Stack constraints
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        cellStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        cellStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        cellStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        dividerLineView.widthAnchor.constraint(equalToConstant: frame.width - 14).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: cellStack.bottomAnchor, constant: 12).isActive = true
    }
    

}
