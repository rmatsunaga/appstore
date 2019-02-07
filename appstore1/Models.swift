//
//  Models.swift
//  appstore1
//
//  Created by Rey Matsunaga on 1/30/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit
import Foundation

struct AllCategories: Decodable {
    let bannerCategory: AppCategory?
    let categories: [AppCategory]?
}

struct AppCategory: Decodable {
    
    var name: String?
    var apps: [App]?
    var type: String?

    static func fetchFeaturedApps(completionHandler: @escaping (AllCategories) -> Void) {
        guard let appStoreUrl = URL(string: "https://api.letsbuildthatapp.com/appstore/featured") else { return }
        
        URLSession.shared.dataTask(with:appStoreUrl) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            do {
                let decodedApps = try JSONDecoder().decode(AllCategories.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(decodedApps)
                }
            } catch let err {
                print(err)
            }
        }.resume()
    }
}

struct App: Decodable {
    var Id: Int?
    var Name: String?
    var Category: String?
    var Price: Double?
    var ImageName: String?
}

